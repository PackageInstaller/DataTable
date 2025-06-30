module("formation.FormationAssistPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("formation/FormationAssistPanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("common_bg_003.jpg", false)
    self:setUICode(LinkCode.HeroTeam)
end

-- 初始化数据
function initData(self)
    self.mAssistItemList = {}
    self.mHeadGridList = {}
    self.mSkillItemDic = {}
end

function configUI(self)
    self.mContent = self:getChildTrans('mContent')
    self.mItemAssist = self:getChildGO('mItemAssist')
end

function getManager(self)
    return self.m_manager
end

function setManager(self, cusManager)
    self.m_manager = cusManager
end

function active(self, args)
    super.active(self, args)
    self.m_teamId = args.data.teamId
    self.m_formationId = args.data.formationId
    self:setManager(args.manager)
    self:getManager():addEventListener(self:getManager().UPDATE_ASSIST_FIGHT_HERO, self.updateAssistView, self)
    self:updateAssistView()
end

function deActive(self)
    super.deActive(self)
    self:getManager():removeEventListener(self:getManager().UPDATE_ASSIST_FIGHT_HERO, self.updateAssistView, self)
end

function updateAssistView(self)
    self:resetAssistItemList()
    if (self.mContent) then
        self.mContent.gameObject:SetActive(true)
        gs.TransQuick:LPosX(self.mContent:GetComponent(ty.RectTransform), 0)
        local maxAssistPos = sysParam.SysParamManager:getValue(SysParamType.MAX_HERO_ASSIST_COUNT, 0)
        for pos = 1, maxAssistPos do
            local item = SimpleInsItem:create(self.mItemAssist, self.mContent, self.__cname .. ".AssistItem")
            local mImgAdd = item:getChildGO("mImgAdd")
            item:getChildGO("mHeadClick"):SetActive(false)
            local assistHeroVo = self:getManager():getSelectTeamAssistHeroVoByPos(self.m_teamId, pos)
            local nowLv = role.RoleManager:getRoleVo():getPlayerLvl()
            local needLv = self:getManager():getAssistConfigVo(pos).needPlayerLvl
            if (assistHeroVo) then
                mImgAdd:SetActive(false)
                item:getChildGO("mTxtNoChoose"):SetActive(false)
                item:getChildGO("mBtnChange"):SetActive(true)
                local nodeHead = item:getChildTrans("mNodeHead")
                local headGrid = HeroHeadGrid:poolGet()
                headGrid:setData(hero.HeroManager:getHeroVo(assistHeroVo.heroId))
                headGrid:setParent(nodeHead)
                table.insert(self.mHeadGridList, 1, headGrid)

                -- 技能icons
                local heroVo = hero.HeroManager:getHeroVo(assistHeroVo.heroId)
                local mAssistSkillList = hero.HeroAssistManager:getHeroAssistConfigList(heroVo.tid)
                for i = 1, #mAssistSkillList do
                    local skillVo = fight.SkillManager:getSkillRo(mAssistSkillList[i].skillId)
                    local isUnlock = hero.HeroAssistManager:isAssistSkillActive(heroVo.id, mAssistSkillList[i].skillId) and 1 or 0 --解锁：0，未解锁：1
                    local skillItem = hero.HeroSkillItem2:create(item:getChildTrans("mGroupSkills"), "SkillItem")
                    skillItem:setData(heroVo, skillVo, isUnlock, 4)
                    if(isUnlock == 0) then 
                        skillItem:setForbid(true) 
                    end
                    self.mSkillItemDic[mAssistSkillList[i].skillId] = {
                        item = skillItem, 
                        eventTrigger = skillItem:getTrans():GetComponent(ty.LongPressOrClickEventTrigger)
                    }
                    self:addShowTriggerEvent(heroVo, mAssistSkillList[i].skillId)
                end
                item:getChildGO("mHeadClick"):SetActive(true)
                item:addOnClick(item:getChildGO("mHeadClick"), function()
                    local tips = TipsFactory:heroAssistTips(heroVo)
                    tips:setVisibleBtns(false)
                end)
            else
                mImgAdd:SetActive(true)
                if(nowLv >= needLv) then
                    item:getChildGO("mTxtNoChoose"):GetComponent(ty.Text).text = _TT(71004)
                else
                    item:getChildGO("mTxtNoChoose"):GetComponent(ty.Text).text = _TT(1262, needLv)
                end
                item:getChildGO("mTxtNoChoose"):SetActive(true)
                item:getChildGO("mBtnChange"):SetActive(false)
            end
            item:getChildGO("mTxtTitle"):GetComponent(ty.Text).text = _TT(1274)
            item:getChildGO("mTxtExchange"):GetComponent(ty.Text).text = _TT(1275)
            local function _clickAddFun()
                if(nowLv >= needLv) then
                    self:getManager():dispatchEvent(self:getManager().OPEN_FORMATION_ASSIST_HERO_SELECT_PANEL, { teamId = self.m_teamId, formationId = self.m_formationId, assistPos = pos, manager = self:getManager()})
                end
            end
            item:addUIEvent("mImgAdd", _clickAddFun)
            item:addUIEvent("mBtnChange", _clickAddFun)
            table.insert(self.mAssistItemList, item)
        end
    end
end

function addShowTriggerEvent(self, heroVo, skillId)
    local function _onClickHandler()
        self:showSkillTip(heroVo, skillId)
    end
    local eventTrigger = self.mSkillItemDic[skillId].eventTrigger
    eventTrigger.onClick:AddListener(_onClickHandler)
end

function showSkillTip(self, heroVo, skillId)
    local skillVo = fight.SkillManager:getSkillRo(skillId)
    local assistSkillList = hero.HeroAssistManager:getHeroAssistConfigList(heroVo.tid)
    local skillIdList = {}
    for i = 1, #assistSkillList do
        table.insert(skillIdList, assistSkillList[i].skillId)
    end
    if(table.indexof(skillIdList ,skillId)) then
        TipsFactory:AssistSkillTips(heroVo, skillVo)
    end
end

function recoverSkillList(self) 
    if (self.mSkillItemDic) then
        for k,v in pairs(self.mSkillItemDic) do
            v.eventTrigger.onClick:RemoveAllListeners()
            v.item:poolRecover()
        end
    end
    self.mSkillItemDic = {}
end

function resetAssistItemList(self)
    self:recoverSkillList()
    if (self.mAssistItemList) then
        for i = 1, #self.mAssistItemList do
            self.mAssistItemList[i]:poolRecover()
        end
    end
    if (self.mHeadGridList) then
        for i = 1, #self.mHeadGridList do
            self.mHeadGridList[i]:poolRecover()
        end
    end
    self.mAssistItemList = {}
    self.mHeadGridList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1275):	"更换"
	语言包: _TT(1274):	"助战效果"
]]
