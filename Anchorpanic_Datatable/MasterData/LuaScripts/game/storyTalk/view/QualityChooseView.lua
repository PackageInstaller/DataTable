--[[ 
-----------------------------------------------------
@filename       : QualityChooseView
@Description    : 画质设置界面
@date           : 2021-12-20 16:41:27
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.storyTalk.view.QualityChooseView', Class.impl(View))
--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("storyTalk/QualityChooseView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowMoneyBar = 0 
isScreensave = 1 --是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1144, 571)

end
--析构  
function dtor(self)
end

function initData(self)
    self.mItemDic = nil
    self.mSelectQuality = nil
    self.mTypeDic = {}
    self.mTypeDic[systemSetting.QualitySetting_Grade.Low] = _TT(1189)      --流畅
    self.mTypeDic[systemSetting.QualitySetting_Grade.Middle] = _TT(1190)   --普通
    self.mTypeDic[systemSetting.QualitySetting_Grade.High] = _TT(1191)     --精细
end

-- 初始化
function configUI(self)
    self.mTxtRecommend = self:getChildGO("mTxtRecommend"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mBtnConfirm = self:getChildGO("mBtnConfirm")
    self.mGroup = self:getChildTrans("mGroup")
end

--激活
function active(self)
    super.active(self)
    self.base_childGos["mGroupTop"]:SetActive(false)
    self:removeOnClick(self.mask)
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItem()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnConfirm, 46503, "确定")
    self.mTxtTitle.text = _TT(1187) --"画质选择"
    self.mTxtTips.text = _TT(1188) --"在游戏主界面左上角，点击头像也可以进行画质设置"
    self.mTxtRecommend.text = "推荐"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnConfirm, self.onClickConfirmHandler)
end

function onClickConfirmHandler(self)
    -- UIFactory:alertMessge(string.format("是否确定选择画质：%s", self.mTypeDic[self.mSelectQuality]), true, function()
    --曹师傅の要求 画质选择的确定弹窗先去掉
        --UIFactory:alertMessge(_TT(1192, self.mTypeDic[self.mSelectQuality]), true, function()
        systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.pictureQuality, self.mSelectQuality)
        systemSetting.SystemSettingManager:applySetting(systemSetting.SystemSettingDefine.pictureQuality)
        GameDispatcher:dispatchEvent(EventName.CLOSE_QUALITY_CHOOSE_VIEW)
        
        local value = systemSetting.getOneQualitySettingDrop(systemSetting.SystemSettingDefine.pictureQuality)
        if(value and value.label and value.label[self.mSelectQuality])then
            local url, parasmDic = web.getReportGenericArgsUrl(web.GENERIC_ARGS_REPORT_TYPE.QUALITY_SELECTION, value.label[self.mSelectQuality])
            WebInterfaceUtil:postAsyncLoop(url, parasmDic, nil, nil, self, nil)
        end
    --end, _TT(1), nil, true)
end

-- 创建内容
function updateView(self)
    self:recoverItem()
    local deviceName, cpuName, gpuName = sdk.SdkManager:getDeviceData()
    self.mSelectQuality = systemSetting.SystemSettingManager:getDeviceQualityType(deviceName, cpuName, gpuName)
    for quality = systemSetting.QualitySetting_Grade.Low, systemSetting.QualitySetting_Grade.High do
        local item = SimpleInsItem:create(self:getChildGO("GroupQualityItem"), self.mGroup, "QualityChooseViewQualityItem")
        item:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(string.format("storytalk/QualityChooseView_%s.png", (quality - 1))), true)
        item:getChildGO("mImgRecommend"):SetActive(self.mSelectQuality == quality)
        item:getChildGO("mImgSelect"):SetActive(self.mSelectQuality == quality)
        item:setText("mTxtQuality", nil, string.format("-%s-", self.mTypeDic[quality]))
        item:addUIEvent("mGroupClick", function()
            self.mSelectQuality = quality
            for _quality, item in pairs(self.mItemDic) do
                item:getChildGO("mImgSelect"):SetActive(self.mSelectQuality == _quality)
            end
        end)
        self.mItemDic[quality] = item
    end
end

-- 检查默认适配画质
function checkDefaultQuality(self)
    local isInitDefaultQuality = StorageUtil:getString0('isInitDefaultQuality')
    if(isInitDefaultQuality == "")then
        StorageUtil:saveString0('isInitDefaultQuality', "1")
        local defaultQuality = systemSetting.QualitySetting_Grade.High
        local deviceName, cpuName, gpuName = sdk.SdkManager:getDeviceData()
        if(deviceName and cpuName and gpuName)then
            defaultQuality = systemSetting.QualitySetting_Grade.High
        end
        systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.pictureQuality, defaultQuality)
        systemSetting.SystemSettingManager:applySetting(systemSetting.SystemSettingDefine.pictureQuality)
    end
end

-- 回收项
function recoverItem(self)
    if self.mItemDic then
        for quality, item in pairs(self.mItemDic) do
            item:poolRecover()
        end
    end
    self.mItemDic = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
