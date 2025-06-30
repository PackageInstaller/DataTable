--[[   
     登录适龄提示界面
]]
module('login.LoginAgeTipPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('login/LoginAgeTipPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 519)
    self:setTxtTitle("  ")
end

-- 初始化数据
function initData(self)
end

-- 初始化
function configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtContent = self:getChildGO('mTxtContent'):GetComponent(ty.Text)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self:updateView()
end

-- 非激活
function deActive(self)
    super.deActive(self)
end

function initViewText(self)
    self.mTxtTitle.text = _TT(65)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
end

function updateView(self)
    self.mTxtContent.text = _TT(64)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]