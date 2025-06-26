-- @FileName:   FieldExplorationHeroSkillItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-31 11:31:55
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationHeroSkillItem', Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("fieldExploration/item/FieldExplorationHeroSkillItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)

end
--析构
function dtor(self)
end

function initData(self)
    self.keyData =
    {
        [1] = {keyName = "shift", key = gs.KeyCode.LeftShift},
        [2] = {keyName = "space", key = gs.KeyCode.Space},
    }
end

function configUI(self)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgBan = self:getChildGO("mImgBan")
    self.mImGray = self:getChildGO("mImGray")
    self.mImgCd = self:getChildGO("mImgCd"):GetComponent(ty.Image)
    self.mImgCountCd = self:getChildGO("mImgCountCd"):GetComponent(ty.Image)
    self.mTextCd = self:getChildGO("mTextCd"):GetComponent(ty.Text)
    self.mUseCount = self:getChildGO("mUseCount")
    self.mUseItem = self:getChildGO("mUseItem")
    self.mImKeyBorad = self:getChildGO("mImKeyBorad")
    self.mTxtKeyBorad = self:getChildGO("mTxtKeyBorad"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_SKILL_REFRSHCOUNT_UPDATE, self.refreshUseCount, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_SKILL_REFRSHCDTIME_UPDATE, self.refreshUseCountCd, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_SKILL_USECDTIME_UPDATE, self.refreshCdTime, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_SKILL_STATE_UPDATE, self.refreshDisable, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_SKILL_UIEFFECT_UPDATE, self.refreshUIEffect, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_PLAYERATTR_INFO_UPDATE, self.refreshEnergy, self)

    if (gs.ApplicationUtil.IsPC()) then
        self.mFrameSn = LoopManager:addFrame(1, 0, self, self.onKeyDownHandler)
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_SKILL_REFRSHCOUNT_UPDATE, self.refreshUseCount, self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_SKILL_REFRSHCDTIME_UPDATE, self.refreshUseCountCd, self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_SKILL_USECDTIME_UPDATE, self.refreshCdTime, self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_SKILL_STATE_UPDATE, self.refreshDisable, self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_SKILL_UIEFFECT_UPDATE, self.refreshUIEffect, self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_PLAYERATTR_INFO_UPDATE, self.refreshEnergy, self)

    if not table.empty(self.mUseCountItem) then
        for _, item in pairs(self.mUseCountItem) do
            item:poolRecover()
        end
        self.mUseCountItem = nil
    end

    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
end

function setData(self, cusParent, skill, pos)
    super.setData(self, cusParent, skill.pos)
    self.mSkill = skill
    self.mSkillTid = self.mSkill.skill_Tid
    self.mButtonPos = pos

    if (gs.ApplicationUtil.IsPC()) then
        self.mImKeyBorad:SetActive(true)
        self.mTxtKeyBorad.text = self.keyData[self.mButtonPos].keyName
    else
        self.mImKeyBorad:SetActive(false)
    end

    local heroSkillConfigVo = self.mSkill.config
    self.mImgIcon:SetImg(UrlManager:getSkillIconPath(heroSkillConfigVo.icon))

    self.mImgCd.gameObject:SetActive(false)
    self.mTextCd.gameObject:SetActive(false)
    self.mImgCountCd.gameObject:SetActive(false)

    self:refreshDisable({value = false, skill_Tid = self.mSkillTid})
    self.mImgBan:SetActive(false)

    local playerTing = fieldExploration.FieldExplorationSceneController:getPlayerThing()
    if playerTing then
        if self.mSkill then
            local count, maxCount = self.mSkill:getUseCount()
            if maxCount > 1 then
                self.mUseCount:SetActive(true)
                self.mUseCountItem = {}
                for i = 1, maxCount do
                    local item = SimpleInsItem:create(self.mUseItem, self.mUseCount.transform, "FieldExplorationHeroSkillItem_UseCountItem")
                    table.insert(self.mUseCountItem, item)
                end
            else
                self.mUseCount:SetActive(false)
            end

            self:refreshUseCount({skill_Tid = self.mSkillTid, count = count, max_count = maxCount})
            self:refreshDisable({skill_Tid = self.mSkillTid, value = self.mSkill:getSkillDisableState()})
        end
    end
end

function refreshEnergy(self, args)
    if args.attr.maxEnergy <= 0 then
        return
    end
    self:refreshUIEffect({skill_Tid = self.mSkillTid, value = args.attr.energy >= args.attr.maxEnergy})
end

function refreshUseCountCd(self, args)
    if args.skill_Tid ~= self.mSkillTid then
        return
    end

    self.mImgCountCd.fillAmount = args.time / args.max_time
end

function refreshUseCount(self, args)
    if args.skill_Tid ~= self.mSkillTid then
        return
    end

    if args.max_count > 1 then
        for i = 1, #self.mUseCountItem do
            local item = self.mUseCountItem[i]
            item:getChildGO("mImg"):SetActive(args.count >= i)
        end
    end

    self.mImgCountCd.gameObject:SetActive(args.max_count > 0 and args.count < args.max_count)

    self:refreshDisable({value = args.max_count > 0 and args.count <= 0, skill_Tid = self.mSkillTid})
end

function refreshCdTime(self, args)
    if args.skill_Tid ~= self.mSkillTid then
        return
    end

    local supTime = args.max_time - args.time
    self.mImgCd.gameObject:SetActive(supTime > 0)
    self.mTextCd.gameObject:SetActive(supTime > 0)
    if supTime < 0 then
        return
    end

    self.mTextCd.text = string.format("%.1f", (supTime) * 0.001)
    self.mImgCd.fillAmount = (args.max_time - args.time) / args.max_time
end

function refreshDisable(self, args)
    if args.skill_Tid ~= self.mSkillTid then
        return
    end

    self.mImGray:SetActive(args.value)
end

function refreshUIEffect(self, args)
    if args.skill_Tid ~= self.mSkillTid then
        return
    end

    local ui_effectName = self.mSkill.config.ui_effect
    if string.NullOrEmpty(ui_effectName) then
        return
    end

    if args.value then
        self:addEffect(ui_effectName, self.UITrans, 0, 0)
    else
        self:removeEffect(ui_effectName)
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.UIObject, self.onClick)
end

function onClick(self)
    if self.mSkill then
        self.mSkill:onExecute()
    end
end

function onKeyDownHandler(self)
    local key = self.keyData[self.mButtonPos].key
    if gs.Input.GetKeyDown(key) then
        self:onClick()
    end
end

--技能禁用
function onDisable(self)

end

return _M
