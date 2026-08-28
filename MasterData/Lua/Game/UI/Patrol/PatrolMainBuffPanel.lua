---
--- Created by Eric.
--- DateTime: 2021/10/12 11:39
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local MazeMgr = import('Game.Maze.MazeMgr'):GetInstance()
local UIModule = CS.Engine.UI.UIModule
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require 'XLua.cs_coroutine'
local Yielders = CS.Engine.Lib.Yielders
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance

------------ import ------------

------------ define ------------

------------ define ------------


---@class PatrolMainBuffPanel
---@field ImgBgBlack                    	UnityEngine.RectTransform
---@field ImgGetReward                  	UnityEngine.RectTransform
---@field FontStyleButton               	UnityEngine.RectTransform
---@field BuffNode                      	UnityEngine.RectTransform
---@field Layout                        	UnityEngine.RectTransform
local PatrolMainBuffPanel = Class("PatrolMainBuffPanel")
function PatrolMainBuffPanel:__init()
    self.buffNodeList = {}
    self.data = {}
    self.selectIndex = -1 --luaIndex

end

function PatrolMainBuffPanel:__delete()
    self.buffNodeList = nil
    self.data = nil
    self.selectIndex = nil


    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function PatrolMainBuffPanel:SetBtnCallBack(cb)
    self.btnAction = cb
end

function PatrolMainBuffPanel:Awake()
    --KTool.SetRenderFeatureActiveByName(Constants.RenderFeatureNames.BLUR, true)
    UIEventProxy.Create(self.controller.gameObject).onPointerClick = function()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end
end

function PatrolMainBuffPanel:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:FreshBaseUI()
    end))
    return coWait
end

function PatrolMainBuffPanel:FreshBaseUI()
    self.isSelected = false
    print("--11---"..table.dump(MazeMgr.relicOptions))
    self.data = MazeMgr.relicOptions
    --self.data = {
    --    20031,20032,20123
    --}
    local optionCount = table.count(self.data)
    local isShow = optionCount > 0
    --KTool.SetActive(self.controller.gameObject, isShow)
    if isShow then
        KTool.SetActive(self.ImgGetReward, false)
        KTool.SetActive(self.FontStyleButton, false)
        self.selectIndex = -1
        --SetButtonAction(self.FontStyleButton, function ()
        --    --MazeMgr:MazeChooseRelic(self.data[self.selectIndex], function ()
        --    --    for i = 1, #self.buffNodeList do
        --    --        if i ~= self.selectIndex then
        --    --            local preGo = self.buffNodeList[i]
        --    --            local preGoEnv = CfUtils.GetLuaScr(preGo, "Game.UI.Patrol.PatrolMainBuffCellNode")
        --    --            preGoEnv:PlayExitAnim()
        --    --            KTool.SetActive(self.buffNodeList[i], false)
        --    --            KTool.SetActive(self.FontStyleButton, false)
        --    --        end
        --    --    end
        --    --    KTool.SetActive(self.ImgGetReward, true)
        --    --    self.isSelected = true
        --    --end)
        --end)
        SetButtonAction(self.ImgBgBlack, function ()
            if self.isSelected then
                UIModule.BackDialog()
            end
        end)
        local goCount = self.Layout.transform.childCount - 1 --减去默认prefab的数量
        if goCount > optionCount then
            for i = optionCount + 1, goCount do --复用时隐藏多出来的
                KTool.SetActive(self.buffNodeList[i], false)
            end
        end
        for i = 1, optionCount do
            local go
            go = self.buffNodeList[i]
            if not go then
                go = CfUtils.InstantiateGo(self.BuffNode, self.Layout.gameObject)
                go.name = "BuffNode"..i
                self.buffNodeList[i] = go.gameObject
            end
            local goEnv = CfUtils.GetLuaScr(go, "Game.UI.Patrol.PatrolMainBuffCellNode")
            local isSelected = self.selectIndex == i

            goEnv:FreshSelectStatus(isSelected)
            goEnv:FreshBaseUI(self.data[i])
            KTool.SetActive(go, true)

            goEnv:SetBtnCallBack(function ()
                if i ~= self.selectIndex then
                    goEnv:FreshSelectStatus(true)
                    KTool.SetActive(self.FontStyleButton, true)
                    if self.selectIndex > 0 then
                        local preGo = self.buffNodeList[self.selectIndex]
                        local preGoEnv = CfUtils.GetLuaScr(preGo, "Game.UI.Patrol.PatrolMainBuffCellNode")
                        preGoEnv:FreshSelectStatus(false)
                    end
                    self.selectIndex = i
                end
            end)
            goEnv:SetBtnGetCallBack(function ()
                UIRaycastBlocker:AddCondition("PatrolMainBuffPanelChoose")
                xTry(
                        function()
                            MazeMgr:CheckIsFinish()
                            MazeMgr:MazeChooseRelic(self.data[self.selectIndex], function ()
                                local co = cs_coroutine.start(function ()
                                    for i = 1, #self.buffNodeList do
                                        if i ~= self.selectIndex then
                                            local preGo = self.buffNodeList[i]
                                            local preGoEnv = CfUtils.GetLuaScr(preGo, "Game.UI.Patrol.PatrolMainBuffCellNode")
                                            preGoEnv:PlayCancelExitAnim()
                                            --KTool.SetActive(self.buffNodeList[i], false)
                                            --KTool.SetActive(self.FontStyleButton, false)
                                        end
                                        goEnv:FreshSelectStatus(false)
                                    end
                                    goEnv:PlaySelectExitAnim()
                                    cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.583))--动画间隔
                                    for i = 1, #self.buffNodeList do--隐藏多余按钮
                                        if i ~= self.selectIndex then
                                            KTool.SetActive(self.buffNodeList[i], false)
                                        end
                                    end
                                    goEnv:PlayEnterAnim()
                                    KTool.SetActive(self.ImgGetReward, true)
                                    self.isSelected = true
                                    UIRaycastBlocker:RemoveCondition("PatrolMainBuffPanelChoose")
                                end)
                            end, function ()
                                UIRaycastBlocker:RemoveCondition("PatrolMainBuffPanelChoose")
                            end)
                        end,
                        function()
                            UIRaycastBlocker:RemoveCondition("PatrolMainBuffPanelChoose")
                        end
                )

            end)
        end
        --for i = 1, optionCount do
        --    local go = self.buffNodeList[i]
        --    CfUtils.PlayDelayShowAnimate(go.transform:Find("AnimRoot "), i, 0.05, 0.1)
        --end

    end
end

function PatrolMainBuffPanel:FreshSelectStatus(isSelected)

end

function PatrolMainBuffPanel:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if not isNull(self.controller.Argument.parameters) then
            if not isNull(self.controller.Argument.parameters.closeCB) then
                self.controller.Argument.parameters.closeCB()
            end
        end
        --KTool.SetRenderFeatureActiveByName(Constants.RenderFeatureNames.BLUR, false)
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return PatrolMainBuffPanel