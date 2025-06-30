module("buildBase.BuildBaseCreatePanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("buildBase/BuildBaseCreatePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mCostList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mImgBuildBase = self:getChildGO("mImgBuildBase"):GetComponent(ty.AutoRefImage)

    self.mZeroInfo = self:getChildGO("mZeroInfo")
    self.mTxtLvZero = self:getChildGO("mTxtLvZero"):GetComponent(ty.Text)
    self.mTxtLvCurrentZero = self:getChildGO("mTxtLvCurrentZero"):GetComponent(ty.Text)

    self.mUpdateInfo = self:getChildGO("mUpdateInfo")
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtLvCurrent = self:getChildGO("mTxtLvCurrent"):GetComponent(ty.Text)
    self.mTxtLvPre = self:getChildGO("mTxtLvPre"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mCost = self:getChildGO("mCost")
    self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)
    self.mTxtCostCurrent = self:getChildGO("mTxtCostCurrent"):GetComponent(ty.Text)
    self.mCostUpdate = self:getChildGO("mCostUpdate")
    self.mTxtCostPre = self:getChildGO("mTxtCostPre"):GetComponent(ty.Text)

    self.mComfirt = self:getChildGO("mComfirt")
    self.mTxtComfort = self:getChildGO("mTxtComfort"):GetComponent(ty.Text)
    self.mTxtComfortCurrent = self:getChildGO("mTxtComfortCurrent"):GetComponent(ty.Text)
    self.mComfortUpdate = self:getChildGO("mComfortUpdate")
    self.mTxtComfortPre = self:getChildGO("mTxtComfortPre"):GetComponent(ty.Text)

    self.mHeroNum = self:getChildGO("mHeroNum")
    self.mTxtHeroNum = self:getChildGO("mTxtHeroNum"):GetComponent(ty.Text)
    self.mTxtHeroNumCurrent = self:getChildGO("mTxtHeroNumCurrent"):GetComponent(ty.Text)
    self.mHeroNumUpdate = self:getChildGO("mHeroNumUpdate")
    self.mTxtHeroNumPre = self:getChildGO("mTxtHeroNumPre"):GetComponent(ty.Text)

    self.mValue = self:getChildGO("mValue")
    self.mTxtValue = self:getChildGO("mTxtValue"):GetComponent(ty.Text)
    self.mTxtValueCurrent = self:getChildGO("mTxtValueCurrent"):GetComponent(ty.Text)
    self.mValueUpdate = self:getChildGO("mValueUpdate")
    self.mTxtValuePre = self:getChildGO("mTxtValuePre"):GetComponent(ty.Text)

    self.mCostInfo = self:getChildGO("mCostInfo")
    self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)

    self.mTxtBuildType = self:getChildGO("mTxtBuildType"):GetComponent(ty.Text)

    self.mCostContent = self:getChildTrans("mCostContent")
    -- self.mTxtPos = self:getChildGO("mTxtPos"):GetComponent(ty.Text)

    -- self.mTxtKey = self:getChildGO("mTxtKey"):GetComponent(ty.Text)
    -- self.mTxtValue = self:getChildGO("mTxtValue"):GetComponent(ty.Text)
    -- self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)
    -- self.mTxtItemId = self:getChildGO("mTxtItemId"):GetComponent(ty.Text)
    -- self.mTxtItemNum = self:getChildGO("mTxtItemNum"):GetComponent(ty.Text)
    -- self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    -- self.mTxtStamina = self:getChildGO("mTxtStamina"):GetComponent(ty.Text)
    -- self.mTxtTopLimit = self:getChildGO("mTxtTopLimit"):GetComponent(ty.Text)
    -- self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)
    -- self.mTxtCostNum = self:getChildGO("mTxtCostNum"):GetComponent(ty.Text)
    -- self.mTxtComfort = self:getChildGO("mTxtComfort"):GetComponent(ty.Text)

    self.mLayoutGroup = self:getChildTrans("mLayoutGroup")

    self.mBtnLevelUp = self:getChildGO("mBtnLevelUp")
    self.mBtnCreate = self:getChildGO("mBtnCreate")

    self.mBtnLevelUpImg = self.mBtnLevelUp:GetComponent(ty.AutoRefImage)
    self.mBtnCreateImg = self.mBtnCreate:GetComponent(ty.AutoRefImage)

    self.mBtnCancel = self:getChildGO("mBtnCancel")

    self.mBtnMax = self:getChildGO("mBtnMax")

    self.mUnLockInfo = self:getChildGO("mUnLockInfo"):GetComponent(ty.Text)


    self.mTxtLevelUp = self:getChildGO("mTxtLevelUp"):GetComponent(ty.Text)
    self.mTxtCreateUp = self:getChildGO("mTxtCreateUp"):GetComponent(ty.Text)

    self.anim = self.UIObject:GetComponent(ty.Animator)

    self:setGuideTrans("funcTips_guide_buildBaseCreate_btnCreate", self.mBtnCreate.transform)
    self:setGuideTrans("funcTips_guide_buildBaseCreate_tips", self:getChildTrans("mGuide_tips"))
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtCreateUp.text = _TT(76190)
    self.mTxtLevelUp.text = _TT(1106)
end
-- function showViewAni(self)
--     --self.anim:SetTrigger("show")
-- end

function hideViewAni()
    self.ani:SetTrigger("exit")
end

-- 激活
function active(self, args)
    super.active(self, args)
    --self:showViewAni()
    self.openPos = args.pos
    self:showPosDataInfo()
end

-- 反激活（销毁工作）
function deActive(self)
    GameDispatcher:dispatchEvent(EventName.ONLY_UPDATE_BUILDBASE_PANEL)
    super.deActive(self)

end

function showPosDataInfo(self)
    -- self.mTxtPos.text = "pos:" .. self.openPos

    local serverLv = buildBase.BuildBaseManager:getShipLv(self.openPos)

    -- local openLevel = buildBase.BuildBaseManager:getShipMsgVo(self.openPos)== nil and 1 or buildBase.BuildBaseManager:getShipMsgVo(self.openPos).lv
    local buildType = buildBase.BuildBaseManager:getBuildBasePosDataByPos(self.openPos).buildType

    self.mImgBuildBase:SetImg(UrlManager:getBgPath("buildBase/buildbase_tips_item0" .. buildType .. ".jpg"), false)
    -- buildbase_tips_item01

    local levelsData = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(buildType)
    local curLevelData = levelsData:getLevelDataVo(serverLv)
    local preLevelData = levelsData:getLevelDataVo(serverLv + 1)

    self.mTxtBuildType.text = buildBase.BuildBaseTypeName[buildType]
    self.mTxtLv.text = _TT(76008)

    self.mTxtDes.text = _TT(levelsData.des)

    self:clearCostItems()

    self.mTxtCost.text = _TT(76023)
    self.mTxtComfort.text = _TT(76011)
    self.mTxtHeroNum.text = _TT(76012)
    if buildType == buildBase.BuildBaseType.PowerStation then
        self.mTxtValue.text = _TT(76013)
        --self.mTxtValueCurrent.color = gs.ColorUtil.GetColor("29F074ff")
        self.mTxtValuePre.color = gs.ColorUtil.GetColor("29F074ff")
    else
        self.mTxtValue.text = _TT(76014)
        -- self.mTxtValueCurrent.color = gs.ColorUtil.GetColor("ff493bff")
        -- self.mTxtValuePre.color = gs.ColorUtil.GetColor("ff493bff")
    end

    if buildType == buildBase.BuildBaseType.ControllerCenter then
        self.mCost:SetActive(false)
        self.mComfirt:SetActive(false)
        self.mHeroNum:SetActive(true)
        self.mValue:SetActive(false)
    elseif buildType == buildBase.BuildBaseType.Laboratory then
        self.mCost:SetActive(true)
        self.mComfirt:SetActive(false)
        self.mHeroNum:SetActive(true)
        self.mValue:SetActive(true)
    elseif buildType == buildBase.BuildBaseType.Smelters then
        self.mCost:SetActive(true)
        self.mComfirt:SetActive(false)
        self.mHeroNum:SetActive(true)
        self.mValue:SetActive(true)
    elseif buildType == buildBase.BuildBaseType.PowerStation then
        self.mCost:SetActive(false)
        self.mComfirt:SetActive(false)
        self.mHeroNum:SetActive(true)
        self.mValue:SetActive(true)
    elseif buildType == buildBase.BuildBaseType.Dormitory then
        self.mCost:SetActive(false)
        self.mComfirt:SetActive(true)
        self.mHeroNum:SetActive(true)
        self.mValue:SetActive(true)
    elseif buildType == buildBase.BuildBaseType.Factory then
        self.mCost:SetActive(true)
        self.mComfirt:SetActive(false)
        self.mHeroNum:SetActive(true)
        self.mValue:SetActive(true)
    elseif buildType == buildBase.BuildBaseType.DispatchRoom then
        self.mCost:SetActive(false)
        self.mComfirt:SetActive(false)
        self.mHeroNum:SetActive(true)
        self.mValue:SetActive(true)
    end

    local cur = sysParam.SysParamManager:getValue(SysParamType.COMFORTMAX)[serverLv]
    local next = sysParam.SysParamManager:getValue(SysParamType.COMFORTMAX)[serverLv + 1]

    if preLevelData and curLevelData then
        self.mZeroInfo:SetActive(false)
        self.mUpdateInfo:SetActive(true)
        self.mTxtLvCurrent.text = curLevelData:getKey()
        self.mTxtLvPre.text = preLevelData:getKey()
        self.mTxtCostCurrent.text = curLevelData:getToplimit()
        self.mTxtCostPre.text = preLevelData:getToplimit()
        self.mTxtHeroNumCurrent.text = curLevelData:getNum()
        self.mTxtHeroNumPre.text = preLevelData:getNum()
        self.mTxtValueCurrent.text = curLevelData:getValue()
        self.mTxtValuePre.text = preLevelData:getValue()


        self.mTxtComfortCurrent.text = cur
        self.mTxtComfortPre.text = next

        self.mCostUpdate:SetActive(true)
        self.mComfortUpdate:SetActive(true)
        self.mHeroNumUpdate:SetActive(true)
        self.mValueUpdate:SetActive(true)

        for _, awardVo in ipairs(preLevelData.cost) do
            local propsGrid = PropsGrid:create(self.mCostContent, {
                tid = awardVo[1],
                num = awardVo[2]
            }, 1, false)
            local hasCount = MoneyUtil.getMoneyCountByTid(awardVo[1])
            propsGrid:setShowNum(hasCount, awardVo[2])
            propsGrid:setIsShowCount(false)
            table.insert(self.mCostList, propsGrid)
        end

        self.mBtnLevelUp:SetActive(true)
        self.mBtnCreate:SetActive(false)
        self.mBtnMax:SetActive(false)


    else
        self.mTxtLvZero.text = _TT(76008)
        -- 当前等级为零
        if curLevelData == nil then
            self.mZeroInfo:SetActive(true)
            self.mUpdateInfo:SetActive(false)
            self.mTxtLvCurrentZero.text = preLevelData:getKey()
            self.mTxtCostCurrent.text = preLevelData:getToplimit()
            self.mTxtHeroNumCurrent.text = preLevelData:getNum()
            self.mTxtValueCurrent.text = preLevelData:getValue()

            self.mTxtComfortCurrent.text = next

            self.mCostUpdate:SetActive(false)
            self.mComfortUpdate:SetActive(false)
            self.mHeroNumUpdate:SetActive(false)
            self.mValueUpdate:SetActive(false)
            for _, awardVo in ipairs(preLevelData.cost) do
                local propsGrid = PropsGrid:create(self.mCostContent, {
                    tid = awardVo[1],
                    num = awardVo[2]
                }, 1, false)
                local hasCount = MoneyUtil.getMoneyCountByTid(awardVo[1])
                propsGrid:setShowNum(hasCount, awardVo[2])

                propsGrid:setIsShowCount(false)
                table.insert(self.mCostList, propsGrid)
            end
            self.mBtnLevelUp:SetActive(false)
            self.mBtnCreate:SetActive(true)
            self.mBtnMax:SetActive(false)
        else -- 满级
            self.mZeroInfo:SetActive(true)
            self.mUpdateInfo:SetActive(false)
            self.mTxtLvCurrentZero.text = curLevelData:getKey()
            self.mTxtCostCurrent.text = curLevelData:getToplimit()
            self.mTxtHeroNumCurrent.text = curLevelData:getNum()
            self.mTxtValueCurrent.text = curLevelData:getValue()

            self.mTxtComfortCurrent.text = cur
            self.mCostUpdate:SetActive(false)
            self.mComfortUpdate:SetActive(false)
            self.mHeroNumUpdate:SetActive(false)
            self.mValueUpdate:SetActive(false)

            self.mCostInfo:SetActive(false)
            self.mBtnLevelUp:SetActive(false)
            self.mBtnCreate:SetActive(false)
            self.mBtnMax:SetActive(true)
        end
    end

    local str = buildBase.BuildBaseManager:canBuildBaseLvUpdate(self.openPos, false, true)
    self.mUnLockInfo.text = str

    local canLevelUp = buildBase.BuildBaseManager:canBuildBaseLvUpdate(self.openPos, false)
    self.mBtnLevelUpImg:SetImg(canLevelUp and UrlManager:getCommon5Path("common_0163.png") or UrlManager:getCommon5Path("common_0162.png"), false)
    if not self.mBtnLevelUpRec then
        self.mBtnLevelUpRec = self.mBtnLevelUp:GetComponent(ty.RectTransform)
    end
    if not self.mBtnCreateRec then
        self.mBtnCreateRec = self.mBtnCreate:GetComponent(ty.RectTransform)
    end
    gs.TransQuick:UIPosY(self.mBtnLevelUpRec, canLevelUp and -260 or -268)
    gs.TransQuick:UIPosY(self.mBtnCreateRec, canLevelUp and -260 or -268)
    self.mBtnCreateImg:SetImg(canLevelUp and UrlManager:getCommon5Path("common_0163.png") or UrlManager:getCommon5Path("common_0162.png"), false)
    self:getChildGO("fx_ui_button_show_11"):SetActive(canLevelUp)
    self:getChildGO("fx_ui_button_show_12"):SetActive(not canLevelUp)
    self:getChildGO("fx_ui_button_show_03"):SetActive(canLevelUp)
    self:getChildGO("fx_ui_button_show_04"):SetActive(not canLevelUp)
    self.mTxtCreateUp.color = canLevelUp and gs.ColorUtil.GetColor("000000ff") or gs.ColorUtil.GetColor("ffffffff")
    self.mTxtLevelUp.color = canLevelUp and gs.ColorUtil.GetColor("000000ff") or gs.ColorUtil.GetColor("ffffffff")
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mLayoutGroup)
end

function clearCostItems(self)
    for i = 1, #self.mCostList do
        self.mCostList[i]:poolRecover()
    end
    self.mCostList = {}
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLevelUp, self.onLevelUpClickHandler)
    self:addUIEvent(self.mBtnCreate, self.onLevelUpClickHandler)
    self:addUIEvent(self.mBtnCancel, self.onCancelClickHandler)

    self:addUIEvent(self.mBtnMax, self.onLevelMaxClickHandler)
end

function onLevelMaxClickHandler(self)
    gs.Message.Show(_TT(76016))
end

-- 升级建筑
function onLevelUpClickHandler(self)

    local canLevelUp = buildBase.BuildBaseManager:canBuildBaseLvUpdate(self.openPos, true)


    if canLevelUp then
        self:sendLevelUp()
    end
end

function sendLevelUp(self)
    self:onClickClose()

    buildBase.BuildBaseManager:setLvUpPosId(self.openPos)
    GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_LEVELUP, {
        id = self.openPos
    })
end
-- 取消建筑
function onCancelClickHandler(self)
    self:onClickClose()
end

function __playOpenAction(self)
end

function __closeOpenAction(self)
    self:close()
end

function onClickClose(self)
    if self.notClickClose then return end

    GameDispatcher:dispatchEvent(EventName.CLOSE_DORMITORYINFO_PANEL)
    self.notClickClose = true
    self.anim:SetTrigger("exit")
    local time = AnimatorUtil.getAnimatorClipTime(self.anim, "BuildBaseCreatePanel_Exit")
    self:setTimeout(time, function()
        super.onClickClose(self)
    end)
end

return _M