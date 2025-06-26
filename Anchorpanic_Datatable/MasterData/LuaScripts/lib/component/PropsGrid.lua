--[[-----------------------------------------------------
@filename       : PropsGrid
@Description    : 新道具格子
@date           : 2022-08-09 15:51:27
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("PropsGrid", Class.impl(BaseGrid))

UIRes = UrlManager:getUIPrefabPath("commonGrid/PropsGrid.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    super.initData(self)

    -- 是否显示名字
    self.mIsShowName = nil
    -- 显示品质底图
    self.mIsShowColorBg = true
    -- 是否显示数量
    self.mIsShowCount = nil
    -- 是否显示数量2
    self.mIsShowCount2 = nil
    -- 数量文本颜色
    self.mCountTextColor = nil
    -- 是否显示首通
    self.mIsFitstPass = nil
    -- 是否显示概率
    self.mIsProbability = nil
    -- 是否显示限时
    self.mIsShowDeadline = nil
    -- 是否显示遮罩
    self.mIsGary = nil
    -- 是否显示领取状态
    self.mIsRec = nil
    -- 是否显示tips
    self.mIsShowUseInTip = nil
    -- 是否显示可领取
    self.mIsShowCanRec = false
    -- 拥有数量
    self.mHasCount = 0
    -- 需要数量
    self.mNeedCount = 0
    -- 数量字号
    self.mTxtCountRightFontSize = nil

    self.mHasNum = nil
    self.mNeedNum = nil
    -- 模组六边形底图
    self.isShowEquipBg = true
end

function configUI(self)
    -- 基础
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgColorBg = self:getChildGO("mImgColorBg"):GetComponent(ty.AutoRefImage)
    self.mImgColorLine = self:getChildGO("mImgColorLine"):GetComponent(ty.AutoRefImage)
    self.mImgIconEffect = self:getChildGO("mImgIconEffect"):GetComponent(ty.AutoRefImage)
    -- 可以使用数量
    self.mTxtUseNum = self:getChildGO("mTxtUseNum"):GetComponent(ty.Text)
    -- 右下角数量
    self.mGroupBottom = self:getChildGO("mGroupBottom")
    self.mTxtCountRight = self:getChildGO("mTxtCountRight"):GetComponent(ty.Text)
    -- 正下方数量
    self.mTxtCountDown = self:getChildGO("mTxtCountDown"):GetComponent(ty.Text)
    -- 倒计时
    self.mGroupEndTime = self:getChildGO("mGroupEndTime")
    self.mTxtEndTime = self:getChildGO("mTxtEndTime"):GetComponent(ty.Text)
    -- 状态
    self.mImgFirstState = self:getChildGO("mImgFirstState")
    self.mTxtFirstState = self:getChildGO("mTxtFirstState"):GetComponent(ty.Text)
    --概率
    self.mImgProbability = self:getChildGO("mImgProbability")
    self.mTxtProbability = self:getChildGO("mTxtProbability"):GetComponent(ty.Text)
    self.mImgDeadline = self:getChildGO("mImgDeadline")
    self.mTxtDeadline = self:getChildGO("mTxtDeadline"):GetComponent(ty.Text)
    -- 黑色遮罩
    self.mImgGray = self:getChildGO("mImgGray")
    -- 领取状态
    self.mGroupHasRec = self:getChildGO("mGroupHasRec")

    self.group = self:getChildGO("group")
    -- 模组
    self.mIsEquip = self:getChildGO("mIsEquip")
    -- 模组Icon
    self.mImgIconEquip = self:getChildGO("mImgIconEquip"):GetComponent(ty.AutoRefImage)
    -- 模组底图 槽位
    self.mImgColorBGEquip = self:getChildGO("mImgColorBGEquip"):GetComponent(ty.AutoRefImage)
    -- 手环
    self.mIsBracelet = self:getChildGO("mIsBracelet")
    -- 手环Icon
    self.mImgIconBracelet = self:getChildGO("mImgIconBracelet"):GetComponent(ty.AutoRefImage)
    -- 手环底图
    self.mImgColorBGBracelet = self:getChildGO("mImgColorBGBracelet"):GetComponent(ty.AutoRefImage)
end

function setActive(self, isActive)
    if self.group and not gs.GoUtil.IsGoNull(self.group) then
        self.group:SetActive(isActive)
    end
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
    self:recoverDefaultSet()
    if (self.mEndTimeloopSn) then
        self:removeTimerByIndex(self.mEndTimeloopSn)
        self.mEndTimeloopSn = nil
    end
end

--[[    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    super.addAllUIEvent(self)
end

-- 设置数据
function setData(self, cusData, cusParent)
    self:setParentTrans(cusParent)
    self.mPropsVo = cusData

    self.isEquip = self.mPropsVo.type == PropsType.EQUIP and self.mPropsVo.subType ~= PropsEquipSubType.SLOT_7
    self.isBracelet = self.mPropsVo.type == PropsType.EQUIP and self.mPropsVo.subType == PropsEquipSubType.SLOT_7
    self:updateData()
end

-- 更新数据
function updateData(self)
    super.updateData(self)

    self:updateName()
    self:updateColorBg()
    self:updatePropsIcon()
    self:updateGrayState()
    self:updateRecState()
    self:updateTween()
    self:updateEndTime()
    self:updateFirstPass()
    self:updateProbability()
    self:updateDeadline()
    self:updateShowNum()
    self:updateCount()
    self:updateCount2()
    self:updateCountTextColor()
end

-- 创建道具格子新方法（通过不定参数，推荐）
function createByData(self, args)
    local item = self:poolGet()
    item:initData()

    local parent = args.parent
    local tid = args.tid
    local num = args.num
    local scale = args.scale or 1
    local isTween = args.isTween
    local showUseInTip = args.showUseInTip
    local vo = props.PropsManager:getTypePropsVoByTid(tid)
    vo.count = num
    item:setData(vo, parent)
    item:setTween(isTween)
    item:setScale(scale)
    item:setIsShowUseInTip(showUseInTip)
    return item
end

-- 创建道具格子（老方法，将废弃）
function create(self, parent, cusData, cusScale, cusIsShowUseInTip)
    local vo = nil
    local item = self:poolGet()
    item:initData()
    if (cusData.__cname ~= props.PropsVo.__cname and cusData.__cname ~= props.EquipVo.__cname and cusData.__cname ~= props.OrderVo.__cname) then
        if cusData.tid and cusData.num then
            vo = props.PropsManager:getTypePropsVoByTid(cusData.tid)
            vo.count = cusData.num
        else
            vo = props.PropsManager:getTypePropsVoByTid(cusData[1])
            vo.count = cusData[2]
        end
    else
        vo = cusData
        -- PropsVo和EquipVo兼容处理
        if ((vo.__cname == props.PropsVo.__cname and vo.type ~= PropsType.PROPS) or (vo.__cname == equip.EquipVo.__cname and vo.type ~= PropsType.EQUIP)) then
            local newVo = props.PropsManager:getTypePropsVoByTid(vo.tid)
            newVo.count = vo.count
            vo = newVo
        end
    end
    item:setData(vo, parent)
    item:setScale(cusScale)
    item:setIsShowUseInTip(cusIsShowUseInTip)
    return item
end

------------------------------------------------------------------------
-- 设置自定义道具名
function setName(self, cusName)
    self.mCustomName = cusName
    self:updateName()
end

-- 设置模组类道具是否展示 六边形底板
function setEquipBgIsShow(self, isShow)
    self.isShowEquipBg = isShow
    self:updatePropsIcon()
end

-- 设置是否显示道具名
function setIsShowName(self, isShowName)
    self.mIsShowName = isShowName
    self:updateName()
end

-- 设置是否显示可领取
function setIsShowCanRec(self, isCanRec)
    self.mIsShowCanRec = isCanRec
    self:updatePropsIcon()
end

-- 设置是否显示颜色背景状态
function setShowColorBgState(self, isShow)
    self.mIsShowColorBg = isShow
    self:updateColorBg()
end

-- 设置显示使用数量
function setShowNum(self, hasCount, needCount)
    self.mHasCount = hasCount
    self.mNeedCount = needCount
    self:updateShowNum()
end

-- 设置是否显示右下角数量
function setIsShowCount(self, isShowCount)
    self.mIsShowCount = isShowCount
    self:updateCount()
end

-- 设置物品数量
-- 已有该道具的数量/需要的数量
function setCount(self, hasNum, needNum)
    self.mHasNum = hasNum
    self.mNeedNum = needNum
    self:updateCount()
end

-- 设置底部栏2数量
function setIsShowCount2(self, isShowCount)
    self:setIsShowCount(false)
    self.mIsShowCount2 = isShowCount
    self:updateCount2()
end

-- 设置物品数量文本颜色
function setCountTextColor(self, colorStr)
    self.mCountTextColor = colorStr
    self:updateCountTextColor()
end

--是否显示首通
function setIsProbability(self, isProbability, name)
    self.mIsProbability = isProbability
    self:updateProbability(name)
end

--是否显示概率
function setIsFirstPass(self, isFirstPass)
    self.mIsFitstPass = isFirstPass
    self:updateFirstPass()
end

--获取是否显示首通
function getIsFirstPass(self)
    return self.mIsFitstPass or false
end

function setIsDeadline(self, isDeadline)
    self.mIsShowDeadline = isDeadline
    self:updateDeadline()
end

function getIsDeadline(self)
    return self.mIsShowDeadline or false
end

-- 设置图标变暗遮罩
function setIconGray(self, isGray)
    self.mIsGary = isGray
    self:updateGrayState()
end

-- 设置领取状态
function setHasRec(self, isRec)
    self.mIsRec = isRec
    self:updateRecState()
end

-- 设置打开的tip是否显示使用按钮
function setIsShowUseInTip(self, isShowUseInTip)
    if isShowUseInTip == nil then
        self.mIsShowUseInTip = true
        return
    end
    self.mIsShowUseInTip = isShowUseInTip
end

-- 获取打开tips使用按钮
function getIsShowUseInTip(self)
    return self.mIsShowUseInTip
end

----------------------------------------------------------------------

-- 设置道具名
function updateName(self)
    if (self.mIsShowName == true) then
        self.mTxtName.gameObject:SetActive(true)
        if (self.mCustomName == nil) then
            self.mTxtName.text = self.mPropsVo:getName()
        else
            self.mTxtName.text = self.mCustomName
        end
    else
        self.mTxtName.gameObject:SetActive(false)
    end

end

-- 更新道具图标
function updatePropsIcon(self)
    self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(self.mPropsVo.tid), false)
    self.mImgIconEffect:SetImg(UrlManager:getPropsIconUrl(self.mPropsVo.tid), false)
    if self.isEquip then
        if self.mPropsVo.subType > 0 then
            self.mImgColorBGEquip.gameObject:SetActive(self.isShowEquipBg)
            self.mImgColorBGEquip:SetImg(UrlManager:getEquipSlot(self.mPropsVo.subType), false)
        else
            self.mImgColorBGEquip.gameObject:SetActive(false)
        end
        self.mImgIconEquip:SetImg(UrlManager:getPropsIconUrl(self.mPropsVo.tid), false)
    end

    if self.isBracelet then
        --self.mImgColorBGBracelet.color = gs.ColorUtil.GetColor(braceletBuild.getBracelectsColor(self.mPropsVo.color))
        self.mImgIconBracelet:SetImg(UrlManager:getPropsIconUrl(self.mPropsVo.tid), false)
    end
    self.mIsEquip:SetActive(self.isEquip)
    self.mIsBracelet:SetActive(self.isBracelet)
    self.mImgIcon.gameObject:SetActive(not self.isEquip and not self.isBracelet)
    self.mImgIconEffect.gameObject:SetActive(self.mIsShowCanRec)
end

-- 更新背景图
function updateColorBg(self)
    if self.mIsShowColorBg then
        if self.mPropsVo.type == PropsType.EQUIP then
            self.mImgColorBg:SetImg(UrlManager:getEquipBgUrl(self.mPropsVo.color), false)
        elseif self.mPropsVo.type == PropsType.ORDER then
            self.mImgColorBg:SetImg(UrlManager:getOrderBgUrl(), false)
        else
            self.mImgColorBg:SetImg(UrlManager:getPropsBgUrl(self.mPropsVo.color), false)
        end
        self.mImgColorLine.color = gs.ColorUtil.GetColor(ColorUtil:getPropLineColor(self.mPropsVo.color))
    end
    self.mImgColorBg.gameObject:SetActive(self.mIsShowColorBg)
    self.mImgColorLine.gameObject:SetActive(self.mIsShowColorBg)
end

-- 更新使用数量
function updateShowNum(self)
    if self.mHasCount == 0 and self.mNeedCount == 0 then
        self.mTxtUseNum.gameObject:SetActive(false)
    else
        if self.mHasCount >= self.mNeedCount then
            self.mTxtUseNum.text = _TT(45013, self.mHasCount, self.mNeedCount)
        else
            self.mTxtUseNum.text = _TT(45014, self.mHasCount, self.mNeedCount)
        end
        self.mTxtUseNum.gameObject:SetActive(true)
    end
end

--显示右下角数量
function showCount(self, count)
    self.mGroupBottom:SetActive(true)
    self.mTxtCountRight.text = self.mPropsVo.count
end

-- 更新右下角数量
function updateCount(self)
    if (self.mIsShowCount == nil or self.mIsShowCount == true) then
        if (self.mHasNum == nil and self.mNeedNum == nil) then
            local count = self.mPropsVo.count
            if (count ~= nil and count > 1) then
                self:showCount()
            else
                self.mGroupBottom:SetActive(false)
            end
        else
            if (self.mHasNum == nil) then
                self.mHasNum = bag.BagManager:getPropsCountByTid(self.mPropsVo.tid)
            end
            if (self.mNeedNum == nil) then
                if (self.mHasNum > 1) then
                    self.mGroupBottom:SetActive(true)
                    self.mTxtCountRight.text = self.mHasNum
                else
                    self.mGroupBottom:SetActive(false)
                end
            else
                self.mGroupBottom:SetActive(true)
                self.mTxtCountRight.text = self.mHasNum .. "/" .. self.mNeedNum
                if (self.mHasNum >= self.mNeedNum) then
                    self.mTxtCountRight.text = "<color=#ffffff>" .. self.mHasNum .. "</color>/" .. self.mNeedNum
                else
                    self.mTxtCountRight.text = "<color=#f94234>" .. self.mHasNum .. "</color>/" .. self.mNeedNum
                end
            end
        end
        self:updateCountTextSize()
    else
        self.mGroupBottom:SetActive(false)
    end
end

-- 更新底部栏2数量
function updateCount2(self)
    if (self.mIsShowCount2 == true) then
        self.mTxtCountDown.gameObject:SetActive(true)
        self.mTxtCountDown.text = "x" .. self.mPropsVo.count
    else
        self.mTxtCountDown.gameObject:SetActive(false)
    end
end

-- 更新剩余时间
function updateEndTime(self)
    if (not self.mPropsVo.expiredTime or self.mPropsVo.expiredTime <= 0) then
        -- 非限时道具
        self.mGroupEndTime:SetActive(false)
    else
        self.mGroupEndTime:SetActive(true)

        if (self.mEndTimeloopSn) then
            self:removeTimerByIndex(self.mEndTimeloopSn)
            self.mEndTimeloopSn = nil
        end

        self.mEndTimeloopSn = self:addTimer(1, 0, self.onEndTimer)
        self:onEndTimer()
    end
end

-- 有效期计时器
function onEndTimer(self)
    local cdTime = self.mPropsVo.expiredTime - GameManager:getClientTime()
    if (cdTime <= 0) then
        --已过期
        self.mTxtEndTime.text = "已过期"
        if (self.mEndTimeloopSn) then
            self:removeTimerByIndex(self.mEndTimeloopSn)
            self.mEndTimeloopSn = nil
        end
    else
        --未过期
        self.mTxtEndTime.text = TimeUtil.getFormatTimeBySeconds_2(cdTime)
    end
end

-- 更新首通状态
function updateFirstPass(self)
    if (self.mIsFitstPass) then
        self.mTxtFirstState.text = _TT(53611)
        self.mImgFirstState:SetActive(true)
    else
        self.mImgFirstState:SetActive(false)
    end
end

-- 更新概率状态
function updateProbability(self, name)
    if (self.mIsProbability) then
        self.mTxtProbability.text = name or _TT(53610)
        self.mImgProbability:SetActive(true)
    else
        self.mImgProbability:SetActive(false)
    end
end

-- 更新限时状态
function updateDeadline(self)
    if (self.mIsShowDeadline) then
        self.mTxtDeadline.text = _TT(80)
        self.mImgDeadline:SetActive(true)
    else
        self.mImgDeadline:SetActive(false)
    end
end

-- 更新遮罩
function updateGrayState(self)
    local isGray = self.mIsGary or false
    self.mImgGray:SetActive(isGray)
end

-- 更新领取状态
function updateRecState(self)
    local isRec = self.mIsRec or false
    self.mGroupHasRec:SetActive(isRec)
end

-- 更新数量文本颜色
function updateCountTextColor(self)
    if self.mCountTextColor then
        self.mTxtCountRight.color = gs.ColorUtil.GetColor(self.mCountTextColor)
    else
        self.mTxtCountRight.color = gs.ColorUtil.GetColor(ColorUtil.PURE_WHITE_NUM)
    end
end

function setBotScale(self, scale)
    if self.mGroupBottom then
        gs.TransQuick:Scale(self.mGroupBottom.transform, scale, scale, scale)
    end
end

-- 更新字号
function updateCountTextSize(self)
    if (self.mTxtCountRight) then
        self.mScale = self.mScale or 1
        local scale = self.mScale
        if (0.85 < scale and scale <= 1) then
            self.mTxtCountRight.fontSize = 20
        elseif (0.65 < scale and scale <= 0.85) then
            self.mTxtCountRight.fontSize = 22
        elseif (scale <= 0.65) then
            self.mTxtCountRight.fontSize = 24
        end

        if self.mTxtCountRightFontSize then
            self.mTxtCountRight.fontSize = self.mTxtCountRightFontSize
        end
    end
end

-- 设置数量字号
function setCountTextSize(self, size)
    self.mTxtCountRightFontSize = size
    self:updateCountTextSize()
end

-- 恢复
function recoverDefaultSet(self)
    if not self.isShowEquipBg then
        self.isShowEquipBg = true
        self.mImgColorBGEquip.gameObject:SetActive(true)
    end
end

function poolRecover(self)
    gs.TransQuick:Scale(self.mGroupBottom.transform, 1, 1, 1)
    if self.UITrans then
        if self.UITrans.sizeDelta.x ~= 128 or self.UITrans.sizeDelta.y ~= 128 then
            gs.TransQuick:SizeDelta(self.UITrans, 128, 128)
        end
    end
    super.poolRecover(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]