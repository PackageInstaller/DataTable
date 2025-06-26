--[[ 
-----------------------------------------------------
@filename       : FightBossShowSkip
@Description    : boss开场跳过
@date           : 2024-04-26 15:47:06
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.fight.view.FightBossShowSkip', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fight/FightBossShowSkip.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

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
    self.mBtnClick = self:getChildGO("mBtnClick")
    self.mBtnSkip = self:getChildGO("mBtnSkip")
end

--激活
function active(self)
    super.active(self)
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
    self:addUIEvent(self.mBtnClick, self.onClickShow)
    self:addUIEvent(self.mBtnSkip, self.onClickSkip)
end

function onClickShow(self)
    self.mBtnSkip:SetActive(true)
end

function onClickSkip(self)
    if self.mPlayFinish then
        self.mPlayFinish()
    end
end

function setSkipFunCall(self, playFinish)
    self.mPlayFinish = playFinish
end

return _M