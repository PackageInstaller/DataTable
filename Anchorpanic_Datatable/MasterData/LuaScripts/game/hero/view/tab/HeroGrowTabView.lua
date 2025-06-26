module("hero.HeroGrowTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("hero/tab/HeroGrowTab.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.HeroGrow)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.showItems = {}
    self.conItems = {}
    self.mChildPropsItems = {}
    self.lineItems = {}
    self.skillGrid = nil
    self.preAttrList = {}
    self.nextAttrList = {}
end

function configUI(self)
    super.configUI(self)

    self.mSkillContent = self:getChildTrans("SkillContent")
    self.mSkillBtn = self:getChildGO("SkillBtn")

    self.mShowItems1 = self:getChildGO("Item1")
    self.mShowItems2 = self:getChildGO("Item2")
    self.mShowItems3 = self:getChildGO("Item3")
    self.mShowItems4 = self:getChildGO("Item4")

    table.insert(self.showItems, self.mShowItems1)
    table.insert(self.showItems, self.mShowItems2)
    table.insert(self.showItems, self.mShowItems3)
    table.insert(self.showItems, self.mShowItems4)

    self.mSelectLine1 = self:getChildGO("LineSelect1")
    self.mSelectLine2 = self:getChildGO("LineSelect2")
    self.mSelectLine3 = self:getChildGO("LineSelect3")
    table.insert(self.lineItems, self.mSelectLine1)
    table.insert(self.lineItems, self.mSelectLine2)
    table.insert(self.lineItems, self.mSelectLine3)

    self.mBgTxt1 = self:getChildGO("BgTxt1"):GetComponent(ty.Text)
    self.mBgTxt2 = self:getChildGO("BgTxt2"):GetComponent(ty.Text)
    self.mBgTxt3 = self:getChildGO("BgTxt3"):GetComponent(ty.Text)

    self.mGrowBtn = self:getChildGO("GrowBtn")
    self.mDefInfo = self:getChildGO("DefInfo")
    self.mMaxInfo = self:getChildGO("MaxInfo")
    self.mNeedInfo = self:getChildGO("NeedInfo")
    self.mPropsContent = self:getChildTrans("PropsContent")
    self.mConTxt = self:getChildGO("ConTxt"):GetComponent(ty.Text)
    self.mMaxTxt = self:getChildGO("MaxTxt"):GetComponent(ty.Text)
    self.mGrowTxt = self:getChildGO("GrowTxt"):GetComponent(ty.Text)
    self.mNeedTxt = self:getChildGO("NeedTxt"):GetComponent(ty.Text)
    self.mConImg = self:getChildGO("ConImg"):GetComponent(ty.AutoRefImage)
    self.mTxtTipsName = self:getChildGO("mTxtTipsName"):GetComponent(ty.Text)
    self.mTxtSkillName = self:getChildGO("mTxtSkillName"):GetComponent(ty.Text)
    self.mTxtSkillLevel = self:getChildGO("mTxtSkillLevel"):GetComponent(ty.Text)
    self.mConScrollView = self:getChildGO("ConScrollView"):GetComponent(ty.ScrollRect)
    self.mMaxInfo.gameObject:SetActive(false)
    self:setGuideTrans("funcTips_heroGrow_1", self:getChildTrans("TipsTran"))
    self:setGuideTrans("guide_Btn_Grow", self:getChildTrans("GrowBtn"))
end

function active(self, args)
    super.active(self, args)
    self.heroId = args.heroId
    -- GameDispatcher:addEventListener(EventName.UPDATE_HERO_GROW_TABVIEW, self.__updateGrowPanelHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_HERO_GROW_ATTR, self.onRecAttrHandler, self)
    -- GameDispatcher:dispatchEvent(EventName.REQ_HERO_INCREASE_ATTR, { heroId = self.heroId })
    hero.HeroFlagManager:addEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateTabView, self)
    self:updateBubbleView(hero.HeroFlagManager:getFlag(self.heroId, hero.HeroFlagManager.FLAG_CAN_GROW))
end

-- function __updateGrowPanelHandler(self, msg)
--     GameDispatcher:dispatchEvent(EventName.REQ_HERO_INCREASE_ATTR, { heroId = self.heroId })
-- end

function onBubbleUpdateHandler(self, args)
    local heroId = args.heroId
    if (args.flagType == hero.HeroFlagManager.FLAG_CAN_GROW) then
        self:updateBubbleView(args.isFlag)
    end
end

function updateBubbleView(self, isFlag)
    if (isFlag) then
        RedPointManager:add(self.mGrowBtn.transform, nil, -187.5, 28.5)
    else
        RedPointManager:remove(self.mGrowBtn.transform)
    end
end

function onRecAttrHandler(self, msg)
    self.cusLv = msg.increases_lv
    local serverNextList = msg.next_attr_list
    -- 按防、血、攻排序 13 11 12
    if (msg.pre_attr_list == nil or #msg.pre_attr_list == 0) then
        if (msg.next_attr_list == nil or #msg.next_attr_list == 0) then
            return
        end
        self.preAttrList = self.nextAttrList
        table.insert(serverNextList, 1, serverNextList[3])
        table.remove(serverNextList, 4)
        self.nextAttrList = serverNextList
    else
        local serverPreList = msg.pre_attr_list
        table.insert(serverPreList, 1, serverPreList[3])
        table.remove(serverPreList, 4)

        table.insert(serverNextList, 1, serverNextList[3])
        table.remove(serverNextList, 4)
        self.preAttrList = msg.pre_attr_list
        self.nextAttrList = serverNextList
    end

    self:updateTabView()
end

function updateTabView(self)
    self.heroVo = hero.HeroManager:getHeroVo(self.heroId)

    self.heroIncreases = hero.HeroManager:getHeroIncreaseData(self.heroVo.tid)

    self.cusLvData = self.heroIncreases.increaseDic[self.cusLv]

    self.maxLv = sysParam.SysParamManager:getValue(821)

    if self.skillGrid ~= nil then
        self.skillGrid:poolRecover()
    end

    self.skillId = self.heroVo.baseSkillIdList[1]
    self.mTxtSkillName.text = fight.SkillManager:getSkillRo(self.skillId):getName()
    self.skillGrid = SkillGrid:create(self.mSkillContent, { skillId = self.skillId, heroVo = self.heroVo }, 1)
    self.skillGrid:setClickEnable(false)

    local skillVo = fight.SkillManager:getSkillRo(self.skillId)
    if (self.heroVo and self.heroVo.activeSkillDic and self.heroVo.activeSkillDic[skillVo:getRefID()]) then
        self.mTxtSkillLevel.text = _TT(1361) .. self.heroVo.activeSkillDic[skillVo:getRefID()]
    end

    self:__clearPropsItem()
    -- 未达最大增幅等级
    if self.cusLv < self.maxLv then
        -- self.mTitle:SetActive(true)
        local showLine = (self.cusLv - 1) % 4

        for i = 1, #self.lineItems do
            if i <= showLine then
                self.lineItems[i]:SetActive(true)
            else
                self.lineItems[i]:SetActive(false)
            end
        end

        for i = 1, #self.showItems do
            local rem = self.cusLv % 4
            if rem == 0 then
                rem = 4
            end
            local icon = self.showItems[i].transform:Find("Icon").gameObject:GetComponent(ty.AutoRefImage)
            local max = self.showItems[i].transform:Find("Max").gameObject

            if i <= showLine then
                max:SetActive(true)
                icon:SetImg(UrlManager:getPackPath("hero5/hero_grow_" .. i .. ".png"), false)
            else
                max:SetActive(false)
                icon:SetImg(UrlManager:getPackPath("hero5/hero_grow_" .. i .. ".png"), false)
            end

            local isSelect = self.showItems[i].transform:Find("isSelect").gameObject

            if i == rem then
                isSelect:SetActive(true)
                max:SetActive(true)
                if i < 4 then
                    local AddValue = self.showItems[i].transform:Find("mGroup/AddValue").gameObject
                    AddValue:SetActive(true)
                end
            else
                isSelect:SetActive(false)
                if i < 4 then
                    local AddValue = self.showItems[i].transform:Find("mGroup/AddValue").gameObject
                    AddValue:SetActive(false)
                end
            end
        end

        if #self.preAttrList == 0 then
            for i = 1, #self.showItems - 1 do
                local valueTxt = self.showItems[i].transform:Find("mGroup/ValueTxt"):GetComponent(ty.Text)
                valueTxt.text = _TT(45009) .. "0"
                valueTxt.color = gs.ColorUtil.GetColor("292b32FF")
                self.showItems[i].transform:Find("mGroup/AddValue"):GetComponent(ty.Text).text = self.nextAttrList[i].value
            end
        else
            local rem = self.cusLv % 4
            if rem == 0 then
                rem = 4
            end

            for i = 1, #self.showItems - 1 do
                local valueTxt = self.showItems[i].transform:Find("mGroup/ValueTxt"):GetComponent(ty.Text)
                if i == rem then
                    valueTxt.text = _TT(45009) .. self.preAttrList[i].value
                    valueTxt.color = gs.ColorUtil.GetColor("292b32FF")
                    self.showItems[i].transform:Find("mGroup/AddValue"):GetComponent(ty.Text).text = self.nextAttrList[i].value - self.preAttrList[i].value
                else
                    valueTxt.text = _TT(45009) .. self.preAttrList[i].value
                    valueTxt.color = gs.ColorUtil.GetColor("292b32FF")
                end
            end
        end

        local needLv = self.cusLvData.needHeroLv

        if (needLv > self.heroVo.lvl) then
            self.mGrowTxt.gameObject:SetActive(false)
            self.mNeedTxt.text = _TT(1218, needLv)
            self.mNeedTxt.gameObject:SetActive(true)
            self.mNeedInfo.gameObject:SetActive(true)
            self.mDefInfo.gameObject:SetActive(false)
        else
            self.mGrowTxt.gameObject:SetActive(true)
            self.mNeedTxt.gameObject:SetActive(false)
            self.mNeedInfo.gameObject:SetActive(false)
            self.mDefInfo.gameObject:SetActive(true)
        end

        self.mConImg:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.cusLvData.payId), true)

        self.mConTxt.text = self.cusLvData.payNum

        local mon = MoneyUtil.getMoneyCountByTid(self.cusLvData.payId)

        if mon < self.cusLvData.payNum then
            self.mConTxt.color = gs.ColorUtil.GetColor("DF1E1EFF")
        else
            self.mConTxt.color = gs.ColorUtil.GetColor("FFFFFFFF")
        end

        for i = 1, #self.cusLvData.const do
            local item = SimpleInsItem:create(self:getChildGO("GroupCostItem"), self.mPropsContent, "GrowCostItem")
            local data = { tid = self.cusLvData.const[i][1], num = self.cusLvData.const[i][2] }
            local propsGrid = PropsGrid:create(item:getChildTrans("GroupCostGrid"), data, 1)
            propsGrid:setIsShowCount(false)
            -- propsGrid:setParent(item:getChildTrans("GroupCostGrid"))

            local needNum = self.cusLvData.const[i][2]
            local ownNum = bag.BagManager:getPropsCountByTid(self.cusLvData.const[i][1])

            item:setText("TextCostOwn", nil, ownNum >= needNum and _TT(45013, ownNum, needNum) or _TT(45014, ownNum, needNum))
            table.insert(self.mChildPropsItems, propsGrid)
            table.insert(self.conItems, item)
        end

        self.mMaxInfo.gameObject:SetActive(false)

    else
        for i = 1, #self.lineItems do
            self.lineItems[i]:SetActive(true)

        end

        for i = 1, #self.showItems - 1 do
            self.showItems[i].transform:Find("mGroup/ValueTxt"):GetComponent(ty.Text).text = _TT(45009) .. self.preAttrList[i].value
            self.showItems[i].transform:Find("mGroup/ValueTxt"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("173cc7FF")
            self.showItems[i].transform:Find("mGroup/AddValue").gameObject:SetActive(false)
        end

        for i = 1, #self.showItems do
            self.showItems[i].transform:Find("isSelect").gameObject:SetActive(false)
            self.showItems[i].transform:Find("Max").gameObject:SetActive(true)
        end


        self.mDefInfo.gameObject:SetActive(false)
        self.mNeedInfo.gameObject:SetActive(false)
        self.mMaxInfo.gameObject:SetActive(true)
    end
end

function __clearPropsItem(self)
    for i = 1, #self.mChildPropsItems do
        self.mChildPropsItems[i]:poolRecover()
    end
    self.mChildPropsItems = {}

    for i = 1, #self.conItems do
        self.conItems[i]:poolRecover()
    end
    self.conItems = {}
end

function deActive(self)
    super.deActive(self)
    -- GameDispatcher:removeEventListener(EventName.UPDATE_HERO_GROW_TABVIEW, self.__updateGrowPanelHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HERO_GROW_ATTR, self.onRecAttrHandler, self)
    hero.HeroFlagManager:removeEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateTabView, self)
    self:__clearPropsItem()
    RedPointManager:remove(self.mGrowBtn.transform)
end

function initViewText(self)
    -- 顺序： 防 血 攻 - 13 11 12
    self.mBgTxt1.text = _TT(3103)
    self.mBgTxt2.text = _TT(3101)
    self.mBgTxt3.text = _TT(3102)
    self.mMaxTxt.text = _TT(45007)
    self.mGrowTxt.text = _TT(45016)
    self.mTxtTipsName.text = _TT(53510)--“消耗材料”
end

function addAllUIEvent(self)
    self:addUIEvent(self.mSkillBtn, self.__onSkillClickHandler)
    self:addUIEvent(self.mGrowBtn, self.__onGrowClickHandler)

    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.HeroGrow })
end

function __onSkillClickHandler(self)
    if (self.heroId and self.skillId) then   --防止弱网状态下数据不存在
        -- local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.heroVo.tid)
        -- self.skillId = heroConfigVo.baseSkillIdList[1]
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_SKILL_INFO, { heroId = self.heroId, skillId = self.skillId })
    end
end

-- 增幅按钮被点击
function __onGrowClickHandler(self)
    local needLv = self.cusLvData.needHeroLv
    if (needLv > self.heroVo.lvl) then
        gs.Message.Show(_TT(1351, needLv))
        return
    end

    local ok = true
    for i = 1, #self.cusLvData.const do
        local data = { tid = self.cusLvData.const[i][1], num = self.cusLvData.const[i][2] }
        local num = bag.BagManager:getPropsCountByTid(data.tid)
        if (num < data.num) then
            ok = false
        end
    end

    if ok == false then
        gs.Message.Show(_TT(45001))
        return
    end

    local mon = MoneyUtil.getMoneyCountByTid(self.cusLvData.payId)

    if mon < self.cusLvData.payNum then
        ok = false
    end

    if ok == false then
        gs.Message.Show(_TT(45002)) -- ("所需货币不足,无法增幅")
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_HERO_GROWUP, { id = self.heroId })
    if (self.cusLv % 4 == 0) then
        gs.Message.Show("技能升级成功")
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1272):	"需要达到"
]]