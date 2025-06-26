--[[ 
-----------------------------------------------------
@filename       : NetRollView
@Description    : 网络转圈界面
@date           : 2021-04-12 10:34:08
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.common.logic_ui.view.NetRollView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("common/NetRollView.prefab")

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
    self.mRectRoll = self:getChildGO('mImgRoll'):GetComponent(ty.RectTransform)
end

--激活
function active(self)
    super.active(self)
    self:showRoll()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:hideRoll()
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

-- 设置ui节点名称（ui通过节点名拿ui节点）
function getUiNodeName(self)
    return "ALERT"
end

function showRoll(self)
    if (not self.mActionFrameSn) then
        self.mActionFrameSn = LoopManager:addFrame(1, 0, self, self.onRollActionFrameHandler)
    end
end

function onRollActionFrameHandler(self)
    if(not self.mRotation)then
        self.mRotation = 360
    else
        if(self.mRotation <= 0)then
            self.mRotation = 360 - 2
        else
            self.mRotation = self.mRotation - 4
        end
    end
    gs.TransQuick:SetRotation(self.mRectRoll, 0, 0, self.mRotation)
end

function hideRoll(self)
    if (self.mActionFrameSn) then
        LoopManager:removeFrameByIndex(self.mActionFrameSn)
        self.mActionFrameSn = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
