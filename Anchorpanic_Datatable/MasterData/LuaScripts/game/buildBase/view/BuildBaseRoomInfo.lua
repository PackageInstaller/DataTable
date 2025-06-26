--[[ 
-----------------------------------------------------
@filename       : BuildBaseRoomInfo
@Description    : 小房间UI
@date           : 2023/3
@Author         : TOoOoOoOoonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('buildBase.BuildBaseRoomInfo', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("buildBase/BuildBaseRoomInfo.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- isAddMask = 0
isBlur = 0

-- 构造函数
function ctor(self)
    super.ctor(self)

end
-- 析构  
function dtor(self)
    super.dtor(self)
end

function initData(self)
    super.initData(self)
end

-- 初始化
function configUI(self)

    ----------------------------设备信息面板-----------------------------
    self.mInfrastrucInfo = self:getChildGO("mInfrastrucInfo")
    self.mTxtInfraTitle = self:getChildGO("mTxtInfraTitle"):GetComponent(ty.Text)
    self.mTxtInfraLevel = self:getChildGO("mTxtInfraLevel"):GetComponent(ty.Text)
    self.mTxtInfraDescibe = self:getChildGO("mTxtInfraDescibe"):GetComponent(ty.Text)
    self.mContent = self:getChildTrans("mContent")
    self.mItem = self:getChildGO("mItem")
    self.mTxtItemName = self:getChildGO("mTxtItemName"):GetComponent(ty.Text)
    self.mImgItem = self:getChildGO("mImgItem")
    self.mTxtItemNum = self:getChildGO("mTxtItemNum"):GetComponent(ty.Text)
    self.mBtnCloseInfraBar = self:getChildGO("mBtnCloseInfraBar"):GetComponent(ty.Button)
    self.mAni = self.UIObject:GetComponent(ty.Animator)
    self.mImgInfraBg = self.m_childGos["mImgInfraBg"]:GetComponent(ty.AutoRefImage)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCloseInfraBar, self.onClickClose)
end

function onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_DORMITORYINFO_PANEL)
    super.onClickClose(self)
end

-- 激活
function active(self)
    super.active(self)
    self.buildId = buildBase.BuildBaseManager:getNowBuildId()
    self.mRoomPosConfig = buildBase.BuildBaseManager:getBuildBasePosDataByPos(self.buildId)
    self.mImgInfraBg:SetImg(UrlManager:getBgPath(buildBase.getBarSource(self.mRoomPosConfig.buildType)), false)
    self:updateData()
end

function deActive(self)
    super.deActive(self)
    self:recoverItems()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

--更新Info和Config数据
function updateData(self)
    self.mBuildBaseInfo = buildBase.BuildBaseManager:getBuildBaseData(self.mRoomPosConfig.id)
    self.mRoomConfig = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(self.mRoomPosConfig.buildType)
    for k, v in pairs(self.mRoomConfig.datas.build_level) do
        if (v.level == self.mBuildBaseInfo.lv) then
            self.mbuidlCofigHelper = v
            break
        end
    end
    self:onUpdateInfrasInfo()
end

-- 设备信息界面更新
function onUpdateInfrasInfo(self)
    self:recoverItems()
    self.mTxtInfraTitle.text = _TT(self.mRoomPosConfig.name)
    self.mTxtInfraLevel.text = "<size=14>Lv.</size> " .. self.mBuildBaseInfo.lv
    self.mTxtInfraDescibe.text = _TT(self.mRoomConfig.datas.des)
    if (self.mbuidlCofigHelper.toplimit > 0) then
        local item = SimpleInsItem:create(self.mItem, self.mContent, "BuildBaseRoomInfo_self.mItem")
        local txt = item:getChildGO("mTxtItemName"):GetComponent(ty.Text)
        txt.text = "最大容量"
        local txtNum = item:getChildGO("mTxtItemNum"):GetComponent(ty.Text)
        if self.mbuidlCofigHelper.BuildBaseType ~= buildBase.BuildBaseType.Factory then
            txtNum.text = self.mBuildBaseInfo.maxNum
        else
            txtNum.text = self.mbuidlCofigHelper.toplimit
        end
        local img = item:getChildGO("mImgItem"):GetComponent(ty.AutoRefImage)
        img:SetImg(buildBase.InconType.MaxCapacity, true)
        table.insert(self.mMenuItem, item)
    end
    if (self.mbuidlCofigHelper.need_power >= 0) then
        local item = SimpleInsItem:create(self.mItem, self.mContent, "BuildBaseRoomInfo_self.mItem")
        local txt = item:getChildGO("mTxtItemName"):GetComponent(ty.Text)
        local txtNum = item:getChildGO("mTxtItemNum"):GetComponent(ty.Text)
        local img = item:getChildGO("mImgItem"):GetComponent(ty.AutoRefImage)
        img:SetImg(buildBase.InconType.ProvidePower, true)
        if (self.mRoomPosConfig.buildType == buildBase.BuildBaseType.PowerStation) then
            txt.text = "提供电力"
            txtNum.text = HtmlUtil:color(self.mbuidlCofigHelper.need_power, "18ec68")
        else
            txt.text = "占用电力"
            txtNum.text = HtmlUtil:color(self.mbuidlCofigHelper.need_power, "fa3a2b")
        end
        table.insert(self.mMenuItem, item)
    end
    local mLengthHelper = #self.mBuildBaseInfo.heroList
    local item = SimpleInsItem:create(self.mItem, self.mContent, "BuildBaseRoomInfo_self.mItem")
    local txt = item:getChildGO("mTxtItemName"):GetComponent(ty.Text)
    txt.text = _TT(76015)
    local txtNum = item:getChildGO("mTxtItemNum"):GetComponent(ty.Text)
    txtNum.text = mLengthHelper
    local img = item:getChildGO("mImgItem"):GetComponent(ty.AutoRefImage)
    img:SetImg(buildBase.InconType.Population, true)
    table.insert(self.mMenuItem, item)
end

--动效
function __closeOpenAction(self)
    if (self.panelType ~= 1 and not self.isCloseing) then
        self.isCloseing = true
        local tweenTime = AnimatorUtil.getAnimatorClipTime(self.mAni, "BuildBaseRoomInfo_Enter")
        gs.UIBlurManager.SetSuperBlur(false, self.UIRootNode, self:getUiNodeName(), self.blurTweenTime)

        if self.mBlurMask then
            gs.GameObject.Destroy(self.mBlurMask)
            self.mBlurMask = nil
        end
        if self.UIObject then
            self.mAni:SetTrigger("exit")
            local _viewTweenFinishCall = function()
                if self.isPop == 1 then
                    self:close()
                end
            end
            self:addTimer(tweenTime, 1, _viewTweenFinishCall)
        end
    end
end


function recoverItems(self)
    if self.mMenuItem then
        for _, item in pairs(self.mMenuItem) do
            item:poolRecover()
        end
    end
    self.mMenuItem = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]