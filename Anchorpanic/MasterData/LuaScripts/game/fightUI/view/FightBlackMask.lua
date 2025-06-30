--[[ 
-----------------------------------------------------
@filename       : FightBlackMask
@Description    : 战斗中的黑幕转场
@date           : 2022-03-23 10:16:06
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('game.fighUI.view.FightBlackMask', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fight/FightBlackMask.prefab")

destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0 --是否开启适配刘海
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end

--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mImgEndBlack = self:getChildGO("mImgEndBlack")
end

--激活
function active(self)
    super.active(self)
    self:showWinBlack()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end


-- 显示胜利黑幕
function showWinBlack(self)
    if self.mTween then
        self.mTween:Kill()
    end
    self.mImgEndBlack:SetActive(true)
    self.mImgEndBlack:GetComponent(ty.CanvasGroup).alpha = 0
    self.mTween = TweenFactory:canvasGroupAlphaTo(self.mImgEndBlack:GetComponent(ty.CanvasGroup), 0, 1, 0.3)
end

-- 渐隐胜利黑幕
function hideWinBlack(self)
    if self.mTween then
        self.mTween:Kill()
    end
    self.mTween = TweenFactory:canvasGroupAlphaTo(self.mImgEndBlack:GetComponent(ty.CanvasGroup), 1, 0, 0.3, nil, function()
        self:close()
    end)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
