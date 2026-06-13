-- baoruichang
-- 2023/5/19 15:33:45
local UIRoleSkillUpCtrl = BaseClass("UIRoleSkillUpCtrl", BaseUICtrl)
local M = UIRoleSkillUpCtrl
local JBattleLevel = CS.GameBase.JBattleLevel
local JSkillUpgrading = CS.GameBase.JSkillUpgrading
local MessageId = Proto.MessageId
local UIRoleSkillUpItemCtrl = require("UI.Ctrl.UIRoleSkill.UIRoleSkillUpItemCtrl")
local UIRoleSkillUpItemView = require("UI.View.UIRoleSkill.UIRoleSkillUpItemView")
local mModf = math.modf
local sfmt = string.format

function M:Init()
    self._view.btnOk:onClick(Bind(self, self._onClickOk))
    self._view.btnCancel:onClick(Bind(self, self.Close))
    self.grid = self._view.grid
    self.grid:Init(UIRoleSkillUpItemCtrl, UIRoleSkillUpItemView)
    self.tabItemPfbViews = {self._view.ItemPfbView}
    self.m_itemTag = ItemDataMgr:GetInstance():AddItemChange(1, Bind(self, self.RefreshConsume))
end

-- 进入UI，可传参数
function M:OnEnter(heroData)
    self.heroId = heroData:GetHeroId()
    self.heroData = heroData
    self.skinId = heroData:GetSkinId()
    self.skillLv = heroData:GetSkillLevel()
    self:_initUI()
    self:_initCost()
    self:_CanLvUp()
end

function M:_initUI()
    self.nextSkillUpgrading = JSkillUpgrading.GetSkillUpgradings(self.heroId, self.skillLv + 1)
    self.isMaxLv = IsNull(self.nextSkillUpgrading) -- 满级
    if self.isMaxLv then
        -- 关闭自己
        self:Close()
        return
    end
    self._view.labLv1:SetText("LV." .. self.skillLv)
    self._view.labLv2:SetText("LV." .. self.skillLv + 1)
    local datas = self:GetSkillData()
    self.grid:SetDataList(datas)
end

function M:_initCost()
    local index = 1
    -- 需要消耗的银币数量
    local constGoldNum = nil
    self.skillUpgrading = JSkillUpgrading.GetSkillUpgradings(self.heroId, self.skillLv)
    for i = 0, self.skillUpgrading.costItem.Length - 1 do
        local costId = self.skillUpgrading.costItem[i]
        local costNum = self.skillUpgrading.costNum[i]
        if costId == 1 then
            constGoldNum = costNum
            self._view.ComItemSlipCtrl:SetItemById(1, constGoldNum)
            self._view.ComItemSlipCtrl:OnUpdateNumState()
        else
            local ItemPfbView = self.tabItemPfbViews[index]
            if not ItemPfbView then
                ItemPfbView = self._view.ItemPfbView:Instantiate()
                self.tabItemPfbViews[index] = ItemPfbView
            end
            index = index + 1
            local haveNum = ItemDataMgr:GetInstance():GetItemNumById(costId)
            ItemPfbView.item:SetInfo(costId, ItemNumberType.FRACTION, costNum, haveNum)
            ItemPfbView:SetActive(true)
            ItemPfbView.item:EnablePopItem(true)
        end
    end
    for i = index, #self.tabItemPfbViews do
        self.tabItemPfbViews[i]:SetActive(false)
    end
    if not constGoldNum then
        self._view.ComItemSlipCtrl.SetActive(false)
    end
end

function M:RefreshConsume(itemId, old, now)
    if itemId ~= 1 then
        return
    end
    self._view.ComItemSlipCtrl:OnUpdateNumState()
end

function M:_CanLvUp()
    if IsNull(self.nextSkillUpgrading) then -- 满级
        return
    end
    local conditionId = self.nextSkillUpgrading.openCondition
    self.isOpen = GameHelper.CheckLockByOpenConditionId(conditionId, self.heroId)
    self._view.btnState:SetState(self.isOpen and 1 or 2)
    if not self.isOpen then
        self.lockBtn = true
        local openCondition = ConfigHelper.GetCfg("openCondition", conditionId)
        local tips = ConfigHelper.GetLocalString(openCondition.tips)
        local heroName = ConfigHelper.GetHeroName(self.heroId)
        tips = sfmt(tips, heroName, openCondition.unlockParam2)
        self._view.labLock:SetText(tips)
    end
end

-- 获取当前等级的技能
function M:GetSkillData()
    local curBattleLevels = JBattleLevel.GetHeroBattleByLv(self.skinId, self.skillLv)
    local nextBattleLevels = JBattleLevel.GetHeroBattleByLv(self.skinId, self.skillLv + 1)
    local data = {}
    local index = 1
    for i = 0, curBattleLevels.Count - 1 do
        local curBattleLevel = curBattleLevels[i]
        if curBattleLevel.skilldescribe2.Length ~= curBattleLevel.skilldescribe3.Length or curBattleLevel.skilldescribe3.Length ~= curBattleLevel.skilldescribe4.Length then
            Logger.LogError("策划配置错误")
            break
        end
        if curBattleLevel.grade ~= 1 then
            local nextBattleLevel = nextBattleLevels[i]
            local name = curBattleLevel.name
            local icon = curBattleLevel.icon
            for j = 0, curBattleLevel.skilldescribe2.Length - 1 do
                local valueType = curBattleLevel.skilldescribe4[j]
                local tempData = {}
                tempData.name = name
                tempData.icon = icon
                tempData.desc = curBattleLevel.skilldescribe2[j]
                tempData.curValue = self:_GetValue(curBattleLevel.skilldescribe3[j], valueType)
                tempData.nextValue = self:_GetValue(nextBattleLevel.skilldescribe3[j], valueType)
                tempData.valueType = valueType
                data[index] = tempData
                index = index + 1
            end
        end
    end
    return data
end

function M:_GetValue(value, valueType)
    if value == -1 then
        return ""
    end
    if valueType == 0 then
        return tostring(value)
    end
    if valueType == 1 then
        local curValue
        if value % 100 == 0 then
            curValue = mModf(value / 100)
        else
            curValue = value / 100
        end
        return tostring(curValue) .. "%"
    end
    if valueType == 2 then
        local curValue
        if value % 10000 == 0 then
            curValue = mModf(value / 10000)
        else
            curValue = value / 10000
        end
        return tostring(curValue)
    end
end

function M:_onClickOk()
    -- if not self.enough then
    --     GameHelper.TipsById(4067)
    --     return
    -- end
    local isEnough = GameHelper.CheckItemsEnough(self.skillUpgrading.costItem, self.skillUpgrading.costNum, true, true)
    if not isEnough then
        return
    end

    if not self.isOpen then
        return
    end
    self:RequestHeroSkillUpgrade()
end

-----------------------------------------------------------------------------------------
function M:RequestHeroSkillUpgrade()
    self._tempResponseHeroSkillUpgradeCallBack = NetPack:RegistResponse(MessageId.ResponseHeroSkillUpgrade, Bind(self, self._ResponseHeroSkillUpgradeCallBack))
    local request = {}
    request.HeroId = self.heroId
    request.SkillLevel = self.skillLv
    NetPack:SendMessage(MessageId.RequestHeroSkillUpgrade, request)
end

function M:_ResponseHeroSkillUpgradeCallBack(_, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseHeroSkillUpgrade, self._tempResponseHeroSkillUpgradeCallBack)
    self._tempResponseHeroSkillUpgradeCallBack = nil
    if result ~= 0 then
        return
    end
    UIContextMgr:GetInstance():Show(UIDefine.UpLevel)
    self.skillLv = self.skillLv + 1
    self.heroData:SetSkillLevel(self.skillLv)
    self:_initUI()
    self:_initCost()
    self:_CanLvUp()
    EventMgr:Broadcast(UIMessageNames.ROLE_SKILLUP, self.heroId)
    -- 技能升级埋点
    local profession = self.heroData:GetProfession()
    local rare = self.heroData:Rare()
    local dataValues = {profession, rare, self.heroId, self.skillLv}
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.HeroSkillup, dataValues)
end

-----------------------------------------------------------------------------------------

-- 点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    for _, value in ipairs(self.tabItemPfbViews) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDispose()
    end
    ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_itemTag)
    M.super.OnDispose(self)
end
return UIRoleSkillUpCtrl
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O\ = /O
--                        ____/`---'.____
--                        . ' \\| |// `.
--                       / \\||| : |||// .
--                     / _||||| -:- |||||- .
--                       | | \.. - --/ | |
--                     | ._| ''.---/'' | |
--                      . .-.__ `-` ___/-. /
--                   ___`. .' /--.--. `. . __
--                ."" '< `.___\_<|>_/___.' >'"".
--               | | : `- \`.;`\ _ /`;.`/ - ` : | |
--                 \ \ `-. \_ __\ /__ _/ .-` / /
--         ======`-.____`-.___\_____/___.-`____.-'======
--                            `=---='
--
--         .............................................
--                            《偈》
--                         平生不修善果
--                         只爱杀人放火
--                         忽地顿开金绳
--                         这里扯断玉锁
--                         钱塘江上潮信来
--                         今日方知我是我
