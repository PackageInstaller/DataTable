-- 居中跑马灯公告
module('notice.NoticeView', Class.impl("lib.component.BaseContainer"))
UIRes = UrlManager:getUIPrefabPath('notice/Notice.prefab')

--构造函数
function ctor(self)
	super.ctor(self)
end

-- 初始化数据
function initData(self)
	self.m_width = 0
	self.m_noticeVo = nil
	self.m_isTweening = false
end

-- 设置父容器
function getParentTrans(self)
	return GameView.msg
end

function configUI(self)
	local maskRect = self:getChildGO('Mask'):GetComponent(ty.RectTransform)
	self.m_width = maskRect.sizeDelta.x
	
	self.textTrans = self:getChildTrans('RichText')
	self.rectComponent = self:getChildGO('RichText'):GetComponent(ty.RectTransform)
	self.textComponent = self:getChildGO('RichText'):GetComponent(ty.RichText)
end

function start(self, cusNoticeVo)
	self.m_isTweening = true
	self.m_noticeVo = cusNoticeVo
	
	self.textComponent.text = self.m_noticeVo.msg
	RichTextUtil:registerCallBack(self.textComponent)
	-- if(self.rectComponent.sizeDelta.x == 0) then
	-- 	LoopManager:addFrame(2, 1, self, self.__start)
	-- else
	-- 	self:__start()
	-- end
	self:__start()
end

function __start(self)
	-- 立即验证获取大小
	local richTextW = self.textComponent:GetRectSize().x
	-- local richTextW = self.rectComponent.sizeDelta.x
	local startX = self.m_width / 2 + richTextW / 2
	local endX = - startX
	gs.TransQuick:LPos(self.rectComponent, startX, 0, 0)
	local function callBack()
		self.__finish(self)
	end
	TweenFactory:move2LPosX(self.textTrans, endX, 5, gs.DT.Ease.Linear, callBack)
end

function __finish(self)
	self.m_isTweening = false
	self.m_noticeVo = nil
	GameDispatcher:dispatchEvent(EventName.NOTICE_TWEEN_FINISH, {})
end

function isTweening(self)
	return self.m_isTweening
end

function active(self)
end

function deActive(self)
	self.textComponent:Clear()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
