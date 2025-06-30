--[[ 
-----------------------------------------------------
@filename       : FormationAssistPreviewPanel
@Description    : 助战界面
@date           : 2022-03-1 20:03:20
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('formation.FormationAssistPreviewPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("formation/FormationAssistPreviewPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 1
isAdapta = 0--是否开启适配刘海 0 否 1 是
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(650, 450)
end

--析构  
function dtor(self)
end

function getManager(self)
    return self.m_manager
end

function setManager(self, cusManager)
    self.m_manager = cusManager
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mContentAssist = self:getChildTrans("mContentAssist")
    self.mItemAssist = self:getChildGO("mItemAssist")
    self.mItemAssistSkill = self:getChildGO("mItemAssistSkill")
end

-- 激活
function active(self, args)
    super.active(self, args)
    self:setManager(args.manager)

    self:setData(args.data, true)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:resetAssistItemList()
end

function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function resetAssistItemList(self)
    if(self.mAssistItemList)then
        for i = 1, #self.mAssistItemList do
            self.mAssistItemList[i]:poolRecover()
        end
    end
    self.mAssistItemList = {}
end

function setData(self, cusData, isInit)
    if cusData then
        self.mTeamId = cusData.teamId
        self.mFormationId = cusData.formationId
    end
    self:updateView()
end

function updateView(self)
    self:resetAssistItemList()
    local maxAssistPos = sysParam.SysParamManager:getValue(SysParamType.MAX_HERO_ASSIST_COUNT, 0)
    for pos = 1, maxAssistPos do
        local item = SimpleInsItem:create(self.mItemAssist, self.mContentAssist, self.__cname .. ".AssistPreviewItem")
        item:getChildGO("mTextPos"):GetComponent(ty.Text).text = _TT(1276) .. pos
        local mGroupLock = item:getChildGO("mGroupLock")
        local mTextLockTip = item:getChildGO("mTextLockTip"):GetComponent(ty.Text)
        local mGroupEmptyHead = item:getChildGO("mGroupEmptyHead")
        
        local mGroupUnLock = item:getChildGO("mGroupUnLock")
        local mTextContent = item:getChildGO("mTextContent"):GetComponent(ty.Text)
        local nodeHead = item:getChildTrans("mNodeHead")
        local mGroupAssistSkill = item:getChildGO("mGroupAssistSkill")
        local contentAssistSkill = item:getChildTrans("mContentAssistSkill")
        local mTextSkillPro = item:getChildGO("mTextSkillPro"):GetComponent(ty.Text)

        local heroVo = nil
        local assistConfigVo = self:getManager():getAssistConfigVo(pos)
        if(assistConfigVo:isUnLock())then
            mGroupLock:SetActive(false)
            mGroupUnLock:SetActive(true)
            mGroupEmptyHead:SetActive(false)

            local assistHeroVo = self:getManager():getSelectTeamAssistHeroVoByPos(self.m_teamId, pos)
            if(assistHeroVo)then
                heroVo = hero.HeroManager:getHeroVo(assistHeroVo.heroId)
                mTextContent.text = heroVo.name

                local headGrid = HeroHeadSelectGrid:poolGet()
                headGrid:setData(heroVo)
                headGrid:setParent(nodeHead)
                headGrid:setLvl(nil)
                headGrid:setIsShowUseState(false)
                headGrid:setClickEnable(false)
                table.insert(self.mAssistItemList, 1, headGrid)
            else
                mGroupEmptyHead:SetActive(true)
                mTextContent.text = _TT(1277)
            end
        else
            mGroupLock:SetActive(true)
            mGroupUnLock:SetActive(false)
            mGroupEmptyHead:SetActive(false)
            mTextLockTip.text = _TT(121, assistConfigVo.needPlayerLvl)-- 指挥官等级达到{0}级解锁
        end

        if(heroVo)then
            local hasActiveCount = 0
            local heroAssistConfigList = hero.HeroAssistManager:getHeroAssistConfigList(heroVo.tid)
            for i = 1, #heroAssistConfigList do
                local heroAssistConfigVo = heroAssistConfigList[i]
                local skillVo = fight.SkillManager:getSkillRo(heroAssistConfigVo.skillId)
                local isSkillActive = hero.HeroAssistManager:isAssistSkillActive(heroVo.id, heroAssistConfigVo.skillId)
    
                local skillItem = SimpleInsItem:create(self.mItemAssistSkill, contentAssistSkill, self.__cname .. ".AssistSkillItem")
                skillItem:getChildGO("mImgSkillIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
                if(skillVo:getType() == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL)then         -- 主动技能
                    skillItem:getChildGO("mImgSkillBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_1429.png"), true)
                elseif(skillVo:getType() == fight.FightDef.SKILL_TYPE_PASSIVE_SKILL)then    -- 被动技能
                    skillItem:getChildGO("mImgSkillBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_1430.png"), true)
                end
                if(#skillVo:getLocation() >= 2)then
                    skillItem:getChildGO("mImgSkillDefine"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(skillVo:getLocation()[1])
                    skillItem:getChildGO("mTextSkillDefine"):GetComponent(ty.Text).text = _TT(skillVo:getLocation()[2])
                else
                    skillItem:getChildGO("mImgSkillDefine"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor("FFFFFF00")
                    skillItem:getChildGO("mTextSkillDefine"):GetComponent(ty.Text).text = ""
                end
                skillItem:getChildGO("mImgLock"):SetActive(not isSkillActive)
                hasActiveCount = isSkillActive and hasActiveCount + 1 or hasActiveCount
                local function _clickItemFun(self, args)
                    if(heroAssistConfigVo.skillId > 0)then
                        TipsFactory:skillTips(nil, heroAssistConfigVo.skillId, heroVo)
                    end
                end
                skillItem:addUIEvent("mImgClick", _clickItemFun)
                table.insert(self.mAssistItemList, 1, skillItem)
            end

            mGroupAssistSkill:SetActive(true)
            mTextSkillPro.text = hasActiveCount .. "/" .. #heroAssistConfigList
        else
            mGroupAssistSkill:SetActive(false)
        end

        table.insert(self.mAssistItemList, item)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1277):	"未上阵"
	语言包: _TT(1276):	"部位"
]]
