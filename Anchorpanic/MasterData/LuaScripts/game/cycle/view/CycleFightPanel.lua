
module("cycle.CycleFightPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleFightPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(331))
    self:setBg("")
end

-- 析构
function dtor(self)
end

function initData(self)

end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBgHero = self:getChildGO("mBgHero"):GetComponent(ty.AutoRefImage)
    self.mTxtCurrentReason = self:getChildGO("mTxtCurrentReason"):GetComponent(ty.Text)


    self.mTxtCurrentHope = self:getChildGO("mTxtCurrentHope"):GetComponent(ty.Text)
    self.mAddGroup = self:getChildGO("mAddGroup")

    self.mTxtHopeAdd = self:getChildGO("mTxtHopeAdd"):GetComponent(ty.Text)

    self.mTxtReason = self:getChildGO("mTxtReason"):GetComponent(ty.Text)
    self.mTxtReasonValue = self:getChildGO("mTxtReasonValue"):GetComponent(ty.Text)

    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtLvValue = self:getChildGO("mTxtLvValue"):GetComponent(ty.Text)

    self.mHopeBG = self:getChildGO("mHopeBG")
    self.mTxtHopeMax = self:getChildGO("mTxtHopeMax"):GetComponent(ty.Text)
    self.mTxtHope = self:getChildGO("mTxtHope"):GetComponent(ty.Text)

    self.mImgHopeSlider = self:getChildGO("mImgHopeSlider")
    self.mTxtHopeAdd = self:getChildGO("mTxtHopeAdd"):GetComponent(ty.Text)
end

-- 激活
function active(self)
    super.active(self)

    self:showPanel()
end
-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
