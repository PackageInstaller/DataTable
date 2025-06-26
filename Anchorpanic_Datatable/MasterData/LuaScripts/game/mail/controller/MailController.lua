--[[Brief  :邮件控制器
Author :lizhenghui
]] module('mail.MailController', Class.impl(Controller))

-- 构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
    self:__init()
end

-- 析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

function __init(self)
    self.m_mailView = nil
    self.m_mailContentView = nil
end

-- 游戏开始的回调
function gameStartCallBack(self)
    -- mail.MailManager:testData()
end

-- 模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_MAIL_PANEL, self.__onOpenMailView, self)
    GameDispatcher:addEventListener(EventName.OPEN_MAIL_CONTENT_PANEL, self.__onOpenMailContentView, self)
    GameDispatcher:addEventListener(EventName.OPEN_COLLECTION_LIST_PANEL, self.__onOpenMailCollectionView, self)

    GameDispatcher:addEventListener(EventName.MAIL_DEL_REQ, self.__onReqMailDel, self)
    GameDispatcher:addEventListener(EventName.MAIL_READ_REQ, self.__onReqMailRead, self)
    GameDispatcher:addEventListener(EventName.MAIL_AWARD_REQ, self.__onReqMailGetAward, self)

    GameDispatcher:addEventListener(EventName.REQ_MAIL_ADD_COLLECTION, self.__onReqAddMailCollection, self)
    GameDispatcher:addEventListener(EventName.REQ_OPEN_COLLECTION_LIST, self.__onReqMailCollectionList, self)
    GameDispatcher:addEventListener(EventName.REQ_DELECT_MAIL_COLLECTION, self.__onReqDelectMailCollection, self)

end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_MAIL_LIST = self.__onMsgMailList,
        SC_MAIL_ADD = self.__onMsgMailAdd,
        SC_MAIL_DEL = self.__onMsgMailDel,
        SC_MAIL_READ = self.__onMsgMailRead,
        SC_MAIL_ENCLOSURE_REC = self.__onMsgMailGetAward,
        SC_COLLECTION_MAIL_ADD = self.__onMsgAddMailCollection,
        SC_COLLECTION_MAIL_LIST = self.__onMsgMailCollectionList,
        SC_COLLECTION_MAIL_DEL = self.__onMsgMailCollectionDel
    }
end

-- 返回邮件列表
function __onMsgMailList(self, msg)
    mail.MailManager:parseMailDataMsg(msg)
end

-- 返回新增邮件
function __onMsgMailAdd(self, msg)
    mail.MailManager:addMail(msg.mail_info)
end

-- 返回删除邮件id列表
function __onMsgMailDel(self, msg)
    mail.MailManager:delMail(msg.mail_id_list)
end

-- 返回已阅读邮件id列表
function __onMsgMailRead(self, msg)
    mail.MailManager:readMail(msg.mail_id_list)
end

-- 返回已领取附件的邮件id列表
function __onMsgMailGetAward(self, msg)
    if msg.rec_result == 0 then
        mail.MailManager:parseGetAwardMail(msg.mail_id_list)
    elseif msg.rec_result == 1 then
        gs.Message.Show('背包已满，无法领取')
    elseif msg.rec_result == 2 then
        gs.Message.Show('无附件领取')
    elseif msg.rec_result == 3 then
        gs.Message.Show(_TT(1213))
    else
        gs.Message.Show('领取附件失败')
    end

end

function __onMsgAddMailCollection(self, msg)
    if msg.result == 0 then
        gs.Message.Show(_TT(110503))
        GameDispatcher:dispatchEvent(EventName.SHOW_EMIL_COLLECTION_EFF)
        -- mail.MailManager:parseAddMailCollection(msg.mail_info)
    elseif msg.result == 1 then
        gs.Message.Show(_TT(110504))
    elseif msg.result == 2 then
        gs.Message.Show(_TT(110505))
    elseif msg.result == 3 then
        gs.Message.Show(_TT(110506))
    elseif msg.result == 4 then
        gs.Message.Show(_TT(110507))
    end
end

function __onMsgMailCollectionList(self, msg)
    GameDispatcher:dispatchEvent(EventName.OPEN_COLLECTION_LIST_PANEL, msg)
end

function __onMsgMailCollectionDel(self, msg)
    -- if msg.result
    GameDispatcher:dispatchEvent(EventName.UPDATE_COLLECTION_PANEL, msg)

end

-- 请求邮件列表
function __onReqMailList(self)
    SOCKET_SEND(Protocol.CS_MAIL_LIST)
end

-- 请求删除邮件
function __onReqMailDel(self, data)
    if table.empty(data) then
        return
    end
    SOCKET_SEND(Protocol.CS_MAIL_DEL, {
        mail_id_list = data
    })
end

-- 请求设置邮件已阅读
function __onReqMailRead(self, data)
    if table.empty(data) then
        return
    end
    SOCKET_SEND(Protocol.CS_MAIL_READ, {
        mail_id_list = data
    })
end

-- 请求领取邮件的附件
function __onReqMailGetAward(self, data)
    if table.empty(data) then
        return
    end
    SOCKET_SEND(Protocol.CS_MAIL_ENCLOSURE_REC, {
        mail_id_list = data
    })
end

-- 请求添加收藏邮件
function __onReqAddMailCollection(self, id)
    SOCKET_SEND(Protocol.CS_COLLECTION_MAIL_ADD, {
        mail_id = id
    }, Protocol.SC_COLLECTION_MAIL_ADD)
end

-- 请求收藏邮件列表
function __onReqMailCollectionList(self)
    SOCKET_SEND(Protocol.CS_COLLECTION_MAIL_LIST, {}, Protocol.SC_COLLECTION_MAIL_LIST)
end

-- 请求删除收藏邮件
function __onReqDelectMailCollection(self, id)
    SOCKET_SEND(Protocol.CS_COLLECTION_MAIL_DEL, {
        mail_id_list = {id}
    }, Protocol.SC_COLLECTION_MAIL_DEL)
end

-- 打开邮件界面
function __onOpenMailView(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MAIL, true) == false then
        return
    end

    if self.m_mailView == nil then
        self.m_mailView = UI.new(mail.MailView)
        self.m_mailView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMailViewHandler, self)
    end
    self.m_mailView:open()
end
-- ui销毁
function onDestroyMailViewHandler(self)
    self.m_mailView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMailViewHandler, self)
    self.m_mailView = nil
end

-- 打开邮件内容展示界面
function __onOpenMailContentView(self, id)
    self.m_mailView:updateInfo(id)
end
-- ui销毁
function onDestroyContentViewHandler(self)
    self.m_mailContentView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyContentViewHandler, self)
    self.m_mailContentView = nil
end

function __onOpenMailCollectionView(self, data)
    if self.mMailCollectionView == nil then
        self.mMailCollectionView = UI.new(mail.MailCollectionView)
        self.mMailCollectionView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMailCollectionViewHandler, self)
    end
    self.mMailCollectionView:open(data)
end

function onDestroyMailCollectionViewHandler(self)
    self.mMailCollectionView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMailCollectionViewHandler, self)
    self.mMailCollectionView = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
