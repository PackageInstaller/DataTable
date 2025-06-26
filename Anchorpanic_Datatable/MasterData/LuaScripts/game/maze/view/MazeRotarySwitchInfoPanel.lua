--[[ 
-----------------------------------------------------
@filename       : MazeRotarySwitchInfoPanel
@Description    : 迷宫·旋转阀门信息面板
@date           : 2021年5月11日 15:59:35
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('maze.MazeRotarySwitchInfoPanel', Class.impl(maze.MazeEventInfoPanel))

UIRes = UrlManager:getUIPrefabPath("maze/MazeEventInfoPanel.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

--初始化UI
function configUI(self)
    super.configUI(self)
end

function initViewText(self)
    super.initViewText(self)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
end

--激活
function active(self, args)
    super.active(self, args)
end

--非激活
function deActive(self)
    super.deActive(self)
end

function __updateView(self)
    super.__updateView(self)
    local eventConfigVo = maze.MazeSceneManager:getEventConfigVo(self.mEventVo:getEventId())
    self.mBtnUnable:SetActive(true)
    self.mBtnAble:SetActive(true)
    self:setTxtTitle(eventConfigVo:getEventTitle())
    self.mTxtDes.text = eventConfigVo:getEventDes()
    self:setBtnLabel(self.mBtnAble, -1, eventConfigVo:getTextAbleBtn())
    self:setBtnLabel(self.mBtnUnable, -1, eventConfigVo:getTextUnAbleBtn())
    self.mBtnCancel:SetActive(eventConfigVo:getIsShowCancel())
end

function __onClickUnableHandler(self)
    if(self.mCallFun)then
        -- 逆时针旋转
        self.mCallFun({0})
    end
    self:close()
end

function __onClickAbleHandler(self)
    if(self.mCallFun)then
        -- 顺时针旋转
        self.mCallFun({1})
    end
    self:close()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
