---@class AffectionEventListPanel : AffectionEventListPanel_Generate
---##################### 【AffectionEventListPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【AffectionEventListPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local AffectionEventListPanel = require "AffectionEventListPanel_Generate"

function AffectionEventListPanel:InitLogic(data)
    self.eventBoxObjList = {} --事件格子列表
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    GameMsgMgr:regEvent(GameMsgType.RefreshEventMsg, self, self.Refresh)
end

--function AffectionEventListPanel:StartCreating(time)
--
--end

--function AffectionEventListPanel:StartEnter(time)
--
--end

--function AffectionEventListPanel:StartRemoving(time)
--
--end

--function AffectionEventListPanel:StartExit(time)
--
--end

function AffectionEventListPanel:OnOpen(data, initiative)
    -- LuaLogger.ds("可随机事件=========", tablex.dump(Me:getAffectionEvent()))
    -- LuaLogger.ds("未完成委托=======", tablex.dump(Me:getDelegateEvent()))
    -- LuaLogger.ds("任务列表=======", tablex.dump(Me:getMissionList()))
    -- LuaLogger.ds("房间内角色======", tablex.dump(Me:getRolePreRoom()))
    -- LuaLogger.ds("触发器列表========", tablex.dump(Me:getTriggerEventMap()))
    self:setView()
end

--设置显示
function AffectionEventListPanel:setView()
    local delegateEventList = Me:getDelegateEvent() or {} --获取委托列表
    --根据配置生成格子
    local commissionMax = Config.GetConfigInfo("commissionMax")     --最大格子数
    self.eventBoxObjList = {}
    -- FillTemplateContent 在对象池不足时会走 InstantiateAsync 异步创建，
    -- 需等全部格子就绪后再绑定委托数据和点击事件
    self:FillTemplateContent(self.eventBox, self.eventList, commissionMax, function(index, eventBox)
        local temp = {
            obj = eventBox,
            index = index,
            eventId = nil,
        }
        table.insert(self.eventBoxObjList, temp)
        eventBox:SetActive(true)
        eventBox.btn.scaleButton.onClick:RemoveAllListeners()
        eventBox.isOn:SetActive(false)
        eventBox.isNull:SetActive(true)
        eventBox.indexTxt.text.text = index
        eventBox.canvasGroup.alpha = 0
        DLuaTimer:DoAfter(index * 0.025, function()
            eventBox.canvasGroup:DOFade(1, 0.25)
        end)
    end, function()
        for key, value in pairs(delegateEventList) do
            local eventBoxData = self.eventBoxObjList[key]
            if eventBoxData then
                local taskData = Me:getMissionListById(value)
                if taskData then
                    if taskData.state == GE.MissionState.Unclaimed then
                        eventBoxData.obj.isComplete:SetActive(true)
                        eventBoxData.obj.isOpen:SetActive(false)
                    else
                        eventBoxData.obj.isComplete:SetActive(false)
                        eventBoxData.obj.isOpen:SetActive(true)
                    end
                end

                --根据数据更新对应格子的显示
                eventBoxData.eventId = value
                local eventConfig = Config.GetHomeEventInfo(value)
                eventBoxData.obj.isOn:SetActive(true)
                eventBoxData.obj.isNull:SetActive(false)
                eventBoxData.obj.eventNameTxt.text.text = eventConfig.eventTitle
                eventBoxData.obj.eventMsgTxt.text.text = eventConfig.commissionDesc

                local CutRolePath = string.format(Config.SpritePath.BannerRolePath, eventConfig.character, "character_"..eventConfig.character)
                eventBoxData.obj.roleImg:SetActive(true)
                self:LoadSpriteAsync(CutRolePath, eventBoxData.obj.roleImg.image)

                eventBoxData.obj.btn.scaleButton.onClick:RemoveAllListeners()
                eventBoxData.obj.btn.scaleButton.onClick:AddListener(function()
                    --委托事件点击
                    local eventId = eventBoxData.eventId
                    UIMgr:popUICover("AffectionEventPanel", {id = eventConfig.character, mode = 2, eventId = eventId})
                end)
            end
        end
    end)
end

--刷新
function AffectionEventListPanel:Refresh()
    self:setView()
end

--function AffectionEventListPanel:OnClose(initiative)
--
--end

function AffectionEventListPanel:OnDestroy()
    self:play2DSound(self.btnSoundPath)
	GameMsgMgr:unRegEvent(GameMsgType.RefreshEventMsg, self, self.Refresh)
    self.super:OnDestroy(self)
end

--function AffectionEventListPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function AffectionEventListPanel:mask_Button_onClick(mask)
    self:play2DSound(self.btnSoundPath)
    --TODO: 需要做动画
    UIMgr:closeUI(self)
end

return AffectionEventListPanel
