module("guild.GuildSkillPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildSkillPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle("联盟科技")
    self:setSize(0, 0)
    self:setBg("guild_skill_bg.jpg", false, "guild")
    -- self:setUICode(LinkCode.Guild)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mAttrList = {}
    self.mSkillList = {}
    self.mDesList = {}
    self.mTxtList = {}

    self.mMoneyList = {}

    self.mUpSnList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mSkillAll = self:getChildGO("mSkillAll")
    self.mTxtAllSkill = self:getChildGO("mTxtAllSkill"):GetComponent(ty.Text)
    self.mTxtAllSkillLv = self:getChildGO("mTxtAllSkillLv"):GetComponent(ty.Text)
    -- self.mTxtAllLv = self:getChildGO("mTxtAllLv"):GetComponent(ty.Text)

    self.mSkillItem0 = self:getChildGO("mSkillItem0")
    self.mSkillItem1 = self:getChildGO("mSkillItem1")
    self.mSkillItem2 = self:getChildGO("mSkillItem2")
    self.mSkillItem3 = self:getChildGO("mSkillItem3")
    self.mSkillItem4 = self:getChildGO("mSkillItem4")
    self.mSkillItem5 = self:getChildGO("mSkillItem5")

    table.insert(self.mSkillList, self.mSkillItem0)
    table.insert(self.mSkillList, self.mSkillItem1)
    table.insert(self.mSkillList, self.mSkillItem2)
    table.insert(self.mSkillList, self.mSkillItem3)
    table.insert(self.mSkillList, self.mSkillItem4)
    table.insert(self.mSkillList, self.mSkillItem5)

    self.mSkillInfoTips = self:getChildGO("mSkillInfoTips")
    self.mTxtSkillEleName = self:getChildGO("mTxtSkillEleName"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtLvCurrent = self:getChildGO("mTxtLvCurrent"):GetComponent(ty.Text)
    self.mTxtLvNext = self:getChildGO("mTxtLvNext"):GetComponent(ty.Text)
    self.mAttrContent = self:getChildTrans("mAttrContent")
    self.mMaxContent = self:getChildTrans("mMaxContent")
    self.mAttrItem = self:getChildGO("mAttrItem")
    self.mMaxAttrItem = self:getChildGO("mMaxAttrItem")

    self.mPropsContent = self:getChildTrans("mPropsContent")
    -- self.mTxtPropsCount1 = self:getChildGO("mTxtPropsCount1"):GetComponent(ty.Text)
    -- self.mImgProps1 = self:getChildGO("mImgProps1"):GetComponent(ty.AutoRefImage)

    self.mTxtPropsCount = self:getChildGO("mTxtPropsCount"):GetComponent(ty.Text)
    self.mImgProps = self:getChildGO("mImgProps"):GetComponent(ty.AutoRefImage)

    self.mBtnUpgrade = self:getChildGO("mBtnUpgrade")

    self.mSkillInfoTipsAll = self:getChildGO("mSkillInfoTipsAll")

    -- self.mCloseSkillInfo = self:getChildGO("mCloseSkillInfo")
    -- self.mCloseSkillInfoAll = self:getChildGO("mCloseSkillInfoAll")
    self.mSkillDesContent = self:getChildTrans("mSkillDesContent")
    self.mTxtItem = self:getChildGO("mTxtItem")

    self.mTxtSkillTips = self:getChildGO("mTxtSkillTips"):GetComponent(ty.Text)

    self.mTipsTxtAllLv = self:getChildGO("mTipsTxtAllLv"):GetComponent(ty.Text)
    self.mTipsTxtAllLvCount = self:getChildGO("mTipsTxtAllLvCount"):GetComponent(ty.Text)
    self.mUpInfo = self:getChildGO("mUpInfo")
    self.mMaxInfo = self:getChildGO("mMaxInfo")
    self.mBtnMaxLv = self:getChildGO("mBtnMaxLv")

    self.mTxtLvMax = self:getChildGO("mTxtLvMax"):GetComponent(ty.Text)

    self.mMoneyItem = self:getChildTrans("mMoneyItem")

    self.mLeftRoot = self:getChildTrans("mLeftRoot")

    self.mAllSkillIsSelect = self:getChildGO("mAllSkillIsSelect")

    self.mCloseTips = self:getChildGO("mCloseTips")

    self.mUpFX = self:getChildGO("mUpFX")

    self.mSkillAllTrans = self:getChildTrans("mSkillAll")

    self.mBtnCloseInfo = self:getChildGO("mBtnCloseInfo")
    self.mBtnCloseInfoAll = self:getChildGO("mBtnCloseInfoAll")
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_SKILL_PANEL, self.upShowPanel, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)

    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_SKILL_PANEL, self.upShowPanel, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    self:clearAttrItem()
    self:clearDesList()

    if self.propsGrid then
        self.propsGrid:poolRecover()
        self.propsGrid = nil
    end

    self:clearMoneyList()
    if self.fx then
        self.fx:poolRecover()
        self.fx = nil
    end
    self.selectId = nil

    for i = 1, #self.mUpSnList do
        LoopManager:removeFrameByIndex(self.mUpSnList[i])
    end
    self.mUpSnList = {}
    self:onClickHideTips()
end

function onBagUpdateHandler(self)
    self:upShowPanel()
end

function upShowPanel(self)
    self:showPanel()
    if self.fx then
        self.fx:poolRecover()
        self.fx = nil
    end

    self.fx = SimpleInsItem:create(self.mUpFX, self.mSkillAllTrans, "myGuildSkillUpFx")

    if self.selectId then
        self:clickSkillItem(self.selectId, true)
    end

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mSkillAll, self.onClickSkillAll)

    self:addUIEvent(self.mSkillItem0, self.onClickSkill, nil, 0)
    self:addUIEvent(self.mSkillItem1, self.onClickSkill, nil, 1)
    self:addUIEvent(self.mSkillItem2, self.onClickSkill, nil, 2)
    self:addUIEvent(self.mSkillItem3, self.onClickSkill, nil, 3)
    self:addUIEvent(self.mSkillItem4, self.onClickSkill, nil, 4)
    self:addUIEvent(self.mSkillItem5, self.onClickSkill, nil, 5)

    self:addUIEvent(self.mBtnUpgrade, self.onBtnUpgradeClick)

    self:addUIEvent(self.mCloseTips, self.onClickHideTips)

    self:addUIEvent(self.mBtnCloseInfo, self.onClickHideTips)
    self:addUIEvent(self.mBtnCloseInfoAll, self.onClickHideTips)
end

function initViewText(self)
    self.mTxtAllSkill.text = "科技水平"
    self.mTipsTxtAllLv.text = "科技水平"
    self.mTxtSkillTips.text = "科技水平"
    self:getChildGO("mTxtRecommandFormation"):GetComponent(ty.Text).text = _TT(94986)
    self:getChildGO("mTxtRecommandFormation2"):GetComponent(ty.Text).text = _TT(94986)

end

function onClickHideTips(self)
    if self.tween then
        self.tween:Kill()
    end
    self.tween = TweenFactory:move2LPosX(self.mLeftRoot, 0, 0.3)

    self.selectId = nil
    for i = 1, #self.mSkillList do
        self.mSkillList[i].transform:Find("mIsSelect").gameObject:SetActive(false)
    end
    self.mAllSkillIsSelect:SetActive(false)

    self.mSkillInfoTips:SetActive(false)
    self.mSkillInfoTipsAll:SetActive(false)
end

function onClickSkill(self, id)
    if self.tween then
        self.tween:Kill()
    end
    self.tween = TweenFactory:move2LPosX(self.mLeftRoot, -250, 0.3)

    self:clickSkillItem(id)
    self.mSkillInfoTipsAll:SetActive(false)
end

function clearMoneyList(self)
    for i = 1, #self.mMoneyList do
        self.mMoneyList[i]:poolRecover()
    end
    self.mMoneyList = {}
end

function onClickSkillAll(self)
    if self.tween then
        self.tween:Kill()
    end
    self.tween = TweenFactory:move2LPosX(self.mLeftRoot, -250, 0.3)

    self.mSkillInfoTips:SetActive(false)
    self.mAllSkillIsSelect:SetActive(true)
    self.mSkillInfoTipsAll:SetActive(true)
    local effList = guild.GuildManager:getGuildEffData()

    self:clearDesList()

    gs.TransQuick:UIPosY(self.mSkillDesContent, 0)

    for i = 1, #effList do
        local item = SimpleInsItem:create(self.mTxtItem, self.mSkillDesContent, "myGuildSkillTxtItem")
        -- local skillVo = fight.SkillManager:getSkillRo(effList[i].skillId)

        item:getChildGO("mTxtSkillName"):GetComponent(ty.Text).text = _TT(effList[i].arrName)
        item:getChildGO("mTxtSkillDes"):GetComponent(ty.Text).text = _TT(effList[i].arrShow)
        item:getChildGO("mTxtSkillLock"):GetComponent(ty.Text).text = "科技水平" .. effList[i].needLv .. "级解锁"
        item:getChildGO("mTxtSkillLock"):SetActive(effList[i].needLv > self.allLv)
        if effList[i].needLv <= self.allLv then
            item:getChildGO("mTxtSkillDes"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("323232ff")
        else
            item:getChildGO("mTxtSkillDes"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("82898cff")
        end

        table.insert(self.mTxtList, item)
    end
end

function clearDesList(self)
    for i = 1, #self.mTxtList do
        self.mTxtList[i]:poolRecover()
    end
    self.mTxtList = {}
end

function clickSkillItem(self, id, isUp)

    self.selectId = id
    self.mSkillInfoTips:SetActive(true)
    self.mImgIcon:SetImg(UrlManager:getHeroEleTypeIconUrl(self.selectId), false)
    local color, name = hero.getHeroTypeName(self.selectId)

    self.mTxtSkillEleName.text = name .. "研究"

    local maxLv = guild.GuildManager:getGuildSkillMaxLv(id)

    for i = 1, #self.mSkillList do
        self.mSkillList[i].transform:Find("mIsSelect").gameObject:SetActive(i == self.selectId + 1)
    end

    local selectMsgData = self:getSkillMsgData(id)
    local curData = guild.GuildManager:getGuildSkillData(id, selectMsgData.lv)

    self:clearMoneyList()

    self.mMoneyBatItem1 = MoneyItem:poolGet()
    self.mMoneyBatItem1:setData(self.mMoneyItem, {
        tid = curData.needStuff[1][1],
        frontType = 2
    })

    self.mMoneyBatItem2 = MoneyItem:poolGet()
    self.mMoneyBatItem2:setData(self.mMoneyItem, {
        tid = curData.needStuff[2][1],
        frontType = 2
    })

    table.insert(self.mMoneyList, self.mMoneyBatItem1)
    table.insert(self.mMoneyList, self.mMoneyBatItem2)

    local isMaxLv = maxLv == selectMsgData.lv
    if isMaxLv then
        self.mTxtLvMax.text = _TT(1361) .. selectMsgData.lv
    else
        self.mTxtLvCurrent.text = _TT(1361) .. selectMsgData.lv
        self.mTxtLvNext.text = _TT(1361) .. selectMsgData.lv + 1
    end

    local curAttr = selectMsgData.cur_lv_attr_list
    local nextAttr = selectMsgData.next_lv_attr_list

    table.sort(curAttr, function(vo1, vo2)
        return vo1.key < vo2.key
    end)
    table.sort(nextAttr, function(vo1, vo2)
        return vo1.key < vo2.key
    end)

    for i = 1, #self.mUpSnList do
        LoopManager:removeFrameByIndex(self.mUpSnList[i])
    end
    self.mUpSnList = {}
    self:clearAttrItem()

    if isMaxLv then
        for i = 1, #curAttr do
            local item = SimpleInsItem:create(self.mMaxAttrItem, self.mMaxContent, "myGuildSkillMaxItem")
            item:getChildGO("mTxtDesAttr"):GetComponent(ty.Text).text = AttConst.getName(curAttr[i].key)
            item:getChildGO("mTxtCurAttr"):GetComponent(ty.Text).text =             AttConst.getValueStr(curAttr[i].key, curAttr[i].value)
            table.insert(self.mAttrList, item)
        end
    else
        for i = 1, #curAttr do
            local item = SimpleInsItem:create(self.mAttrItem, self.mAttrContent, "myGuildSkillItem")
            item:getChildGO("mTxtDesAttr"):GetComponent(ty.Text).text = AttConst.getName(curAttr[i].key)
            item:getChildGO("mTxtCurAttr"):GetComponent(ty.Text).text =             AttConst.getValueStr(curAttr[i].key, curAttr[i].value)
            item:getChildGO("mTxtNextAttr"):GetComponent(ty.Text).text =             AttConst.getValueStr(curAttr[i].key, nextAttr[i].value)
            item:getChildGO("mImgUp"):SetActive(nextAttr[i].value ~= curAttr[i].value)
            if isUp then
                item.m_go:SetActive(false)
                local upSn = LoopManager:addFrame(i * 4, 1, self, function()
                    item.m_go:SetActive(true)
                    item.m_go:GetComponent(ty.Animator):SetTrigger("show")
                end)
                table.insert(self.mUpSnList, upSn)
            end
            table.insert(self.mAttrList, item)
        end
    end

    if self.propsGrid then
        self.propsGrid:poolRecover()
        self.propsGrid = nil
    end

    if isMaxLv then
        self.mUpInfo:SetActive(false)
        self.mMaxInfo:SetActive(true)
    else
        self.mUpInfo:SetActive(true)
        self.mMaxInfo:SetActive(false)

        self.propsGrid = PropsGrid:create(self.mPropsContent, {
            tid = curData.needStuff[1][1],
            num = curData.needStuff[1][2]
        }, 0.8, false)
        local hasCount = MoneyUtil.getMoneyCountByTid(curData.needStuff[1][1])
        self.propsGrid:setShowNum(hasCount, curData.needStuff[1][2])
        self.propsGrid:setIsShowCount(false)

        self.mImgProps:SetImg(MoneyUtil.getMoneyIconUrlByTid(curData.needStuff[2][1]), false)
        self.mTxtPropsCount.text = curData.needStuff[2][2]

        local hasCount2 = MoneyUtil.getMoneyCountByTid(curData.needStuff[2][1])
        if hasCount2 >= curData.needStuff[2][2] then
            self.mTxtPropsCount.color = gs.ColorUtil.GetColor("000000ff")
        else
            self.mTxtPropsCount.color = gs.ColorUtil.GetColor("f94234ff")
        end

    end
end

function onBtnUpgradeClick(self)
    local selectMsgData = self:getSkillMsgData(self.selectId)
    local curData = guild.GuildManager:getGuildSkillData(self.selectId, selectMsgData.lv)

    local result, tips =     MoneyUtil.judgeNeedMoneyCountByTid(curData.needStuff[1][1], curData.needStuff[1][2], true, true)
    if tips == "" and result == true then
        local result2, tips2 = MoneyUtil.judgeNeedMoneyCountByTid(curData.needStuff[2][1], curData.needStuff[2][2],
        true, true)
        if tips2 == "" and result2 == true then
            GameDispatcher:dispatchEvent(EventName.REQ_UPGRADE_GUILD_SKILL, {
                id = self.selectId
            })
        else
            gs.Message.Show(tips2)
        end
    else
        gs.Message.Show(_TT(156))
    end
end

function clearAttrItem(self)
    for i = 1, #self.mAttrList do
        self.mAttrList[i]:poolRecover()
    end
    self.mAttrList = {}
end

function showPanel(self)
    self.skillList = guild.GuildManager:getSkillInfo()
    self.allLv = 0

    for i = 1, #self.mSkillList do
        local lv = self:getSkillMsgData(i - 1).lv
        self.mSkillList[i].transform:Find("mIcon"):GetComponent(ty.AutoRefImage):SetImg(
        UrlManager:getHeroEleTypeIconUrl(i - 1), false)
        local color, name = hero.getHeroTypeName(i - 1)
        self.mSkillList[i].transform:Find("mTxt"):GetComponent(ty.Text).text = name
        self.mSkillList[i].transform:Find("mIsSelect/mTxtSelect"):GetComponent(ty.Text).text = name
        self.mSkillList[i].transform:Find("mTxtLv"):GetComponent(ty.Text).text = _TT(1361) .. lv
        self.mSkillList[i].transform:Find("mIsSelect/mTxtLvSelect"):GetComponent(ty.Text).text = _TT(1361) .. lv
        if self.selectId then
            self.mSkillList[i].transform:Find("mIsSelect").gameObject:SetActive(i == self.selectId + 1)
        else
            self.mSkillList[i].transform:Find("mIsSelect").gameObject:SetActive(false)
        end

        local redTran = self.mSkillList[i].transform:Find("mBtnClick").transform
        if guild.GuildManager:canUpSkillSingle(i - 1) then
            RedPointManager:add(redTran, nil, -32.8, 42.5)
        else
            RedPointManager:remove(redTran, nil, 0, 0)
        end
        self.allLv = self.allLv + lv
    end

    self.mTxtAllSkillLv.text = self.allLv
    self.mTipsTxtAllLvCount.text = self.allLv
end

function getSkillMsgData(self, id)
    for k, v in pairs(self.skillList) do
        if v.id == id then
            return v
        end
    end
    return nil
end

return _M