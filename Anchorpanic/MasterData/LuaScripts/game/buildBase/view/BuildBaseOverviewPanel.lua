module("buildBase.BuildBaseOverviewPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("buildBase/BuildBaseOverviewPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- isBlur = 1
-- isScreensave = 0
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle("进驻总览")
    self:setUICode(LinkCode.Covenant)
    -- self:setBg("", false)
    self:setBg("", false)
end

function dtor(self)

end

function initData(self)
    self.nowSelectPos = 1
    self.heroStateItemList = {}
end

-- 适应全面屏，刘海缩进
function getAdaptaTrans(self)
    return self.base_childTrans["mGroupTop"]
end

-- 初始化
function configUI(self)
    super.configUI(self)
    -----left
    self.mTxtPosNum = self:getChildGO("mTxtPosNum"):GetComponent(ty.Text)
    self.mPosList = {}
    for i = 1, #buildBase.BuildBaseManager:getBuildBasePosData() do
        table.insert(self.mPosList, self:getChildGO("mPos" .. i))
    end
    self.mHeroStateGroup = self:getChildTrans("mHeroStateGroup")
    self.mHeroStateItem = self:getChildGO("mHeroStateItem")

    -----Right
    self.LyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.LyScroller:SetItemRender(buildBase.BuildBaseOverviewItem)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.UAV_TID, MoneyTid.POWER_TID, MoneyTid.TITANITE_TID })
    GameDispatcher:addEventListener(EventName.SELECT_OVERVIEW_BUILD, self.changeSelectPos, self)
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.updateView, self)
    self:updateView()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.SELECT_OVERVIEW_BUILD, self.changeSelectPos, self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.updateView, self)
    self:recoverStateItem()
    if self.LyScroller then
        self.LyScroller:CleanAllItem()
    end
end

function changeSelectPos(self, pos)
    if self.nowSelectPos == pos then
        return
    end
    self.nowSelectPos = pos
    self:updateView()
end

function updateView(self)
    local dataList = buildBase.BuildBaseManager:getAllBuildBaseDataList()
    for k, v in pairs(dataList) do
        v.select = v.id == self.nowSelectPos
    end
    if self.LyScroller.Count <= 0 then
        self.LyScroller.DataProvider = dataList
    else
        self.LyScroller:ReplaceAllDataProvider(dataList)
    end

    self:updateLeft()
end

function updateLeft(self)
    local configVo = buildBase.BuildBaseManager:getBuildBasePosDataByPos(self.nowSelectPos)
    local msgVo = buildBase.BuildBaseManager:getBuildBaseData(self.nowSelectPos)
    self.mTxtPosNum.text = self.nowSelectPos < 10 and 0 .. self.nowSelectPos or "" .. self.nowSelectPos
    for i = 1, #self.mPosList do
        self.mPosList[i]:SetActive(i == self.nowSelectPos)
    end
    self:recoverStateItem()
    for k, v in pairs(msgVo.heroList) do
        local item = SimpleInsItem:create(self.mHeroStateItem, self.mHeroStateGroup, "BuildBaseOverviewPanelherostate")
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(v)
        local name = item:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
        local stateTxt = item:getChildGO("mTxtState"):GetComponent(ty.Text)
        local stateImg = item:getChildGO("mImgState"):GetComponent(ty.AutoRefImage)
        local powerTxt = item:getChildGO("mTxtPower"):GetComponent(ty.Text)
        name.text = heroConfigVo.name

        local heroMsgVo = buildBase.BuildBaseHeroManager:getBuildHeroInfo(v)
        local heroSettleBuildVo = buildBase.BuildBaseManager:getBuildBasePosDataByPos(heroMsgVo.buildId)
        local upLimit = sysParam.SysParamManager:getValue(SysParamType.BUILD_BASE_STAMINA)
        local state = 1
        local txt = ""
        local url = ""
        local color = "ffffffff"
        if heroSettleBuildVo.buildType == buildBase.BuildBaseType.Dormitory then
            if heroMsgVo.stamina == upLimit then
                state = 1 -- 休息完毕
                color = "29f074ff"
                txt = "休息完毕"
            else
                state = 2 --休息中
                color = "ffffffff"
                txt = "休息中"
            end
            url = "buildBase/buildbase_icon04.png"
        else
            if heroMsgVo.stamina == 0 then
                if heroMsgVo.staminaTime - GameManager:getClientTime() > 0 then
                    state = 4 --工作中
                    url = "buildBase/buildbase_icon05.png"
                    txt = "工作中"
                    color = "ffffffff"
                else
                    color = "ff493bff"
                    state = 3 --疲惫
                    url = "buildBase/buildbase_icon06.png"
                    txt = _TT(1390)

                end
            else
                state = 4 --工作中
                url = "buildBase/buildbase_icon05.png"
                txt = "工作中"
                color = "ffffffff"
            end
        end

        if heroMsgVo.staminaTime - GameManager:getClientTime() <= 0 then
            if heroMsgVo.stamina > 0 then
                item:getChildGO("mTxtState"):SetActive(false)
            else
                item:getChildGO("mTxtState"):SetActive(true)
            end
        else
            item:getChildGO("mTxtState"):SetActive(true)
        end
        stateTxt.text = txt
        stateTxt.color = gs.ColorUtil.GetColor(color)
        stateImg:SetImg(UrlManager:getPackPath(url))
        stateImg.color = gs.ColorUtil.GetColor(color)
        powerTxt.text = string.format("<color=%s>" .. heroMsgVo.stamina .. "</color>/" .. upLimit, color)
        table.insert(self.heroStateItemList, item)
    end


end

function recoverStateItem(self)
    for k, v in pairs(self.heroStateItemList) do
        v:poolRecover()
    end
    self.heroStateItemList = {}
end

-- 关闭所有UI
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    self:playerClose(false)
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self:playerClose(true)
end

function playerClose(self)
end

function closeAll(self)
    super.closeAll(self)
end


return _M