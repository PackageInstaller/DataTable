--[[   
     战斗UI下方技能区域 技能item
]]
module('fightUI.FightSkillItem', Class.impl('lib.component.BaseNode'))

local SKILL_CD_TOTAL_TIME = 0.2

function initData(self, rootGo)
    super.initData(self, rootGo)
    self.m_skillID = nil
    self.m_lastSkillID = nil -- 上次的技能id，只做判断用
    self.m_clickCall = nil
    self.m_clickData = nil
    self:addOnClick(self.m_go, self.onSkillClick)

    self.m_bg = self.m_go:GetComponent(ty.AutoRefImage)
    self.mImgSkillIconGo = self:getChildGO('mImgSkillIcon')
    self.mImgSkillIcon = self.mImgSkillIconGo:GetComponent(ty.AutoRefImage)
    self.mImgSkillIconGo:SetActiveLocal(false)

    self.mImgSoulBgGo = self:getChildGO('mImgSoulBg')
    self.mImgSoulBgGo:SetActiveLocal(false)
    self.mTxtSoulCount = self:getChildGO('mTxtSoulCount'):GetComponent(ty.Text)
    -- self.mImgSoulPro1 = self:getChildGO('mImgSoulPro1')
    -- self.mImgSoulPro2 = self:getChildGO('mImgSoulPro2')
    -- self.mImgSoulPro3 = self:getChildGO('mImgSoulPro3')

    self.mImgSelect = self:getChildGO('mImgSelect')
    self.mImgSelect:SetActiveLocal(false)

    self.mTxtStateGo = self:getChildGO('mTxtState')
    self.mTxtState = self.mTxtStateGo:GetComponent(ty.Text)
    self.mTxtStateGo:SetActiveLocal(false)

    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgSelect:SetActiveLocal(false)

    self.mGroupEff = self:getChildTrans("mGroupEff")

    self.mImgSkillTypeGo = self:getChildGO("mImgSkillType")
    self.mImgSkillType = self.mImgSkillTypeGo:GetComponent(ty.AutoRefImage)

    self.m_cdMaxVal = 1
    self.m_cdCurVal = 0

    self.m_roundStr = ""
    self.m_buffStateStr = ""

    self.m_isUsed = false
    self.mEventTrigger = self.m_go:GetComponent(ty.LongPressOrClickEventTrigger)

    local function _onLongPress()
        self:_onLongPressHandler()
    end
    local function _onPointerUp()
        self:_onPointerUpHandler()
    end
    if self.mEventTrigger then
        self.mEventTrigger.onLongPress:AddListener(_onLongPress)
        self.mEventTrigger.onPointerUp:AddListener(_onPointerUp)
    end
    GameDispatcher:addEventListener(EventName.CLOSE_FIGHT_SKILL_TIPS, self.onCloseSkillTips, self)
    GameDispatcher:addEventListener(EventName.SKILL_END, self.skillEnd, self)
    self:setState(fightUI.FightSkillItemState.EMPTY)
end

function setState(self, stateType)
    if self.m_stateType == fightUI.FightSkillItemState.LOCK and stateType ~= fightUI.FightSkillItemState.EMPTY then return end
    self:removeEffect("fx_ui_fight_skill_prompt")

    if stateType == fightUI.FightSkillItemState.NO_POWER then
        if self.m_stateType ~= fightUI.FightSkillItemState.NORMAL then
            return
        end
        self:_normalState()

        self.mImgSkillIcon:SetGray(true)

    elseif stateType == fightUI.FightSkillItemState.SHOW_ROUND then
        if self.m_stateType == fightUI.FightSkillItemState.LOCK or self.m_stateType == fightUI.FightSkillItemState.FORBID or self.m_stateType == fightUI.FightSkillItemState.EMPTY then
            return
        end
        self:_normalState()

        self.mImgSkillIcon:SetGray(true)
        if not self.isSelect then
            self:addEffect("fx_ui_fight_skill_select", self.mGroupEff)
            self.isSelect = true
        end

        -- if self.mTxtState then
        --     self.mTxtState.text = self.m_roundStr
        --     self.mTxtState.color = gs.COlOR_WHITE
        -- end
    elseif stateType == fightUI.FightSkillItemState.PALSY then
        if self.m_stateType == fightUI.FightSkillItemState.SHOW_ROUND or self.m_stateType == fightUI.FightSkillItemState.LOCK or self.m_stateType == fightUI.FightSkillItemState.FORBID or self.m_stateType == fightUI.FightSkillItemState.EMPTY then
            return
        end
        self:_normalState()
        if self.mTxtState then
            self.mTxtState.text = self.m_buffStateStr
            self.mTxtState.color = gs.COlOR_RED
        end
        self.mTxtStateGo:SetActiveLocal(true)
    elseif stateType == fightUI.FightSkillItemState.LOCK then
        self:_normalState()
        -- self.m_skillCD.gameObject:SetActiveLocal(false)
        self.mTxtStateGo:SetActiveLocal(true)
        self.mImgSelect:SetActiveLocal(true)
    elseif stateType == fightUI.FightSkillItemState.FORBID then
        self.mImgSkillIconGo:SetActiveLocal(false)
        self.mImgSoulBgGo:SetActiveLocal(false)
        self.mTxtStateGo:SetActiveLocal(false)
        self.mImgSelect:SetActiveLocal(true)
    elseif stateType == fightUI.FightSkillItemState.EMPTY then
        self.mImgSkillIconGo:SetActiveLocal(false)
        self.mImgSoulBgGo:SetActiveLocal(false)
        self.mTxtStateGo:SetActiveLocal(false)
        self.mImgSelect:SetActiveLocal(true)
        self:removeEffect("fx_ui_fight_skill_select")
        self.isSelect = false
    elseif stateType == fightUI.FightSkillItemState.NORMAL then
        self:_normalState()
        self:showPromptEffect()
    end
    self.m_stateType = stateType
end

function _normalState(self)
    self.mImgSkillIcon:SetGray(false)
    self.mImgSkillIconGo:SetActiveLocal(true)
    self.mTxtStateGo:SetActiveLocal(false)
    self.mImgSoulBgGo:SetActiveLocal(true)
    self.mImgSelect:SetActiveLocal(false)
    self.mImgSkillTypeGo:SetActiveLocal(true)
end

-- 播放可释放特效
function showPromptEffect(self)
    self:addEffect("fx_ui_fight_skill_prompt", self.mGroupEff)
end

-- 隐藏特效节点
function setEffGroupActive(self, isActive)
    self.mGroupEff.gameObject:SetActive(isActive)
end

-- 外部获取电量背景图trans
function getSoulBgTrans(self)
    return self.mImgSoulBgGo.transform
end

function setMaxVal(self, maxVal)
    self.m_cdMaxVal = maxVal
end

function setCurVal(self, curVal)
    -- if self.m_stateType == fightUI.FightSkillItemState.LOCK then return end
    -- self.m_cdCurVal = curVal
    -- self.m_skillCD.fillAmount = self.m_cdCurVal / self.m_cdMaxVal
end

function isFull(self)
    if self.m_curVal >= self.m_maxVal then
        return true
    end
    return false
end

function setHeroID(self, heroID)
    self.m_heroID = heroID
end

function setSkillID(self, skillID, liveId)
    if self.mImgSelect and skillID ~= nil and self.m_lastSkillID ~= skillID then
        self.mImgSelect:SetActiveLocal(false)
    end
    if skillID ~= nil then
        self.m_lastSkillID = skillID
    end

    if self.m_skillID ~= skillID then
        self.isSelect = false
    end

    self.m_skillID = skillID
    self.mLiveId = liveId

    local skillVo = fight.SkillManager:getSkillRo(skillID)
    self.mImgSkillType:SetImg(UrlManager:getFightUIPath(skillVo:getSkillLocate()), false)
    -- local skillLocation = skillVo:getLocation()
    -- if (#skillLocation >= 2) then
    -- self.mImgSkillType.color = gs.ColorUtil.GetColor(skillLocation[1])
    -- self.m_textSkillDefine.text = _TT(skillLocation[2])
    -- else
    -- self.mImgSkillType.color = gs.ColorUtil.GetColor("FFFFFF00")
    -- self.m_textSkillDefine.text = ""
    -- end
end

function getSKillID(self)
    return self.m_skillID
end

function setIsUse(self, beUsed)
    self.m_isUsed = beUsed
end

function getIsUse(self)
    return self.m_isUsed
end

-- SkillTmpVo
function setClickData(self, cData)
    self.m_clickData = cData
end
function getClickData(self)
    return self.m_clickData
end

function setSkillCall(self, call)
    self.m_clickCall = call
end

function onSkillClick(self)
    if self.m_skillID == nil then
        return
    end
    if self.m_isCDing == true then return end
    if self.m_stateType == fightUI.FightSkillItemState.LOCK then
        gs.Message.Show2(_TT(3043))
        return
    end
    -- if self.m_stateType~=fightUI.FightSkillItemState.NORMAL then return end
    if self.m_clickCall then
        self.m_clickCall(self, self.m_clickData)
    end
end

function _onLongPressHandler(self)
    if self.m_skillID ~= nil then
        if self.mImgSelect then
            self.mImgSelect:SetActiveLocal(true)
        end
        GameDispatcher:dispatchEvent(EventName.OPEN_FIGHT_SKILL_TIPS, { skillId = self.m_skillID, heroId = self.m_heroID, pos = self.m_trans.position })
    end
end

function _onPointerUpHandler(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_FIGHT_SKILL_TIPS)
end

function onCloseSkillTips(self)
    if self.mImgSelect then
        self.mImgSelect:SetActiveLocal(false)
    end
end

-- 甚至所需电量（原技能基础为5点，现在显示5点一格）
function setSoul(self, count)
    if count ~= nil and count > 0 then
        count = count / 5

        self.mTxtSoulCount.text = count
        -- self.m_soulTxt.text = tostring(count)
        -- self.mImgSoulPro1:SetActive(count >= 1)
        -- self.mImgSoulPro2:SetActive(count >= 2)
        -- self.mImgSoulPro3:SetActive(count >= 3)
    end
end

function setRountTxt(self, txt)
    self.m_roundStr = txt
end
function setBuffTxt(self, txt)
    self.m_buffStateStr = txt
end

function setIcon(self, imgKey, isEnpty)
    self.mImgSkillIcon:SetImg(imgKey, false)
    -- self.mImgSkillIconBg:SetImg(imgKey, false)
end

function _skillCDCall(self, dt)
    -- self.m_skillCDTime = self.m_skillCDTime + dt
    -- if self.m_skillCDTime > SKILL_CD_TOTAL_TIME then
    --     self:removeCD()
    --     return
    -- end
    -- self.m_skillCD.fillAmount = 1 - self.m_skillCDTime / SKILL_CD_TOTAL_TIME
end

function removeCD(self)
    -- if self.m_skillCDSn > 0 then
    --     self.m_skillCDTime = 0
    --     RateLooper:removeFrameByIndex(self.m_skillCDSn)
    --     self.m_skillCDSn = 0
    --     self.m_skillCD.fillAmount = 0
    -- end
    -- self.m_isCDing = false
end

function startCD(self)
    -- if self.m_stateType == fightUI.FightSkillItemState.LOCK then return end
    -- if self.m_skillID == nil then
    --     return
    -- end

    -- self.m_isCDing = true
    -- self.m_skillCDTime = 0
    -- -- self.m_skillCD.gameObject:SetActiveLocal(true)
    -- self.m_skillCD.fillAmount = 1
    -- RateLooper:removeFrameByIndex(self.m_skillCDSn)
    -- self.m_skillCDSn = RateLooper:addFrame(0, -1, self, self._skillCDCall)
end

function showClickEfx(self)
    if self.m_stateType ~= fightUI.FightSkillItemState.NORMAL then
        return
    end
    if not self.clickEfx then
        self.clickEfx = self:addEffect("fx_ui_fight_skill_click_1", self.mGroupEff)
    else
        self.clickEfx.effectGo:SetActive(false)
        self.clickEfx.effectGo:SetActive(true)
    end
end

-- 技能结束移除选择特效
function skillEnd(self, args)
    if args and args.skillId == self.m_skillID then
        self:removeEffect("fx_ui_fight_skill_select")
    end
end


-- 移除
function destroy(self)
    self:removeOnClick(self.m_go)
    if self.mEventTrigger then
        self.mEventTrigger.onLongPress:RemoveAllListeners()
    end
    RateLooper:removeFrameByIndex(self.m_skillCDSn)

    GameDispatcher:removeEventListener(EventName.CLOSE_FIGHT_SKILL_TIPS, self.onCloseSkillTips, self)
    super.destroy(self)

    self.clickEfx = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(3043):	"战员升格后解锁新技能"
]]