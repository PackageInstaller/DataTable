---
--- Created by Eric.
--- DateTime: 2022/3/16 10:46
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)

------------ import ------------

------------ define ------------
local BOOL_FLAG = "Select"

local SwitchImageStatusStar = {
    Unlock = 1,
    Lock = 2
}
local SwitchImageStatusBg = {
    Normal = 1,
    Select = 2
}
local SwitchTextStatusTitle = {
    Normal = 1,
    Select = 2
}
------------ define ------------


---@class DailyQuestCell
---@field ImgDecorate                   	UnityEngine.RectTransform
---@field SelectGroup                   	UnityEngine.RectTransform
---@field LockGroup                     	UnityEngine.RectTransform
---@field TxtNumber                     	Game.Native.Common.UISwitchTextMeshPro
---@field ImgStar3                      	UnityEngine.RectTransform
---@field ImgStar2                      	UnityEngine.RectTransform
---@field ImgStar1                      	UnityEngine.RectTransform
---@field StarList                      	UnityEngine.RectTransform
---@field ImgBg                         	Game.Native.Common.UISwitchImage
local DailyQuestCell = Class("DailyQuestCell")
function DailyQuestCell:__init()
    self.btnAction = nil
    self.data = nil
    self.animator = nil
    self.txtDiff = nil
end

function DailyQuestCell:__delete()
    self.btnAction = nil
    self.data = nil
    self.animator = nil
    self.txtDiff = nil
    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function DailyQuestCell:SetBtnCallBack(cb)
    self.btnAction = cb
end

function DailyQuestCell:Awake()
    self.animator = KTool.GetComponent(self.controller.gameObject, typeof(CS.UnityEngine.Animator))
    self.animation = KTool.GetComponent(self.controller.gameObject, typeof(CS.UnityEngine.Animation))
    self.txtDiff = self.ImgBg.transform.parent:Find("TxtDifficulty")
    SetButtonAction(self.ImgBg.transform.parent.gameObject, function()
        if type(self.btnAction) == 'function' then
            self.btnAction(self.data.questId)
        end
        --if type(self.toast) == 'function' then
        --    self.toast()
        --end
    end)
end

---SetLockState
---设置锁定状态的逻辑
---@param isLock boolean
function DailyQuestCell:SetLockState(isLock)
    KTool.SetActive(self.LockGroup, isLock)
    KTool.SetActive(self.SelectGroup, not isLock)
    KTool.SetActive(self.ImgDecorate, not isLock)
    KTool.SetActive(self.StarList, not isLock)
    --CfUtils.SetUISwitchImage(self.TxtNumber, isLock and 3 or 1)
    --CfUtils.SetUISwitchImage(self.ImgBg, isLock and 3 or 1)
end

function DailyQuestCell:FreshBaseUI(data)
    self.data = data
    local questVo = QuestConfMgr:GetInstance():GetQuestVoById(data.questId)
    local isUnlockQuest = QuestConfMgr:GetInstance():IsUnlockQuest(data.questId)
    local type = GoodsUtils.GetIdType(data.questId, Constants.IDArea.Quests)
    CfUtils.FillText(self.TxtNumber.transform, questVo.label)
    if type == Constants.IDType.QuestAdvancedTraining then
        --self.StarList = self.controller.gameObject.transform:Find("Btn/ImgComplete")
        local isPass = QuestConfMgr:GetInstance():IsPassQuest(data.questId)
        local ImgComplete = self.controller.gameObject.transform:Find("Btn/ImgComplete")
        KTool.SetActive(ImgComplete, isPass)
        self:SetLockState(not isUnlockQuest)
        return
    end
    self:SetLockState(not isUnlockQuest)

    if type == Constants.IDType.QuestMediumPT then
        KTool.SetActive(self.StarList.gameObject,false)
    end

    if isUnlockQuest then
        local conditions = QuestConfMgr:GetInstance():GetQuestConditions(data.questId)
        if conditions then
            local count = 0
            for k, v in pairs(conditions) do
                local isComplete = QuestConfMgr:GetInstance():IsCompleteCondition(data.questId, v.id)
                if isComplete then
                    count = count + 1
                end
            end
            for i = 1, 3 do
                local isUnlockStar = i <= count
                CfUtils.SetUISwitchImage(self["ImgStar" .. i], isUnlockStar and SwitchImageStatusStar.Unlock or SwitchImageStatusStar.Lock)
                --CfUtils.PlayAnimator(self["ImgStar" .. i], isUnlockStar and "Open" or "Default")
            end
        end
    end
end


function DailyQuestCell:FreshSelectStatus(isSelected)
    if not isNull(self.animator) then
        ---@type UnityEngine.Animator
        local animator = self.animator
        animator:SetInteger(BOOL_FLAG, isSelected and 1 or 0)
    end
    if not isNull(self.animation) then
        local type = GoodsUtils.GetIdType(self.data.questId, Constants.IDArea.Quests)
        if type == Constants.IDType.QuestMediumPT then
            self.animation:Play(isSelected and "MediumPtClearChooseDialogRightCell_2" or "MediumPtClearChooseDialogRightCell_1")
        else
            self.animation:Play(isSelected and "MediumPtClearChooseDialogRightCell2" or "MediumPtClearChooseDialogRightCell")
        end

    end
    --local questVo = QuestConfMgr:GetInstance():GetQuestVoById(self.data.questId)
    local isUnlockQuest = QuestConfMgr:GetInstance():IsUnlockQuest(self.data.questId)
    if isUnlockQuest then
        KTool.SetActive(self.ImgDecorate.gameObject, isUnlockQuest)
        self.ImgBg.Status = isSelected and SwitchImageStatusBg.Select or SwitchImageStatusBg.Normal
        self.TxtNumber.Status = isSelected and SwitchTextStatusTitle.Select or SwitchTextStatusTitle.Normal
    else
        self.ImgBg.Status = 3
        self.TxtNumber.Status = 3
    end
    CfUtils.SetUISwitchText(self.txtDiff, isSelected and SwitchImageStatusBg.Select or SwitchImageStatusBg.Normal)
end

function DailyQuestCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return DailyQuestCell