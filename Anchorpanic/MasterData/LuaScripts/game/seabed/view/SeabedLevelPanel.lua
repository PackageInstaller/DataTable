-- 海底难度选择界面
module("seabed.SeabedLevelPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedLevelPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(111032))
    self:setSize(0, 0)
    self:setBg("seabed_main.jpg", false, "seabed")
end
-- 初始化数据
function initData(self)
    super.initData(self)

    self.mLevelItems = {}
    self.mShowPropsItems = {}

    self.mTeaserDesItems = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mLevelScroll = self:getChildGO("mLevelScroll"):GetComponent(ty.ScrollRect)
    self.mLevelItem = self:getChildGO("mLevelItem")

    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtLevel = self:getChildGO("mTxtLevel"):GetComponent(ty.Text)
    self.mTxtAward = self:getChildGO("mTxtAward"):GetComponent(ty.Text)

    self.mAwardScroll = self:getChildGO("mAwardScroll"):GetComponent(ty.ScrollRect)

    self.mBtnFight = self:getChildGO("mBtnFight")

    self.mTeasetInfo = self:getChildGO("mTeaserInfo")
    self.mTxtTeaser = self:getChildGO("mTxtTeaser"):GetComponent(ty.Text)
    self.mTeaserContent = self:getChildTrans("mTeaserContent")
    self.mTeaserDesItem = self:getChildGO("mTeaserDesItem")
    self.mBtnLast = self:getChildGO("mBtnLast")
    self.mBtnNext = self:getChildGO("mBtnNext")

    self.mImgNo = self:getChildGO("mImgNo")

    self:setGuideTrans("functips_seabed_function_levelScroll", self:getChildTrans("mLevelScroll"))
    self:setGuideTrans("functips_seabed_function_des", self:getChildTrans("function_des"))
    self:setGuideTrans("functips_seabed_function_fight", self.mBtnFight.transform)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self:showPanel()
    local maxDif = seabed.SeabedManager:getHisUnLockMaxDifficulty()
    self:onClickLevelItem(maxDif)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearLevelItems()
    self:clearPropsItems()
    self:clearTeaserDesItems()
end

function initViewText(self)
    self:getChildGO("mTxtAward"):GetComponent(ty.Text).text = _TT(111035)
    self:getChildGO("mTxtFight"):GetComponent(ty.Text).text = _TT(111036)
    self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text).text = _TT(111037)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onBtnFightClickHandler)
    self:addUIEvent(self.mBtnLast, self.onBtnLastClickHandler)
    self:addUIEvent(self.mBtnNext, self.onBtnNextClickHandler)
end

function getDifTiple(self,id)
    local difList = seabed.SeabedManager:getSeabedDifficultyData()
    for i = 1,#difList do
        if difList[i].id == id then
            return difList[i].difficultyTitle
        end
    end
end

function showPanel(self)
    self:clearLevelItems()
    local difficultyList = seabed.SeabedManager:getSeabedDifficultyData()
    
    for i = 1, #difficultyList do
        local item = SimpleInsItem:create(self.mLevelItem, self.mLevelScroll.content, "mSeabedLevelItem")
        local isLock = seabed.SeabedManager:getDifficultyIsLock(difficultyList[i].id)
        local tips = _TT(self:getDifTiple(difficultyList[i].id))

        item:getChildGO("mTxtTips"):GetComponent(ty.Text).text =
            isLock and _TT(4062) or tips
        item:getChildGO("mTxtSelect"):GetComponent(ty.Text).text = tips
        item:getChildGO("mTxtTips"):GetComponent(ty.Text).color =
            isLock and gs.ColorUtil.GetColor("478798FF") or gs.ColorUtil.GetColor("7FB3BEFF")
        item:getChildGO("mIsLock"):SetActive(isLock)

        item:getChildGO("mLevelClick"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getPackPath(isLock and "seabed/dif_lock.png" or "seabed/dif_def.png", false))

        item:addUIEvent("mLevelClick", function()
            self:onClickLevelItem(difficultyList[i].id)
        end)
        table.insert(self.mLevelItems, item)
    end
end

function clearLevelItems(self)
    for i = 1, #self.mLevelItems do
        self.mLevelItems[i]:poolRecover()
    end
    self.mLevelItems = {}
end

function clearPropsItems(self)
    for i = 1, #self.mShowPropsItems do
        self.mShowPropsItems[i]:poolRecover()
    end
    self.mShowPropsItems = {}
end

function clearTeaserDesItems(self)
    for i = 1, #self.mTeaserDesItems do
        self.mTeaserDesItems[i]:poolRecover()
    end
    self.mTeaserDesItems = {}
end

function onClickLevelItem(self, id)
    local isLock = seabed.SeabedManager:getDifficultyIsLock(id)

    if isLock then
        gs.Message.Show(_TT(4062))
        return
    end

    self.mBtnFight:SetActive(isLock == false)
    self.curClickId = id
    local vo = seabed.SeabedManager:getSeabedDifficultyDataById(id)
    self.mTxtTitle.text = _TT(vo.difficultyTitle)
    self.mTxtDes.text = _TT(vo.difficultyDes)
    self.mTxtLevel.text = _TT(3085) .. vo.suggestLevel

    for i = 1, #self.mLevelItems do
        self.mLevelItems[i]:getChildGO("mIsSelect"):SetActive(id == i)
    end

    self:clearPropsItems()
    local list = AwardPackManager:getAwardListById(vo.reward)

    local maxId = seabed.SeabedManager:getHisMaxDifficulty()
    for i, vo in pairs(list) do
        local propsGrid = PropsGrid:createByData({
            tid = vo.tid,
            num = vo.num,
            parent = self.mAwardScroll.content,
            scale = 0.7,
            showUseInTip = true
        })

        propsGrid:setHasRec(id <= maxId)
        table.insert(self.mShowPropsItems, propsGrid)
    end

    self:showMaxTeaserInfo()
end

function showMaxTeaserInfo(self)
    local maxDifficulty = seabed.SeabedManager:getSeabedMaxDifficulty()
    self.mTeasetInfo:SetActive(self.curClickId == maxDifficulty)
    if self.curClickId == maxDifficulty then
        if self.curTeaser == nil then
            self.curTeaser = seabed.SeabedManager:getLastTeaser()
        end
        self:updateTeaserInfo()
    end
end

function updateTeaserInfo(self)
    seabed.SeabedManager:setLastTeaser(self.curTeaser)
    self.mBtnLast:SetActive(self.curTeaser > 0)
    self.mBtnNext:SetActive(self.curTeaser < seabed.SeabedManager:getSeabedMaxTeaser())

    self.mTxtTeaser.text = _TT(111034) .. self.curTeaser
    local desList = seabed.SeabedManager:getSeabedTeaserDesByTeaser(self.curTeaser)
    self:clearTeaserDesItems()
    for i = 1, #desList do
        local item = SimpleInsItem:create(self.mTeaserDesItem, self.mTeaserContent, "mSeabedTeaserDesItem")
        item:getChildGO("mTxtTeaserDes"):GetComponent(ty.Text).text = _TT(desList[i])
        table.insert(self.mTeaserDesItems, item)
    end
    self.mImgNo:SetActive(#desList == 0)
end

function onBtnLastClickHandler(self)
    self.curTeaser = self.curTeaser - 1
    self:updateTeaserInfo()
end

function onBtnNextClickHandler(self)
    self.curTeaser = self.curTeaser + 1
    self:updateTeaserInfo()
end

function onBtnFightClickHandler(self)
    local tra = 0
    local maxDifficulty = seabed.SeabedManager:getSeabedMaxDifficulty()
    if self.curClickId == maxDifficulty then
        tra = self.curTeaser
    end

    seabed.SeabedManager:setSelectDifficulty(self.curClickId, tra)
    GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_HERO_SELECT_PANEL, {
        id = self.curClickId
    })
end

return _M
