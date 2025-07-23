module("hero.HeroGetNewSkillPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/success/HeroGetNewSkillPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle("")
end
-- 
-- 初始化数据
function initData(self)
    self.mItemList = {}
    self.mOldHeroVo = nil
    self.mCurHeroVo = nil
    self.mSkillId = nil
end

function configUI(self)
    super.configUI(self)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    --军阶
    self.mGroupMilitary = self:getChildGO("mGroupMilitary")
    self.mSkillNode1 = self:getChildTrans("mSkillNode1")
    self.mSkillNode2 = self:getChildTrans("mSkillNode2")

    self.mTxtSkillDes = self:getChildGO("mTxtSkillDes"):GetComponent(ty.TMP_Text)
    self.mTxtSkillDesLink = self:getChildGO("mTxtSkillDes"):GetComponent(ty.TextMeshProLink)
    self.mTxtSkillDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
    --进阶
    self.mGroupStarUp = self:getChildGO("mGroupStarUp")
    self.mSkillStarNode = self:getChildTrans("mSkillStarNode")
    self.mTxtSkillStarDes = self:getChildGO("mTxtSkillStarDes"):GetComponent(ty.TMP_Text)
    self.mTxtSkillStarDesLink = self:getChildGO("mTxtSkillStarDes"):GetComponent(ty.TextMeshProLink)
    self.mTxtSkillStarDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
end

function active(self, args)
    super.active(self, args)
    self:setData(args.oldHeroVo, args.curHeroVo, args.skillId, args.callBackEvent)
end

function deActive(self)
    super.deActive(self)
    self:recoverItem()
end

function close(self)
    super.close(self)
    -- if (self.mCallBackEvent) then
    --     GameDispatcher:dispatchEvent(self.mCallBackEvent, { oldHeroVo = self.mOldHeroVo })
    -- end
end

function initViewText(self)
end

function setData(self, oldHeroVo, curHeroVo, skillId)
    self.mOldHeroVo = oldHeroVo
    self.mCurHeroVo = curHeroVo
    self.mSkillId = skillId
    self:updateSkillView()
end

function updateSkillView(self)
    local skillVo = fight.SkillManager:getSkillRo(self.mSkillId)
    if (skillVo) then
        self.mTxtTitle.text = fight.FightDef.GetSkillTypeName(skillVo:getType())
    else
        Debug:log_error("HeroGetNewSkillPanel", "找不到技能配置：", self.mSkillId)
    end
end

function setMilitary(self)
    self.mGroupMilitary:SetActive(true)
    self.mTxtSkillDes.gameObject:SetActive(true)
    self:recoverItem()
    local militaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.mCurHeroVo.tid, self.mCurHeroVo.militaryRank)
    local skillVo = fight.SkillManager:getSkillRo(militaryRankVo.unlockSkillId)

    local mItem1 = hero.HeroSkillItem2:create(self.mSkillNode1, "SkillItem")
    mItem1:setData(self.mCurHeroVo, skillVo, 1, 6)
    table.insert(self.mItemList, mItem1)
    local mItem2 = hero.HeroSkillItem2:create(self.mSkillNode2, "SkillItem")
    if(militaryRankVo.unlockSkillId ~= nil and militaryRankVo.unlockSkillId ~= 0) then
        local unLockSkillVo = fight.SkillManager:getSkillRo(militaryRankVo.unlockSkillId)
        mItem2:setData(self.mCurHeroVo, unLockSkillVo, 1, 6)
        table.insert(self.mItemList, mItem2)
        self.mTxtSkillDes.text = unLockSkillVo:getDesc()
    end
end

function setStarUp(self)
    self.mGroupStarUp:SetActive(true)
    self.mTxtSkillDes.gameObject:SetActive(false)
    self:recoverItem()
    local starVo = hero.HeroStarManager:getHeroStarConfigVo(self.mCurHeroVo.tid, self.mCurHeroVo.evolutionLvl)
    local skillVo = fight.SkillManager:getSkillRo(starVo.passiveSkillId)
    local mItem = SkillGrid:create(self.mSkillStarNode, { skillId = starVo.passiveSkillId, heroVo = self.mCurHeroVo }, 1, false)
    mItem:setDetailVisible(false)
    mItem:setNameVisible(true)
    table.insert(self.mItemList, mItem)
    self.mTxtSkillStarDes.text = skillVo:getDesc()
end

function getTitleStr(self, type, subType)
    if (type == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL) then                       --主动技能
        return _TT(27023)
    elseif (type == fight.FightDef.SKILL_TYPE_AOYI_SKILL) then                     --奥义技能
        return _TT(27024)
    elseif (type == fight.FightDef.SKILL_TYPE_PASSIVE_SKILL) then                  --被动技能
        if (subType == fight.FightDef.PASSIVE_SKILL_SUB_TYPE_NORMAL) then      -- 普通被动技能
            return _TT(27023)
        elseif (subType == fight.FightDef.PASSIVE_SKILL_SUB_TYPE_STAR) then    -- 星级被动技能
            return _TT(27025)
        elseif (subType == fight.FightDef.PASSIVE_SKILL_SUB_TYPE_MILITAY) then -- 军阶被动技能
            return _TT(27026)
        end
    else
        return ""
    end
end

function recoverItem(self)
    for i = 1, #self.mItemList do
        if (self.mItemList[i]) then
            self.mItemList[i]:poolRecover()
            self.mItemList[i] = nil
        end
    end
    self.mItemList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1298):	"<size=44>解</size>  锁"
	语言包: _TT(1297):	"解锁效果"
]]