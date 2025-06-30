--[[ 
-----------------------------------------------------
@filename       : ManualHeroView
@Description    : 图鉴-战员
@date           : 2023-3-27 17:29:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualHeroView", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("manual/ManualHeroView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("manualHero_bg.jpg", false, "manual")
    self:setTxtTitle("战员图鉴")--战员图鉴
    self:setUICode(LinkCode.ManualHero)
end
--析构  
function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtCampDes = self:getChildGO("mTxtCampDes"):GetComponent(ty.Text)
    self.mTxtCampName = self:getChildGO("mTxtCampName"):GetComponent(ty.Text)
    self.mTxtTcollect = self:getChildGO("mTxtTcollect"):GetComponent(ty.Text)
    self.mImgCamp = self:getChildGO("mImgCamp"):GetComponent(ty.AutoRefImage)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(manual.ManualHeroItem)
    self.mImgCampShadow = self:getChildGO("mImgCampShadow"):GetComponent(ty.AutoRefImage)
end
--激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self.data = args
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({})
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end

end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end
-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
end

-- 关闭所有UI
function closeAll(self)
    super.closeAll(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

function updateView(self)
    self.mImgCampShadow:SetImg(self.data.url, true)
    self.mImgCamp:SetImg(self.data.url, true)
    self.mTxtCampName.text = self.data.name
    self.mTxtCampDes.text = self.data.des
    local list = manual.ManualHeroManager:getManualHeroCampDicListByCamp(self.data.camp)
    self.mTxtTcollect.text = manual.ManualHeroManager:getUnlockListPercentByCamp(self.data.camp)
    hero.HeroManager:setAllSortList(list)
    for i, itemVo in ipairs(list) do
        itemVo.tweenId = i
    end
    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]