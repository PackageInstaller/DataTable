--[[ 
-----------------------------------------------------
@filename       : MiniConvertView
@Description    : 迷你工厂兑换页面
@date           : 2022-03-01 13:38:58
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("buildBase.BuildBasePowerTipsView", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("buildBase/BuildBasePowerTipsView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isAdapta = 0--是否开启适配刘海 0 否 1 是
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1056, 558)
end

--析构  
function dtor(self)
end

function initData(self)
 
end

-- 初始化
function configUI(self)
    self.mBtnOk = self:getChildGO("mBtnOk")
    self.mBtnCencel = self:getChildGO("mBtnCencel")
    self.mMoneyBarGroup = self:getChildTrans("mMoneyBarGroup")
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mTxtName1 = self:getChildGO("mTxtName1"):GetComponent(ty.Text)
    self.mTxtName2 = self:getChildGO("mTxtName2"):GetComponent(ty.Text)
    self.mTxtCount2 = self:getChildGO("mTxtCount2"):GetComponent(ty.Text)
    self.mTxtCount1 = self:getChildGO("mTxtCount1"):GetComponent(ty.Text)
    self.mTxtRemaind = self:getChildGO("mTxtRemaind"):GetComponent(ty.Text)
    self.mTxtTimeOne = self:getChildGO("mTxtTimeOne"):GetComponent(ty.Text)
    self.mTxtTimeAll = self:getChildGO("mTxtTimeAll"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtHasingDes = self:getChildGO("mTxtHasingDes"):GetComponent(ty.Text)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    self.mTxtTimeAllLab = self:getChildGO("mTxtTimeAllLab"):GetComponent(ty.Text)
    self.mTxtTimeOneLab = self:getChildGO("mTxtTimeOneLab"):GetComponent(ty.Text)
    self.mImgColorBg = self:getChildGO("mImgColorBg"):GetComponent(ty.AutoRefImage)
    self.mGroupItem1 = self:getChildGO("mGroupItem1"):GetComponent(ty.AutoRefImage)
    self.mGroupItem2 = self:getChildGO("mGroupItem2"):GetComponent(ty.AutoRefImage)
end

--激活
function active(self)
    super.active(self)
 
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
   

end

-- 数据更新
function onConvertInfoUpdate(self)
    self:updateView()
end

function initViewText(self)
    self.mTxtTitle.text = _TT(60538)--"产能兑换"
    self.mTxtHasingDes.text = _TT(26324)--"拥有数量："
    self.mTxtTimeOneLab.text = _TT(1208) -- "恢复1ml"
    self.mTxtTimeAllLab.text = _TT(1209) -- "恢复全部"
    self:setBtnLabel(self.mBtnOk, 1, _TT(1))
end

-- UI事件管理
function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnOk, self.onSendConvert)
    self:addUIEvent(self.mBtnCencel, self.onCancel)

end

function updateView(self)
    self.capacity , self.sum= buildBase.BuildBaseManager:getCurrentAndConsumePower()
    self.mTxtCount.text = self.capacity .. "/" .. self.sum
    self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(MoneyTid.POWER_TID), false)

    self.mGroupItem1:SetImg(MoneyUtil.getMoneyIconUrlByTid(MoneyTid.POWER_TID), false)
    self.mGroupItem2:SetImg(MoneyUtil.getMoneyIconUrlByTid(MoneyTid.POWER_TID), false)
    local propsVo = props.PropsManager:getPropsVo({ tid = MoneyTid.POWER_TID, num = 1 })
    self.mTxtName2.text = propsVo:getName()
   
end



function onCancel(self)
    self:close()
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]