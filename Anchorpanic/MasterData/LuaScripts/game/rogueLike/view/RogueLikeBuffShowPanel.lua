module("rogueLike.RogueLikeBuffShowPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeBuffShowPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构
function dtor(self)
end

function initData(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
end


-- 初始化
function configUI(self)
    super.configUI(self)

    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(rogueLike.RogueLikePreBuffItem)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mBtnClose = self:getChildGO("mBtnClose")
end

-- 激活
function active(self, args)
    super.active(self, args)

    self.list = {} 
    local isAdd =  rogueLike.RogueLikeManager:getLastChangeIsAdd()
    self.mTxtDes.text = isAdd and "恭喜获得" or "遗憾失去"

    local buffid = rogueLike.RogueLikeManager:getLastChangeBuffId()
    cusLog(buffid)
    table.insert(self.list,buffid)
    self.mLyScroller.DataProvider = self.list
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

return _M
 