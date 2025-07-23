--[[ 
-----------------------------------------------------
@filename       : FightSkillTips
@Description    : 战斗UI上的漂浮技能tips
@date           : 2021-04-07 20:07:58
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.fightUI.view.FightSkillTips', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fight/FightSkillTips.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0
isBlur = 0
isAddMask = 0 --窗口模式下是否需要添加mask (1 添加 0 不添加)


--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mBtnPrevent = self:getChildGO("mBtnPrevent")

    self.mImgBg = self:getChildTrans("mImgBg")
    self.mGroup = self:getChildGO("mGroup")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.TMP_Text)
    self.mTxtDesLink = self:getChildGO("mTxtDes"):GetComponent(ty.TextMeshProLink)
    self.mTxtDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)

    self.mImgCount = self:getChildGO("mImgCount")
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mTxtCostLab = self:getChildGO("mTxtCostLab"):GetComponent(ty.Text)
    self.mImgFlag = self:getChildGO("mImgFlag"):GetComponent(ty.AutoRefImage)
    self.mTxtFlag = self:getChildGO("mTxtFlag"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)

    self.mTxtRange = self:getChildGO("mTxtRange"):GetComponent(ty.Text)
    self.mImgRange = self:getChildGO("mImgRange"):GetComponent(ty.AutoRefImage)

    self.mGroupMilitaryEffect = self:getChildGO("mGroupMilitaryEffect")
    self.mImgMilitaryLock = self:getChildGO("mImgMilitaryLock")
    self.mImgMilitaryIcon = self:getChildGO("mImgMilitaryIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtMilitaryTitle = self:getChildGO("mTxtMilitaryTitle"):GetComponent(ty.Text)
    self.mTxtMilitaryName = self:getChildGO("mTxtMilitaryName"):GetComponent(ty.Text)
    self.mTxtMilitaryDes = self:getChildGO("mTxtMilitaryDes"):GetComponent(ty.TMP_Text)
    self.mTxtMilitaryDesLink = self:getChildGO("mTxtDes"):GetComponent(ty.TextMeshProLink)
    self.mTxtMilitaryDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)

    self.mTxtMilitarySkillTip = self:getChildGO("mTxtMilitarySkillTip"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
    self.mSkillId = args.skillId
    self.mHeroId = args.heroId
    self.mPos = args.pos

    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_FIGHT_SKILL_TIPS)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtMilitaryTitle.text = _TT(27028) --"军阶效果"
    self.mTxtCostLab.text = _TT(1207) --"消耗:"
    self.mTxtRange.text = "技能范围："

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPrevent, self.onClickClose)
end

function updateView(self)
    if self.mSkillId == 0 then
        -- 格挡
        self.mImgCount:SetActive(false)
        self.mTxtCostLab.gameObject:SetActive(false)
        self.mTxtTitle.text = _TT(3018)
        self.mTxtDes.text = _TT(3019)

        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtDes.transform)
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mImgBg)
        self.mImgFlag:SetImg(UrlManager:getFightUIPath("fight_icon_208.png"))
        self.mTxtFlag.text = _TT(3023)

        self.mGroupMilitaryEffect:SetActive(false)
        return
    end

    -- 技能
    local skillVo = fight.SkillManager:getSkillRo(self.mSkillId)
    if skillVo:getType() == 2 or skillVo:getType() == 3 then
        self.mImgCount:SetActive(false)
        self.mTxtCostLab.gameObject:SetActive(false)
        self.mImgFlag:SetImg(UrlManager:getFightUIPath("fight_icon_209.png"))
        self.mTxtFlag.text = _TT(3022)
    else
        self.mImgCount:SetActive(true)
        self.mTxtCostLab.gameObject:SetActive(true)
        self.mImgFlag:SetImg(UrlManager:getFightUIPath("fight_icon_210.png"))
        self.mTxtFlag.text = _TT(3021)
    end

    self.mImgRange:SetImg(UrlManager:getHeroSkillRangeIconUrl(skillVo:getScope()), true)

    local heroVo = hero.HeroManager:getHeroVo(self.mHeroId)
    self.mTxtTitle.text = skillVo:getName()
    self.mTxtCount.text = skillVo:getCost() / 5
    if heroVo then
        self.mTxtLv.text = "Lv." .. (heroVo:getActiveSkill(skillVo:getRefID()) + heroVo:getExtraLv(skillVo:getRefID()))
    else
        self.mTxtLv.text = "Lv.1"
    end

    local desc = fight.SkillManager:getHeroSkillDesc(self.mSkillId, heroVo)
    self.mTxtDes.text = desc

    local parentPos = self.UITrans:InverseTransformPoint(self.mPos)
    gs.TransQuick:LPosY(self.mGroup.transform, parentPos.y + 100)



    -- self:updateMilitaryEffect()

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtTitle.transform)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtDes.transform)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mImgBg)
end

function updateMilitaryEffect(self)
    local heroVo = hero.HeroManager:getHeroVo(self.mHeroId)
    if not heroVo then
        self.mGroupMilitaryEffect:SetActive(false)
        return
    end
    local militaryRankConfigVo = hero.HeroMilitaryRankManager:getVoByHeroTidAndSkillId(heroVo.tid, self.mSkillId)
    if (militaryRankConfigVo) then
        self.mGroupMilitaryEffect:SetActive(true)
        local strengthSkillVo = fight.SkillManager:getSkillRo(militaryRankConfigVo.unlockSkillId)
        if (heroVo.militaryRank >= militaryRankConfigVo.lvl) then
            self.mImgMilitaryLock:SetActive(false)
            self.mTxtMilitarySkillTip.text = ""
            self.mTxtMilitaryName.color = gs.ColorUtil.GetColor("ffffffff")
            self.mTxtMilitaryDes.color = gs.ColorUtil.GetColor("ffffffff")
        else
            self.mImgMilitaryLock:SetActive(true)
            -- self.mTxtMilitarySkillTip.text = string.format("(军阶达到%s解锁)", militaryRankConfigVo:getName())
            self.mTxtMilitarySkillTip.text = _TT(27027, militaryRankConfigVo:getName())
            self.mTxtMilitaryDes.color = gs.ColorUtil.GetColor("82898cff")
            self.mTxtMilitaryName.color = gs.ColorUtil.GetColor("82898cff")
        end
        self.mImgMilitaryIcon:SetImg(UrlManager:getSkillIconPath(strengthSkillVo:getIcon()), false)
        self.mTxtMilitaryName.text = strengthSkillVo:getName()
        self.mTxtMilitaryDes.text = strengthSkillVo:getDesc()
    else
        self.mGroupMilitaryEffect:SetActive(false)
    end
end

function __playOpenAction(self)

end
function __closeOpenAction(self)
    self:close()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]