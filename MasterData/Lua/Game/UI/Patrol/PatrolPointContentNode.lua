
---
--- Created by Eric.
--- DateTime: 2021/10/13 10:01
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local MazeMgr = import('Game.Maze.MazeMgr'):GetInstance()

------------ import ------------

------------ define ------------
--local UISwitchStatus = {--关卡类型表Id对应switch上的状态
--    ["6"] = 1,
--    ["4"] = 2,
--    ["2"] = 3,
--    ["1"] = 4,
--    ["5"] = 5,
--    ["7"] = 6,
--}
------------ define ------------


---@class PatrolPointContentNode
---@field ImgRole                       	UnityEngine.RectTransform
---@field TextTitle                     	UnityEngine.UI.Text
---@field ImgIcon                       	Engine.UI.ImageAlterable
---@field Event                         	UnityEngine.RectTransform
---@field Current                       	UnityEngine.RectTransform
---@field ImgBgBoss                     	UnityEngine.RectTransform
---@field IconNode                      	UnityEngine.RectTransform
---@field Layout                        	UnityEngine.RectTransform
---@field LayoutChoice                  	UnityEngine.RectTransform
---@field Next                          	UnityEngine.RectTransform
local PatrolPointContentNode = Class("PatrolPointContentNode")
function PatrolPointContentNode:__init()
    self.iconNodeMap = {}
    self.data = {}
end

function PatrolPointContentNode:__delete()
    self.iconNodeMap = nil
    self.data = nil


    self.controller = nil
end



function PatrolPointContentNode:Awake()

end

function PatrolPointContentNode:FreshBaseUI(data)
    self.data = data
    --printInfo(self.controller.gameObject.name.."===data>>"..table.dump(data))
    KTool.SetActive(self.Current, data.isCurrent)
    KTool.SetActive(self.Next, not data.isCurrent)
    if data.isCurrent then
        KTool.SetActive(self.Event, not data.isMain)
        KTool.SetActive(self.ImgRole, data.isMain)
        if not data.isMain then
            local chooseData = MazeMgr:GetCurrentChooseInfo(data.key)
            local typeData = CfUtils.GetCfVo(AutoIds.IdSetting351, "PatrolPointTypeVo",chooseData.type)
            self.ImgIcon:LoadSprite(typeData.icon)
            self.TextTitle.text = typeData.name
        end
    else
        local isBoss = table.count(MazeMgr.nextInfo) == 1 and checkNumber(MazeMgr.nextInfo["1"].type) == 3
        KTool.SetActive(self.ImgBgBoss, isBoss)
        KTool.SetActive(self.LayoutChoice, not isBoss)
        if not isBoss then
            local nextData = MazeMgr.nextInfo
            local goCount = self.Layout.transform.childCount - 1 --减去默认prefab的数量
            if goCount > #nextData then
                for i = #nextData + 1, goCount do --复用时隐藏多出来的
                    KTool.SetActive(self.iconNodeMap[i], false)
                end
            end
            for i = 1, table.count(nextData) do
                local k = checkString(i)
                local v = nextData[k]
                local go
                go = self.iconNodeMap[k]
                if not go then
                    go = CfUtils.InstantiateGo(self.IconNode, self.Layout.gameObject)
                    go.name = "iconNode"..k
                    self.iconNodeMap[k] = go.gameObject
                end
                local goEnv = CfUtils.GetLuaScr(go, "Game.UI.Patrol.PatrolPointContentIconNode")
                local typeData = CfUtils.GetCfVo(AutoIds.IdSetting351, "PatrolPointTypeVo",v.type)
                local alpha = self:IsNextIcon(k, data.key) and 1 or 0.2
                local iconData = {
                    iconPath = typeData.previewIcon,
                    alpha = data.isMain and 0.7 or alpha
                }
                goEnv:FreshBaseUI(iconData)
                KTool.SetActive(go, true)
            end
        end
    end
    self:SetPosition(data)
end

function PatrolPointContentNode:IsNextIcon(k, key)--这边的规则与后端保持一致
    k = checkNumber(k)
    key = checkNumber(key)
    --local currentPos = checkNumber(MazeMgr.currentPos)
    if k >= key and k <= key + 2 then
        return true
    else
        return false
    end
end

function PatrolPointContentNode:SetPosition(data)
    local pointGo
    if data.isCurrent and not data.isPre then
        pointGo = self.data.posGroup.transform:Find(tostring(MazeMgr.currentFloor))
    elseif data.isPre then
        pointGo = self.data.posGroup.transform:Find(tostring(MazeMgr.currentFloor - 1))
    else
        pointGo = self.data.posGroup.transform:Find(tostring(checkNumber(MazeMgr.currentFloor) + 1))
    end
    if pointGo then
        self.controller.transform.localPosition = pointGo.transform.localPosition
        if data.isMain then
            self.controller.transform.rotation = pointGo.transform.rotation
            if data.isCurrent then
                if data.isPre then
                    CfUtils.PlayAnimator(self.ImgRole.transform, "PatrolPointExit")
                    print("PatrolPointExit=======")
                else
                    CfUtils.PlayAnimator(self.ImgRole.transform, "Enter")
                    print("PatrolPointEnter=======")
                end
                --CfUtils.PlayAnimator(self.ImgRole, "Enter")
            --elseif data.isPre then
            --    print("PatrolPointExit=======")
            --    CfUtils.PlayAnimator(self.ImgRole, "PatrolPointExit")
            end
        end

    end
end

function PatrolPointContentNode:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return PatrolPointContentNode