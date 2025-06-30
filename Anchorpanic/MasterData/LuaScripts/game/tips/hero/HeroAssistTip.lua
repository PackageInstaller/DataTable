module("tips.HeroTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/HeroAssistTip.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 0 -- 是否

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构函数
function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)
    self.mHeroVo = nil
    self.mItemList = {}
end

--初始化UI
function configUI(self)
    super.configUI(self)
    self.mHeadNode = self:getChildTrans("mHeadNode")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mGroupEffect = self:getChildTrans("mGroupEffect")
    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mBtnAssist = self:getChildGO("mBtnAssist")
    self.mEffectItem = self:getChildGO("mEffectItem")
end

function initViewText(self)
    self:setBtnLabel(self.mBtnCancel, 2, "取消")
    self:setBtnLabel(self.mBtnAssist, 62002, "助战")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCancel, self.onClose)
    self:addUIEvent(self.mBtnAssist, self.onAssistClickHandler)
end

function active(self, args)
    super.active(self, args)
    self.mHeroVo = args.heroVo
    self:setVisibleBtns(true)
    self:updateView()
end

function deActive(self)
    super.deActive(self)
end

function updateView(self)
    if (not self.mHeadGrid) then
        self.mHeadGrid = HeroHeadGrid:poolGet()
    end
    self.mHeadGrid:setData(self.mHeroVo)
	self.mHeadGrid:setParent(self.mHeadNode)
	self.mHeadGrid:setLvl(self.mHeroVo.lvl)
	-- self.mHeadGrid:setMilitary(true)
    self.mHeadGrid:setScale(0.8)
    self.mTxtName.text = self.mHeroVo.name
    self:recoverItems()
    self.mAssistSkillList = hero.HeroAssistManager:getHeroAssistConfigList(self.mHeroVo.tid)
    for i = 1, #self.mAssistSkillList do
        local item = SimpleInsItem:create(self.mEffectItem, self.mGroupEffect, "AssistSkillEffectItem")
        local isLock = not hero.HeroAssistManager:isAssistSkillActive(self.mHeroVo.id, self.mAssistSkillList[i].skillId)
        local skillRo = fight.SkillManager:getSkillRo(self.mAssistSkillList[i].skillId)
        item:getChildGO("mTxtEffectTitle"):GetComponent(ty.Text).text = _TT(36)..i
        local txtLock = item:getChildGO("mTxtLock"):GetComponent(ty.Text)
        local skillDes = item:getChildGO("mTxtEffect"):GetComponent(ty.Text)
        skillDes.text = skillRo:getDesc()
        if(isLock) then 
            local txtUnlockCondition = item:getChildGO("mTxtUnlockCondition")
            txtUnlockCondition:GetComponent(ty.Text).text = _TT(71003)..self.mAssistSkillList[i]:getDes()
            txtUnlockCondition:SetActive(true)
            skillDes.color = gs.ColorUtil.GetColor("82898Cff")
            txtLock.text = _TT(44503)--"未解锁"
            txtLock.color = gs.ColorUtil.GetColor("ca352aff")
        else
            txtLock.text = _TT(1098)--"已解锁"
        end
        table.insert(self.mItemList, item)
    end
end

function onAssistClickHandler(self)
    local manager = formation.FormationManager
    local heroVo = self.mHeroVo
    manager:dispatchEvent(manager.HERO_FORMATION_ASSIST_SELECT, {heroId = heroVo.id, heroTid = heroVo.tid, heroSourceType = formation.HERO_SOURCE_TYPE.OWN, isInFormation = self.m_isInFormation, isInAssist = self.m_isInAssist})
    self:onClose()
end

function setVisibleBtns(self, isVisible)
    self.mBtnCancel:SetActive(isVisible)
    self.mBtnAssist:SetActive(isVisible)
end

function onClose(self)
    super.onClickClose(self)
end

-- 在资源销毁前，对需要回收的资源进行回收处理
function recover(self)
    if (self.mHeadGrid) then
        self.mHeadGrid:poolRecover()
        self.mHeadGrid = nil
    end
    self.mHeroVo = nil
    super.recover(self)
end

function recoverItems(self)
    for i = 1, #self.mItemList do
        self.mItemList[i]:poolRecover()
    end
    self.mItemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(36):	"效果"
]]
