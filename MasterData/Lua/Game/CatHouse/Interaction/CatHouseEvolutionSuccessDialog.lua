---
--- Created by Eric.
--- DateTime: 2022/1/4 17:58
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
---@type CatHouseComponent
local CatHouseComponent-- = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseComponent, Constants.CatHouseEntityId)
local PinchAndDragInputModule = CS.Engine.UI.PinchAndDragInputModule
local ConstantsCatHouse = import("Game.CatHouse.ConstantsCatHouse")
local cs_coroutine      = require 'XLua.cs_coroutine'
local Yielders        = CS.Engine.Lib.Yielders
local CatHouseMgr = import('Game.CatHouse.CatHouseMgr')
local GachaponUtils = import('Game.Gachapon.GachaponUtils')
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

------------ import ------------

------------ define ------------
local EffectEnum = { ---基因数据类型对应特效名
    ["1"] = "AnimRoot/Effect/UIFX_CatHouseBtnDataNode_Lv",
    ["2"] = "AnimRoot/Effect/UIFX_CatHouseBtnDataNode_Lan",
    ["3"] = "AnimRoot/Effect/UIFX_CatHouseBtnDataNode_Hong",
    ["4"] = "AnimRoot/Effect/UIFX_CatHouseBtnDataNode_Huang",
}
------------ define ------------


---@class CatHouseEvolutionSuccessDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field BtnShare                      	UnityEngine.RectTransform
---@field FontStyleWithIconButton       	UnityEngine.RectTransform
---@field TouchCatArea                  	UnityEngine.RectTransform
---@field Empty                         	UnityEngine.RectTransform
---@field PartDataList                  	UnityEngine.RectTransform
---@field CatHouseBtnDataNode           	UnityEngine.RectTransform
---@field AppearanceDataList            	UnityEngine.RectTransform
---@field TextType                      	UnityEngine.UI.Text
---@field TextName                      	UnityEngine.UI.Text
local CatHouseEvolutionSuccessDialog = Class("CatHouseEvolutionSuccessDialog")
function CatHouseEvolutionSuccessDialog:__init()
    self.oldCatData = {}
    self.nowCatData = {}
    self.nowCatModel = nil
    self.appearanceDataNodeList = {}
    self.partDataNodeList = {}
    self.coList = {}
end

function CatHouseEvolutionSuccessDialog:__delete()
    self.oldCatData = nil
    self.nowCatData = nil
    self.nowCatModel = nil

    self.appearanceDataNodeList = nil
    self.partDataNodeList = nil
    self.coList = nil

    self.controller = nil
end

function CatHouseEvolutionSuccessDialog:Awake()
    CatHouseComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseComponent, Constants.CatHouseEntityId)

end

function CatHouseEvolutionSuccessDialog:OnFocus(focus)
end

function CatHouseEvolutionSuccessDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    local argument = self.controller.Argument
    if not isNull(argument.parameters) then
        self.oldCatData = clone(argument.parameters.oldCatData)
        self.nowCatData = clone(argument.parameters.nowCatData)
        self.nowCatModel = argument.parameters.nowCatModel
        local oldGeneList = {}
        local nowGeneList = {}
        for k, v in pairs(self.oldCatData.genes) do
            oldGeneList[v.geneId] = v
        end
        for k, v in pairs(self.nowCatData.genes) do
            nowGeneList[v.geneId] = v
            CatHouseComponent:AddUnlockedGene(v.geneId)
        end
        local data = clone(self.nowCatData)
        CfUtils.SetActive(self.BtnShare.gameObject, Constants.MODULE_SWITCH.SHARE)
        SetButtonAction(self.BtnShare, function()
            CriWareUtils.PlaySe(UISheets.UI_Menu.path, UISheets.UI_Menu.ui_button_share)
            GameUtils.ShareScreenShot({
                prefabPath = 'Prefabs/CatHouse/Interaction/CatHouseEvolutionShare.prefab',
                prefabArgs = data,
                isWaitCompleted = true,
                finishCB   = function(filePath)
                    GachaponUtils.OpenDialogAction(Constants.UITypeIds.CommonSharePreviewDialog, {
                        filePath  = filePath,
                        shareType = Constants.ShareType.CAT_EVOLUTION,
                    })
                end
            })
        end)
        ---old有而now没有的，则为解锁失败的基因
        for k, v in pairs(oldGeneList) do
            if nowGeneList[k] == nil then
                local failGeneData = v
                failGeneData["isFail"] = true
                table.insert(self.nowCatData.genes, failGeneData)
            end
        end

        self.TouchCatArea.gameObject:EnsureComponent(typeof(PinchAndDragInputModule)).onSingleFingerDrag:AddListener(function(delta)
            --if self.isInTheInteraction then
                if isNull(delta) then
                    return
                end
                local y = delta.y
                local x = delta.x
                local absX = math.abs(x)
                local absY = math.abs(y)
                if math.abs(absX - absY) <= 2 then
                    return
                end
                if math.abs(y) <= math.abs(x) then
                    local direction = x < 0 and 1 or -1
                    local eulerAngles = Vector3.New(0, 1, 0)
                    eulerAngles.y = eulerAngles.y * direction * math.abs(x)
                    self.nowCatModel.transform:Rotate(eulerAngles)
                end
            --end

        end)
        SetButtonAction(self.TouchCatArea, function ()
            UIModule.BackDialog()
        end)
        SetButtonAction(self.FontStyleWithIconButton, function ()
            UIModule.BackDialog()
        end)

        self:FreshBaseUI(self.nowCatData)

    end
    return coWait
end

function CatHouseEvolutionSuccessDialog:FreshBaseUI(catData)
    self.TextName.text = catData.name
    local catVo = CfUtils.GetCfVo(AutoIds.IdSetting1906, "CatHouseCatVo", catData.petId)
    self.TextType.text = catVo.name
    local classifyGene = CatHouseComponent:Process2ClassifyGenes(catData.genes)
    for k, v in pairs(classifyGene) do
        if k == 1 then--部件基因以外的
            local goCount = self.AppearanceDataList.transform.childCount - 1 --减去默认prefab的数量
            if goCount > #v then
                for i = #v + 1, goCount do --复用时隐藏多出来的
                    KTool.SetActive(self.appearanceDataNodeList[i], false)
                end
            end
            for i = 1, #v do
                local go
                go = self.appearanceDataNodeList[i]
                if not go then
                    go = CfUtils.InstantiateGo(self.CatHouseBtnDataNode, self.AppearanceDataList.gameObject)
                    go.name = "DataNode"..i
                    self.appearanceDataNodeList[i] = go.gameObject
                end
                local nodeEnv = CfUtils.GetLuaScr(self.appearanceDataNodeList[i], "Game.CatHouse.Interaction.CatHouseDataNode")
                if nodeEnv then
                    --local luaIndex = index + 1
                    --local currentCatData = self.catDataList[self.selectedCatIndex]
                    local data = v[i]
                    --local isChild = currentCatData.age == ConstantsCatHouse.BornType.Baby
                    nodeEnv:FreshAdult(data, catData)
                    local co = cs_coroutine.start(function()
                        nodeEnv:PlayAnimator(i, 0.1, 0.5, function ()
                            local catGeneData = CfUtils.GetCfVo(AutoIds.IdSetting1902, "CatHouseCatDataVo", data.geneId)
                            KTool.SetActive(go.transform:Find(EffectEnum[checkString(catGeneData.kind)]), true)
                        end)
                    end)
                    nodeEnv:SetBtnCallBack(function()
                        CatHouseMgr:GetInstance():ShowCatHousDataDetailsNode(go, data)
                    end)
                    table.insert(self.coList, co)
                end
                KTool.SetActive(go, true)

            end
        elseif k == 2 then--部件基因
            local goCount = self.PartDataList.transform.childCount - 1 --减去默认prefab的数量
            if goCount > #v then
                for i = #v + 1, goCount do --复用时隐藏多出来的
                    KTool.SetActive(self.partDataNodeList[i], false)
                end
            end
            KTool.SetActive(self.Empty, #v == 0)

            for i = 1, #v do
                local go
                go = self.partDataNodeList[i]
                if not go then
                    go = CfUtils.InstantiateGo(self.CatHouseBtnDataNode, self.PartDataList.gameObject)
                    go.name = "DataNode"..i
                    self.partDataNodeList[i] = go.gameObject
                end
                local nodeEnv = CfUtils.GetLuaScr(self.partDataNodeList[i], "Game.CatHouse.Interaction.CatHouseDataNode")
                if nodeEnv then
                    --local luaIndex = index + 1
                    --local currentCatData = self.catDataList[self.selectedCatIndex]
                    local data = v[i]
                    --local isChild = currentCatData.age == ConstantsCatHouse.BornType.Baby
                    nodeEnv:FreshAdult(data, catData)
                    local co = cs_coroutine.start(function()
                        nodeEnv:PlayAnimator(i, 0.1, 0.5, function ()
                            local isFail = false--progress >= 1
                            if data.isFail then
                                isFail = true
                            end
                            if not isFail then
                                local catGeneData = CfUtils.GetCfVo(AutoIds.IdSetting1902, "CatHouseCatDataVo", data.geneId)
                                KTool.SetActive(go.transform:Find(EffectEnum[checkString(catGeneData.kind)]), true)
                            end
                        end)
                    end)
                    nodeEnv:SetBtnCallBack(function()
                        CatHouseMgr:GetInstance():ShowCatHousDataDetailsNode(go, data)
                    end)
                    table.insert(self.coList, co)
                end
                KTool.SetActive(go, true)
            end
        end
    end
end

function CatHouseEvolutionSuccessDialog:DisposeCo()
    for i, v in pairs(self.coList) do
        cs_coroutine.stop(v)
    end
end

function CatHouseEvolutionSuccessDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:DisposeCo()
        CatHouseComponent = nil
        self.nowCatModel.transform.localRotation = ConstantsCatHouse.CatModelInteractionLocalRotation.Adult
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return CatHouseEvolutionSuccessDialog