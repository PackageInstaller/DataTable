module('hero.HeroSkillDetailSubTab', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/tab/subTab/HeroSkillDetailSubTabView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 0--是否开启适配刘海 0 否 1 是
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1117, 520)
    self:setTxtTitle(_TT(1296))
end

-- 初始化数据
function initData(self)
    self.mItem = nil
    self.propItemList = {}
end

function configUI(self)
    --left
    self.mTxtActSkill = self:getChildGO('mTxtActSkill'):GetComponent(ty.Text)
    self.mSkillNode = self:getChildTrans('mSkillNode')
    self.mTxtCD = self:getChildGO('mTxtCD'):GetComponent(ty.Text)

    --up
    self.mGroupUp = self:getChildGO("mGroupUp")
    self.mTxtSkillName = self:getChildGO("mTxtSkillName"):GetComponent(ty.Text)
    self.mTxtSkillLv = self:getChildGO("mTxtSkillLv"):GetComponent(ty.Text)

    self.mTxtSkillDesc = self:getChildGO("mTxtSkillDesc"):GetComponent(ty.TMP_Text)
    self.mTxtSkillDescLink = self:getChildGO("mTxtSkillDesc"):GetComponent(ty.TextMeshProLink)
    self.mTxtSkillDescLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)

    self.mTxtExtra = self:getChildGO("mTxtExtra"):GetComponent(ty.Text)
    self.mImgExtraNameBg = self:getChildGO("mImgExtraNameBg")
    -- self.mTxtExtraName = self:getChildGO("mTxtExtraName"):GetComponent(ty.Text)
    -- self.mTxtLock = self:getChildGO("mTxtLock"):GetComponent(ty.Text)
    -- self.mTxtExtraDesc = self:getChildGO("mTxtExtraDesc"):GetComponent(ty.TMP_Text)
    -- self.mTxtExtraDescLink = self:getChildGO("mTxtExtraDesc"):GetComponent(ty.TextMeshProLink)
    -- self.mTxtExtraDescLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
    --mid
    self.mGroupMid = self:getChildGO("mGroupMid")
    self.mBtnGoTo = self:getChildGO("mBtnGoTo")
    --bot
    self.mGroupBot = self:getChildGO("mGroupBot")
    self.mTxtAward = self:getChildGO("mTxtAward")
    self.mNodeCost = self:getChildTrans("mNodeCost")
    self.mImgMaxLvl = self:getChildGO("mImgMaxLvl")
    self.mTxtMaxLv = self:getChildGO("mTxtMaxLv"):GetComponent(ty.Text)
    self.mBtnSkillLvlUp = self:getChildGO("mBtnSkillLvlUp")
    self.mTxtCostCoin = self:getChildGO("mTxtCostCoin"):GetComponent(ty.Text)
    self.mImgCostCoin = self:getChildGO("mImgCostCoin"):GetComponent(ty.AutoRefImage)
    self.mCostNode = self:getChildGO("mCostNode")
end

function initViewText(self)
    self:setBtnLabel(self.mBtnSkillLvlUp, 1040, "升级")
    self.mTxtExtra.text = _TT(1225)-- "额外效果"
end

function active(self, args)
    self.mHeroId = args.heroId
    self.isUnlock = args.isUnlock
    self.mHeroTid = args.heroTid
    self.isTalent = false

    if self.mHeroId then
        self.mCurHeroVo = hero.HeroManager:getHeroVo(self.mHeroId)
    else
        self.mCurHeroVo = hero.HeroManager:getHeroConfigVo(self.mHeroTid)
    end
    self.mCurSkillVo = fight.SkillManager:getSkillRo(args.skillId)
    self:updateView()
    GameDispatcher:addEventListener(EventName.UPDATE_SKILL_UP_PANEL, self.onUpdateHeroDetailDataHandler, self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSkillLvlUp, self.onClickSkillLvUpHandler)
    self:addUIEvent(self.mBtnGoTo, self.onClickGoToHandler)
end

function deActive(self)
    self:recyAllItem()
    GameDispatcher:removeEventListener(EventName.UPDATE_SKILL_UP_PANEL, self.onUpdateHeroDetailDataHandler, self)
end

function onUpdateHeroDetailDataHandler(self, args)
    if (args.heroId == self.mHeroId and args.skillId == self.mCurSkillVo:getRefID()) then
        self.mCurHeroVo = hero.HeroManager:getHeroVo(self.mHeroId)
        self:updateView()
    end
end

function onClickCloseHandler(self)
    super.onClickClose(self)
end

function updateView(self)
    self:recyAllItem()
    local heroVo = self.mCurHeroVo
    local skillVo = self.mCurSkillVo

    -- local needMilitary = hero.HeroMilitaryRankManager:getVoByHeroTidAndSkillId(heroVo.tid, skillVo:getRefID())

    local skillLvl = 1
    local skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(heroVo.tid, skillVo:getRefID(), skillLvl)
    local isPassive = false
    local isLock = true
    local lvlMiliEnable = true
    local isLvEnough = false
    --left
    if (skillVo:getType() == fight.FightDef.SKILL_TYPE_NORMAL_ATTACK) then
        self.mTxtActSkill.text = _TT(3031)
    elseif (skillVo:getType() == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL) then
        self.mTxtActSkill.text = _TT(1226) --"主动技能"
    elseif (skillVo:getType() == fight.FightDef.SKILL_TYPE_FINAL_SKILL) then
        self.mTxtActSkill.text = _TT(3033)--"终结技能"
    elseif (skillVo:getType() == fight.FightDef.SKILL_TYPE_AOYI_SKILL) then
        self.mTxtActSkill.text = _TT(3022)--"源能爆发"
    elseif (skillVo:getType() == fight.FightDef.SKILL_TYPE_PASSIVE_SKILL) then 
        self.mTxtActSkill.text = _TT(28059)--"天赋技能"
        self.isTalent = true
    end

    if self.mHeroId then 
        if(self.isTalent) then 
            skillLvl = heroVo:getActivePassiveSkill(skillVo:getRefID())
        else
            skillLvl = heroVo:getActiveSkill(skillVo:getRefID())
        end
        skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(heroVo.tid, skillVo:getRefID(), skillLvl)

        lvlMiliEnable = needMilitary ~= nil and heroVo.militaryRank >= needMilitary.lvl
        isLock = skillUpVo ~= nil and heroVo.evolutionLvl < skillUpVo.needStar
        isLvEnough = skillUpVo ~= nil and heroVo.militaryRank >= skillUpVo.needHeroRank
    end

    local maxSkillLvl = hero.HeroSkillUpManager:getHeroMaxSkillLvl(heroVo.tid, skillVo:getRefID())
    local isMaxLvl = skillLvl >= maxSkillLvl
    if self.mItem ~= nil then
        self.mItem:poolRecover()
        self.mItem = nil
    end
    self.mItem = SkillGrid:create(self.mSkillNode, { skillId = skillVo:getRefID(), heroVo = heroVo }, 1, false)
    self.mItem:setDetailVisible(false)
    self.mItem:setIsUnLockVisible(self.isUnlock ~= 1)
    local cdRound = skillVo:getRoundCd() 
    if(cdRound == 0) then 
        self.mTxtCD.text = _TT(27031)
    else
        self.mTxtCD.text = _TT(1227, skillVo:getRoundCd())
    end
    --up
    self.mTxtSkillName.text = skillVo:getName()
    local extraLv = heroVo:getExtraLv(skillVo:getRefID())
    self.mTxtSkillLv.text = "Lv." .. (skillLvl + extraLv)
    self.mTxtSkillDesc.text = skillUpVo:getDesc()
    if(self.isTalent)then 
        self.mItem:getChildGO("ImgSkillBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0055.png"), false)
        self.mGroupMid:SetActive(false)
        self.mGroupBot:SetActive(false)
        self.mTxtAward:SetActive(false)
        self.mImgExtraNameBg:SetActive(false)
        -- self.mTxtExtraDesc.gameObject:SetActive(false)
        -- self.mTxtSkillDesc.text = skillVo:getDesc()
        self.mTxtCD.gameObject:SetActive(false)
        -- self.mTxtSkillLv.gameObject:SetActive(false)
        return
    end
    if not self.mHeroId then 
        self.mGroupMid:SetActive(false)
        self.mGroupBot:SetActive(false)
        self.mTxtAward:SetActive(false)
    end
    
    if ( not isMaxLvl) then --not isLock  and isLvEnough and
        self.mTxtAward:SetActive(true)
        --道具格子
        for i = 1, #skillUpVo.costItem do
            local simple = SimpleInsItem:create(self.mCostNode, self.mNodeCost, "HeroSkillDetailSubTabcostItem")
            local txtCost = simple:getChildGO("mTxtCost"):GetComponent(ty.Text)
            txtCost.text = skillUpVo.costItem[i][2]
            local ownNum = bag.BagManager:getPropsCountByTid(skillUpVo.costItem[i][1])
            if (ownNum < skillUpVo.costItem[i][2]) then
                txtCost.text = "<color=#DE1E1Eff>" .. ownNum .. "</color>/" .. skillUpVo.costItem[i][2]
            else
                txtCost.text = "<color=#242728ff>" .. ownNum .. "</color>/" .. skillUpVo.costItem[i][2]
            end
            local item = PropsGrid:create(simple:getChildTrans("mPropNode"), { tid = skillUpVo.costItem[i][1], num = 0 }, 0.65)
            table.insert(self.propItemList, { simpleItem = simple, item = item })
        end
        if(not isLock and isLvEnough) then 
            --升级按钮
            self.mImgCostCoin:SetImg(UrlManager:getPropsIconUrl(skillUpVo.cost[1]), false)
            self.mTxtCostCoin.text = skillUpVo.cost[2]
            if (MoneyUtil.getMoneyCountByTid(skillUpVo.cost[1]) < skillUpVo.cost[2]) then
                self.mTxtCostCoin.color = gs.ColorUtil.GetColor("DE1E1Eff")
            else
                self.mTxtCostCoin.color = gs.ColorUtil.GetColor("242728ff")
            end
        else
            if (isLock) then
                local integerStar, remainderStar = math.modf(skillUpVo.needStar / 2)
                local curStar = ""
                for i = 1, integerStar do
                    curStar = curStar .. "★"
                end
                if remainderStar > 0 then
                    curStar = curStar .. "☆"
                end
                self.mTxtMaxLv.text = _TT(1058, curStar)
            elseif (not isLvEnough) then
                self.mTxtMaxLv.text = _TT(1233, skillUpVo.needHeroRank)
            end
            self.mBtnSkillLvlUp:SetActive(false)
            self.mImgMaxLvl:SetActive(true)
        end
    else
        self.mTxtAward:SetActive(false)
        if (isMaxLvl) then
            self.mTxtMaxLv.text = _TT(1229)--"已达到最大等级"
        end
        self.mImgMaxLvl:SetActive(true)
        self.mBtnSkillLvlUp:SetActive(false)
    end
end

function onClickSkillLvUpHandler(self)
    local heroVo = self.mCurHeroVo
    local skillVo = self.mCurSkillVo
    local skillLvl = heroVo:getActiveSkill(skillVo:getRefID())
    local skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(heroVo.tid, skillVo:getRefID(), skillLvl)
    local costMoneyTid = skillUpVo.cost[1]
    local costMoneyCount = skillUpVo.cost[2]

    local costItem = skillUpVo.costItem
    local canUp = true

    local mon = MoneyUtil.getMoneyCountByTid(costMoneyTid)
    if mon < costMoneyCount then
        canUp = false
    end

    for i = 1, #costItem do
        local needNum = costItem[i][2]
        local hasNum = bag.BagManager:getPropsCountByTid(costItem[i][1])
        if hasNum < needNum then
            canUp = false
        end
    end

    if canUp then
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_SKILL_UP, { heroId = heroVo.id, skillId = skillVo:getRefID() })
    else
        gs.Message.Show(_TT(1231))
    end
end

function onClickGoToHandler(self)
    self:onClickCloseHandler()
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, { heroId = self.mHeroId, tabType = hero.DevelopTabType.MILITARY_RANK_UP })
    self.mCurHeroVo = hero.HeroManager:getHeroVo(self.mHeroId)
    self.mCurSkillVo = fight.SkillManager:getSkillRo(self.mCurSkillVo:getRefID())
    self:updateView()
end

function recyAllItem(self)
    if self.mItem then
        self.mItem:poolRecover()
        self.mItem = nil
    end
    for i = 1, #self.propItemList do
        self.propItemList[i].simpleItem:recover()
        self.propItemList[i].item:poolRecover()
    end
    self.propItemList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1296):	"<size=24>战</size>员技能"
]]