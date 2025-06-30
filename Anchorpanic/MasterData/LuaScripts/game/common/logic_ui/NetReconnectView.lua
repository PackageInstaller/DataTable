--[[ 
-----------------------------------------------------
@filename       : NetReconnectView
@Description    : 网络重连提示
@date           : 2021-04-12 10:34:08
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.common.logic_ui.view.NetReconnectView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("common/NetReconnectView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0
isBlur = 0 
isAdapta = 0

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mImgTip = self:getChildGO("mImgTip"):GetComponent(ty.CanvasGroup)
    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
    self:showTween1()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    if self.tween1 then
        self.tween1:Kill()
    end
    if self.tween2 then
        self.tween2:Kill()
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.mImgTip, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.mImgTip,self.onClick)
    self.mTxtTip.text = _TT(29) --"正在尝试连接指挥中心..."
end

-- 设置ui节点名称（ui通过节点名拿ui节点）
function getUiNodeName(self)
    return "ALERT"
end

function showTween1(self)
    self.tween1 = TweenFactory:canvasGroupAlphaTo(self.mImgTip, 1, 0.2, 0.4, nil, function()
        self:showTween2()
    end)
end

function showTween2(self)
    self.tween2 = TweenFactory:canvasGroupAlphaTo(self.mImgTip, 0.2, 1, 0.4, nil, function()
        self:showTween1()
    end)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
