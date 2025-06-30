module("hero.HeroColorUpTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("hero/tab/HeroColorUpTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.m_curHeroId = nil
    self.m_costHeroIdList = {}
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self:__playerClose()
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:__playerClose()
end

function __playerClose(self)
    self:__closeMaterialPanel()
end

function __closeMaterialPanel(self)
    if(self.mMaterialPanel)then
        self.mMaterialPanel:close()
    end
end

function configUI(self)
    super.configUI(self)
    self.m_groupRight = self:getChildGO("GroupAction")
    self.m_groupAction = self:getChildGO("GroupAction")

    self.m_groupAddAttr = self:getChildGO("GroupAddAttr")
    self.m_colorUpAddAttrItem = self:getChildGO("ColorUpAddAttrItem")
    
    self.m_nodeCurColor = self:getChildGO("NodeCurColor")
    self.m_imgCurColor = self:getChildGO("ImgCurColor"):GetComponent(ty.AutoRefImage)
    self.mTextUpTip = self:getChildGO("TextUpTip"):GetComponent(ty.Text)
    self.mGroupCostHero = self:getChildGO("GroupCostHero")
    self.mImgCostHead = self:getChildGO("ImgCostHead"):GetComponent(ty.AutoRefImage)
    self.mImgColorBg = self:getChildGO("ImgColorBg"):GetComponent(ty.AutoRefImage)
    self.mImgColor = self:getChildGO("ImgColor"):GetComponent(ty.AutoRefImage)
    self.mTextCostHero = self:getChildGO("TextCostHero"):GetComponent(ty.Text)
    self.mImgMoneyCost = self:getChildGO("ImgMoneyCost"):GetComponent(ty.AutoRefImage)
    self.mTextMoneyCost = self:getChildGO("TextMoneyCost"):GetComponent(ty.Text)
    self.m_btnColorUp = self:getChildGO("BtnColorUp")
    self.m_btnColorUpRect = self.m_btnColorUp:GetComponent(ty.RectTransform)
    self.m_goColorUpPreview = self:getChildGO("BtnColorUpPreview")
    self.m_btnColorUpPreview = self.m_goColorUpPreview:GetComponent(ty.Text)

    self.m_nodeNextColor = self:getChildGO("NodeNextColor")
    self.m_imgNextColor = self:getChildGO("ImgNextColor"):GetComponent(ty.AutoRefImage)
    self.m_nodeMaxColor = self:getChildGO("NodeMaxColor")
    self.m_imgMaxColor = self:getChildGO("ImgMaxColor"):GetComponent(ty.AutoRefImage)
    self.m_textMaxColorTip = self:getChildGO("TextMaxColorTip"):GetComponent(ty.Text)
    self.m_nodeNotColor = self:getChildGO("NodeNotColor")
    self.m_imgNotColor = self:getChildGO("ImgNotColor"):GetComponent(ty.AutoRefImage)
    self.m_textNotColorTip = self:getChildGO("TextNotColorTip"):GetComponent(ty.Text)

    self.mGroupSkill = self:getChildGO("GroupSkill")
    self.mImgSkillBg = self:getChildGO("ImgSkillBg"):GetComponent(ty.AutoRefImage)
    self.mBtnSkillIcon = self:getChildGO("mSkillIcon")
    self.mSkillIcon = self.mBtnSkillIcon:GetComponent(ty.AutoRefImage)
    self.mImgSkillCost = self:getChildGO("ImgSkillCost")
    self.mTextSkillCost = self:getChildGO("TextSkillCost"):GetComponent(ty.Text)
    self.mImgSkillDefine = self:getChildGO("ImgSkillDefine"):GetComponent(ty.Image)
    self.mTextSkillDefine = self:getChildGO("TextSkillDefine"):GetComponent(ty.Text)
    self.mTextSkillName = self:getChildGO("TextSkillName"):GetComponent(ty.Text)
    self.mTxtNeedStar = self:getChildGO("TextNeedColor"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.__onBagUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_COLOR_UP_PANEL, self.__onColorUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.__onUpdateHeroDetailDataHandler, self)
    hero.HeroFlagManager:addEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)

    local heroId = args.heroId
    self:setData(heroId)
end

function deActive(self)
    super.deActive(self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.__onBagUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_COLOR_UP_PANEL, self.__onColorUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.__onUpdateHeroDetailDataHandler, self)
    hero.HeroFlagManager:removeEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HERO_PREVIEW_ATTR,self.__updateColorUpAddAttrView,self)
    self.m_costHeroIdList = {}
    self:__closeMaterialPanel()
end

function initViewText(self)
    self.m_textMaxColorTip.text =  "—".._TT(1112).."—"--"当前已是最高品质"
    self.m_textNotColorTip.text = _TT(1313)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mGroupCostHero, self.__onClickBtnCostHeroHandler)
    self:addUIEvent(self.m_btnColorUp, self.__onClickBtnColorUpHandler)
    self:addUIEvent(self.mBtnSkillIcon, self.__onClickSkillTipHandler)
    self:addUIEvent(self.m_goColorUpPreview, self.__onClickColorUpPreviewlHandler)
end

-- 打开消耗英雄界面
function __onClickBtnCostHeroHandler(self)
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local maxColor = hero.HeroColorUpManager:getHeroMaxColor(heroVo.tid)
    if (heroVo.color < maxColor) then
        if(self.mMaterialPanel)then
            return
        end
        self.mMaterialPanel = hero.HeroMaterialPanel.new()
        local function _onDestroyPanelHandler(self)
            self.mMaterialPanel:removeEventListener(View.EVENT_VIEW_DESTROY, _onDestroyPanelHandler, self)
            self.mMaterialPanel = nil
        end
        self.mMaterialPanel:addEventListener(View.EVENT_VIEW_DESTROY, _onDestroyPanelHandler, self)

        local nextColorUpVo = hero.HeroColorUpManager:getHeroColorUpConfigVo(heroVo.tid, heroVo.color + 1)
        local costMoneyTid = nextColorUpVo.cost[1]
        local costMoneyCount = nextColorUpVo.cost[2]
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(nextColorUpVo.needHeroTid)
        local needName = heroConfigVo and heroConfigVo.name or ""
        local title = string.substitute(_TT(1120), nextColorUpVo.needHeroNum, hero.getColorName(nextColorUpVo.needHeroColor), needName)--"升品需要{0}名{1}品质{2}"
        local heroList = hero.HeroColorUpManager:getHeroList(nextColorUpVo.needHeroColor, nextColorUpVo.needHeroTid, self.m_curHeroId)
        local limitCount = nextColorUpVo.needHeroNum
        local remindTip = _TT(1121)  -- "所选战员品质大于待升品战员品质，是否继续添加？"
        local function _checkIsTipFun(heroIdList) -- 决定是否弹出二次确认提示的逻辑
            for i = 1, #heroIdList do
                local _heroVo = hero.HeroManager:getHeroVo(heroIdList[i])
                if(heroVo.color < _heroVo.color)then
                    return true
                end
            end
            return false
        end
        local function _confirmFun(heroIdList)
            self.m_costHeroIdList = heroIdList
            self:__updateCostInfo()
        end
        local function _visibleFun(isMaterialShow)
            if(self.m_groupAction and not gs.GoUtil.IsGoNull(self.m_groupAction))then
                self.m_groupAction:SetActive(not isMaterialShow)
            end
        end
        for i = 1, #self.m_costHeroIdList do
            self.mMaterialPanel:setSelectHeroId(self.m_costHeroIdList[i])
        end
        self.mMaterialPanel:setVisibleCall(_visibleFun)
        self.mMaterialPanel:setData(title, heroList, limitCount, remindTip, RemindConst.HERO_COLOR_UP_SELECT, _checkIsTipFun, nil, nil, _confirmFun)
        self.mMaterialPanel:open()
    else
        gs.Message.Show(_TT(1112))--当前已是最高品质
    end
end

-- 升品
function __onClickBtnColorUpHandler(self)
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local maxColor = hero.HeroColorUpManager:getHeroMaxColor(heroVo.tid)
    if (heroVo.color < maxColor) then
        local nextColorUpVo = hero.HeroColorUpManager:getHeroColorUpConfigVo(heroVo.tid, heroVo.color + 1)
        if(#self.m_costHeroIdList >= nextColorUpVo.needHeroNum)then
            GameDispatcher:dispatchEvent(EventName.REQ_HERO_COLOR_UP, { heroId = self.m_curHeroId, costHeroIdList = self.m_costHeroIdList })
        else
            gs.Message.Show(_TT(43702)) -- 材料不足
        end
    end
end

-- 打开属性详细信息
function __onClickBtnDetailHandler(self)
end

function __onClickSkillTipHandler(self)
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local isCanColorUp = hero.HeroColorUpManager:isCanColorUp(heroVo.tid)
    if (isCanColorUp) then
        local maxColor = hero.HeroColorUpManager:getHeroMaxColor(heroVo.tid)
        local color = math.min(maxColor, heroVo.color + 1)
        local skillId = hero.HeroColorUpManager:getHeroColorUpConfigVo(heroVo.tid, color).skillId
        TipsFactory:skillTips(nil, skillId, heroVo)
    end
end

function __recoverColorUpAddAttrList(self)
    if(self.mColorUpAddAttrList)then
        for i = 1, #self.mColorUpAddAttrList do
            self.mColorUpAddAttrList[i]:poolRecover()
        end
    end
    self.mColorUpAddAttrList = {}
end

-- 打开升品预览
function __onClickColorUpPreviewlHandler(self)
    self:__updateColorUpAddAttrView()
end

function __updateColorUpAddAttrView(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HERO_PREVIEW_ATTR,self.__updateColorUpAddAttrView,self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local addAttrList = {}
    local attrDic = curHeroVo.attrDic
    local preAttrDic = curHeroVo:getColorUpPreviewAttrDic()
	if(preAttrDic)then
		for key, value in pairs(preAttrDic) do
			local addAttrVo = nil
            if(attrDic[key])then
                -- Debug:log_info("self-->",key..","..value.."   "..attrDic[key])
                addAttrVo = {key = key, value = value - attrDic[key]}
            else
                addAttrVo = {key = key, value = key, value}
            end
            if(addAttrVo.value > 0)then
                addAttrVo.value = "+" .. AttConst.getValueStr(addAttrVo.key, addAttrVo.value)
                addAttrVo.key = AttConst.getName(key)
                if(key == AttConst.ATTACK)then
                    table.insert(addAttrList, 1, addAttrVo)
                elseif(key == AttConst.HP)then
                    table.insert(addAttrList, 2, addAttrVo)
                elseif(key == AttConst.DEFENSE)then
                    table.insert(addAttrList, 3, addAttrVo)
                elseif(key == AttConst.SPEED)then
                    table.insert(addAttrList, 4, addAttrVo)
                else
                    table.insert(addAttrList, addAttrVo)
                end
            end
		end
    else
        GameDispatcher:addEventListener(EventName.UPDATE_HERO_PREVIEW_ATTR,self.__updateColorUpAddAttrView,self)
        return
	end

    -- TipsFactory:AttrListTips(addAttrList)

    self:__recoverColorUpAddAttrList()
    for i = 1, #addAttrList do
        if(addAttrList[i])then
            local item = SimpleInsItem:create(self.m_colorUpAddAttrItem, self.m_groupAddAttr.transform, self.__cname .. "_ColorUpAddAttrItem")
            item:getChildGO("TextKey"):GetComponent(ty.Text).text = addAttrList[i].key
            item:getChildGO("TextValue"):GetComponent(ty.Text).text = addAttrList[i].value
            table.insert(self.mColorUpAddAttrList, item)
        end
    end
end

-- 英雄品质更新
function __onColorUpdateHandler(self, args)
    local heroId = args.heroId
    if (self.m_curHeroId == heroId) then
        self:__updateView()
    end
end

function __onBagUpdateHandler(self, args)
    self:__updateView()
end

function __onUpdateHeroDetailDataHandler(self, args)
    local heroId = args.heroId
    if (self.m_curHeroId == heroId) then
        self:__updateView()
    end
end

function onBubbleUpdateHandler(self, args)
    local heroId = args.heroId
    if (heroId == self.m_curHeroId) then
        if (args.flagType == hero.HeroFlagManager.FLAG_CAN_COLOR_UP) then
            self:__updateColorUpBubbleView(args.flagType, args.isFlag)
        end
    end
end

function __updateColorUpBubbleView(self, flagType, isFlag)
    if (not flagType and not isFlag) then
        isFlag = isFlag and isFlag or hero.HeroFlagManager:getFlag(self.m_curHeroId, hero.HeroFlagManager.FLAG_CAN_COLOR_UP)
    end
    if (isFlag) then
        RedPointManager:add(self.m_btnColorUp.transform, nil, -187.5, 28.5)
    else
        RedPointManager:remove(self.m_btnColorUp.transform)
    end
end

function setData(self, cusHeroId)
    self.m_curHeroId = cusHeroId
    local heroVo = hero.HeroManager:getHeroVo(cusHeroId)
    if (heroVo:checkIsPreData()) then
        return
    else
        self:__updateView()
        self:__updateColorUpBubbleView()
    end
end

function __updateView(self, isExpUpdate)
    local curHeroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)

    local isCanColorUp = hero.HeroColorUpManager:isCanColorUp(curHeroVo.tid)
    if(isCanColorUp)then
        local heroMaxColor = hero.HeroColorUpManager:getHeroMaxColor(curHeroVo.tid)
        if (curHeroVo.color >= heroMaxColor) then
            self.m_btnColorUpPreview.text = _TT(1113)--"满品预览"
            self:setBtnLabel(self.m_btnColorUp, 1114, "最高品质")
            
            self.m_groupAddAttr:SetActive(false)
            self.m_nodeCurColor:SetActive(false)
            self.m_nodeNextColor:SetActive(false)
            self.m_nodeMaxColor:SetActive(true)
            self.m_imgMaxColor:SetImg(UrlManager:getHeroColorCharacterIconUrl_2(curHeroVo.color), true)
            self.m_nodeNotColor:SetActive(false)

            self.m_btnColorUpPreview.gameObject:SetActive(false)
            self.mGroupSkill:SetActive(false)
        else
            self.m_btnColorUpPreview.text = _TT(1110)--"升格预览"
            self:setBtnLabel(self.m_btnColorUp, 1115, "升格")
    
            self.m_groupAddAttr:SetActive(true)
            self.m_nodeCurColor:SetActive(true)
            self.m_imgCurColor:SetImg(UrlManager:getHeroColorCharacterIconUrl_2(curHeroVo.color), true)
            self.m_nodeNextColor:SetActive(true)
            self.m_imgNextColor:SetImg(UrlManager:getHeroColorCharacterIconUrl_2(curHeroVo.color + 1), true)
            self.m_nodeMaxColor:SetActive(false)
            self.m_nodeNotColor:SetActive(false)
            
            self.m_btnColorUpPreview.gameObject:SetActive(true)
            self.mGroupSkill:SetActive(true)
            self:__updateColorUpAddAttrView()
            self:__updateSkillInfo()
            self:__updateCostInfo()
        end
    else --不能升品也显示满品
        self.m_btnColorUpPreview.text = _TT(1113)--"满品预览"
        self:setBtnLabel(self.m_btnColorUp, 1114, "最高品质")
        
        self.m_groupAddAttr:SetActive(false)
        self.m_nodeCurColor:SetActive(false)
        self.m_nodeNextColor:SetActive(false)
        self.m_nodeMaxColor:SetActive(true)
        self.m_imgMaxColor:SetImg(UrlManager:getHeroColorCharacterIconUrl_2(curHeroVo.color), true)
        self.m_nodeNotColor:SetActive(false)

        self.m_btnColorUpPreview.gameObject:SetActive(false)
        self.mGroupSkill:SetActive(false)
    end
    self:__updateGuide()

    -- 直接屏蔽不显示预览属性按钮
    self.m_btnColorUpPreview.gameObject:SetActive(false)
end

function __updateSkillInfo(self)
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local maxColor = hero.HeroColorUpManager:getHeroMaxColor(heroVo.tid)
    local skillId = hero.HeroColorUpManager:getHeroColorUpConfigVo(heroVo.tid, heroVo.color + 1).skillId
    -- 此处针对数值配置表未正式化会报错
    if(not skillId or skillId <= 0)then
        self.mGroupSkill:SetActive(false)
    else
        self.mGroupSkill:SetActive(true)
        local skillVo = fight.SkillManager:getSkillRo(skillId)
        self.mSkillIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
        self.mTextSkillCost.text = skillVo:getCost()
        if(skillVo:getType() == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL)then -- 主动技能
            self.mImgSkillBg:SetImg(UrlManager:getCommon4Path("common_1429.png"), true)
            self.mImgSkillCost:SetActive(true)
            self.mTextSkillCost.text = skillVo:getCost()
        elseif(skillVo:getType() == fight.FightDef.SKILL_TYPE_AOYI_SKILL)then -- 奥义技能
            self.mImgSkillBg:SetImg(UrlManager:getCommon4Path("common_1430.png"), true)
            self.mImgSkillCost:SetActive(false)
            self.mTextSkillCost.text = ""
        end
        if(#skillVo:getLocation() >= 2)then
            self.mImgSkillDefine.color = gs.ColorUtil.GetColor(skillVo:getLocation()[1])
            self.mTextSkillDefine.text = _TT(skillVo:getLocation()[2])
        else
            self.mImgSkillDefine.color = gs.ColorUtil.GetColor("FFFFFF00")
            self.mTextSkillDefine.text = ""
        end
        self.mTextSkillName.text = skillVo:getName()
        self.mTxtNeedStar.text = string.format(_TT(1117), hero.getColorName(heroVo.color + 1)) --升品至%s解锁该潜能
    end
end

function __updateCostInfo(self)
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local maxColor = hero.HeroColorUpManager:getHeroMaxColor(heroVo.tid)
    if (heroVo.color < maxColor) then
        local nextColorUpVo = hero.HeroColorUpManager:getHeroColorUpConfigVo(heroVo.tid, heroVo.color + 1)
        local costMoneyTid = nextColorUpVo.cost[1]
        local costMoneyCount = nextColorUpVo.cost[2]
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(nextColorUpVo.needHeroTid)
        local needName = heroConfigVo and heroConfigVo.name or ""
        local title = string.substitute(_TT(1120), nextColorUpVo.needHeroNum, hero.getColorName(nextColorUpVo.needHeroColor), needName)--"升品需要{0}名{1}品质{2}"

        local heroList = hero.HeroColorUpManager:getDefaultMaterialHeroIdList(nextColorUpVo.needHeroTid, 1, nextColorUpVo.needHeroColor, self.m_curHeroId)
        if(#self.m_costHeroIdList <= 0)then
            for i = 1, #heroList do
                if(#self.m_costHeroIdList < nextColorUpVo.needHeroNum)then
                    -- if(heroList[i].isLock == 0)then
                    --     table.insert(self.m_costHeroIdList, heroList[i].id)
                    -- end
                    if(hero.HeroUseCodeManager:getIsCanUse(heroList[i].id, false))then
                        table.insert(self.m_costHeroIdList, heroList[i].id)
                    end
                else
                    break
                end
            end
        end

        self.mTextUpTip.text = title
        self.mImgCostHead:SetImg(UrlManager:getHeroHeadUrl(heroVo.tid), true)
        self.mImgColorBg:SetImg(UrlManager:getHeroColorIconUrl_1(heroVo.color), true)
        self.mImgColor:SetImg(UrlManager:getHeroColorIconUrl_2(heroVo.color), true)
        self.mTextCostHero.text = #self.m_costHeroIdList .. "/" .. nextColorUpVo.needHeroNum

        self.mImgMoneyCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costMoneyTid), true)
        self.mTextMoneyCost.text = costMoneyCount
        self.mTextMoneyCost.color = gs.ColorUtil.GetColor(MoneyUtil.judgeNeedMoneyCountByTid(costMoneyTid, costMoneyCount, false, false) and "FFFFFFFF" or "ed1941FF")
    end
end

function __updateGuide(self)
    self:setGuideTrans("hero_colorup_btn_colorup", self.m_btnColorUpRect)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1313):	"该战员不能进行升格"
]]
