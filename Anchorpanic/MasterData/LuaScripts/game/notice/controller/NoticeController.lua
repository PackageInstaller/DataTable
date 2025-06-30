module("notice.NoticeController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
	GameDispatcher:addEventListener(EventName.TEST_NOTICE, self.onTestHandler, self)
	GameDispatcher:addEventListener(EventName.NOTICE_TWEEN_FINISH, self.onTweenFinishHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
	return {
		--- *s2c* 系统公告 10012
		SC_SYSTEM_HEARSAY = self.__onResNoticeMsgHandler,
		--- *s2c* 系统飘字提示 10008
		SC_SYS_HINT = self.__onResSysMsgHandler,
	}
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 消息码
function __onResSysMsgHandler(self, msg)
	-- /** 飘字位置：0-左下角，1-跟随鼠标 */
	local place = msg.place
	-- /** 语言包id */
	local langId = msg.lang_id
	-- /** 飘字颜色：0-成功绿色，1-其他 */
	local color = msg.color
	-- /** 参数列表 */
	local paramList = msg.params

	local str = _TT(langId)
	if(#paramList > 0) then
		str = string.substituteArr(str, paramList)
	end
	local _color
	if(color == 0) then
		str = HtmlUtil:color(str, ColorUtil.PURE_WHITE_NUM)
	elseif(color == 1) then
		str = HtmlUtil:color(str, ColorUtil.PURE_WHITE_NUM)
	end
    gs.Message.Show(str)
end

-- 测试
function onTestHandler(self)
	-- if(self.i == nil) then
	-- 	self.i = 0
	-- end
	-- self.i = self.i + 1
	
	-- local serverSplitSign = "###"
	-- local paramList = {}
	-- local paramVo
	-- paramVo = notice.NoticeParamVo.new()
	-- paramVo.type = notice.LinkType.MSG_TYPE_VIP
	-- paramVo.value = self.i
	-- paramVo.propsVo = {}
	-- table.insert(paramList, paramVo)
	
	-- paramVo = notice.NoticeParamVo.new()
	-- paramVo.type = notice.LinkType.MSG_TYPE_GUILD
	-- paramVo.value = "params1" .. serverSplitSign .. "params2"
	-- paramVo.propsVo = {}
	-- table.insert(paramList, paramVo)
	
	-- local msg = notice.NoticeVo.new()
	-- msg.channel = 1
	-- -- msg.msg = "恭喜" .. RichTextUtil:customImage("icon_vip.png", 60, 30, "VipLink") .. "玩家获得道具" .. RichTextUtil:href("【前往查看】", ColorUtil.BLUE_NUM, "LookLink")
	-- msg.msg = "荣耀王者联盟充1毛钱成为联盟"
	-- msg.location = 3
	-- msg.isCross = 1
	-- msg.minLv = 0
	-- msg.maxLv = 100
	-- msg.paramList = paramList
	-- msg.targetId = 0
	-- msg.endTime = 0
	-- msg.priority_1 = self.i
	-- msg.priority_2 = 0
	
	-- self:__onResNoticeMsgHandler(msg)
end

function __onResNoticeMsgHandler(self, msg)
	notice.NoticeManager:parseNoticeMsg(msg)
	self:checkNoticeShow(msg)
end

function onTweenFinishHandler(self)
	self:checkNoticeShow(msg)
end

function checkNoticeShow(self)
	if(self.m_noticeView and self.m_noticeView:isTweening()) then
		return
	end
	if(#notice.NoticeManager.noticeList > 0) then
		local vo = notice.NoticeManager:getFirstNotice()
		self:showNotice(vo)
	else
		self:removeNotice()
	end
end

function showNotice(self, cusNoticeVo)
	if self.m_noticeView == nil then
		self.m_noticeView = notice.NoticeView.new()
	end
	self.m_noticeView:start(cusNoticeVo)
end

function removeNotice(self)
	if(self.m_noticeView ~= nil) then
		self.m_noticeView:destroy()
		self.m_noticeView = nil
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
