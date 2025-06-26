--[[ 
-----------------------------------------------------
@filename       : RogueLikePreBuffPanel
@Description    : 肉鸽结算界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("rogueLike.RogueLikePreBuffPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikePreBuffPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构
function dtor(self)
end

function initData(self)

end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mCloseBtn = self:getChildGO("mCloseBtn")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(rogueLike.RogueLikePreBuffItem)

    self.mNothing = self:getChildGO("Nothing")
end
-- 激活
function active(self, args)
    super.active(self, args)

    self.isShowBuff = args.isShowBuff
    self.list = args.list
    self:showView(true)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent( self.mCloseBtn,self.onClickClose)
end

function showView(self, isInit)
    if self.isShowBuff then
        self.mTxtTitle.text =  _TT(56072)
    else
        self.mTxtTitle.text = _TT(56078)
    end

    if isInit then
        self.mScroller.DataProvider = self.list
    else
        self.mScroller:ReplaceAllDataProvider(self.list)
    end

    self.mNothing:SetActive(#self.list == 0)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
