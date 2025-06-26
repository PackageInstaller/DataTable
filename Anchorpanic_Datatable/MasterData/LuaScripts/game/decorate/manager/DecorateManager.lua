module("decorate.DecorateManager", Class.impl(Manager))

-- 更新装饰列表
UPDATE_DECORATE_LIST = "UPDATE_DECORATE_LIST"
-- 新获得红点更新
UPDATE_NEW_BUBBLE = "UPDATE_NEW_BUBBLE"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.mPlayerHeadDic = nil
    self.mPlayerHeadList = nil
    self.mPlayerHeadFrameDic = nil
    self.mPlayerHeadFrameList = nil
    self.mPlayerTitleDic = nil
    self.mPlayerTitleList = nil

    self.mDecorateDic = nil
    self.newDic = nil
    self.mSelectIndex = 0
    self.mFrameSelectIndex = 0
    self.mUsingId = 0
    self.mFrameUsingId = 0
    self.mBackGroundList = {}
    self.mPlayerHeadList = nil
    self.mPlayerHeadFrameList = {}
end

--------------------------------------------------------------------配置解析-------------------------------------------------------------------------
-- 解析背景列表返回信息
function parseBackGroundKistMsg(self, msg)
    for i, vo in ipairs(msg.background_list) do
        if self:getBackGroundIsHasing(vo) == false then
            table.insert(self.mBackGroundList, vo)
        end
    end
    GameDispatcher:dispatchEvent(EventName.FRIEND_SWITCH_BG)
end

function updateBgReadRed(self)
    for _, bgVo in ipairs(role.RoleManager:getBackGroundList()) do
        if read.ReadManager:isModuleRead(ReadConst.NEW_ROLEBG, bgVo:getUnLockType()) then
            return true
        end
    end
    return false
end

-- 解析玩家头像配置表
function prasePlayerHeadConfig(self)
    self.mPlayerHeadList = {}
    self.mPlayerHeadDic = {}
    local baseData = RefMgr:getData("avatar_data")
    for id, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(decorate.AvatarDataRo)
        ro:parseData(id, data)
        self.mPlayerHeadDic[id] = ro
        table.insert(self.mPlayerHeadList, ro)
    end
    table.sort(self.mPlayerHeadList, self.sortList)
end

-- 解析玩家头像框配置表
function prasePlayerHeadFrameConfig(self)
    self.mPlayerHeadFrameDic = {}
    local baseData = RefMgr:getData("avatar_frame_data")
    for id, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(decorate.AvatarFrameDataRo)
        ro:parseData(id, data)
        self.mPlayerHeadFrameDic[id] = ro
        table.insert(self.mPlayerHeadFrameList, ro)
    end
    table.sort(self.mPlayerHeadFrameList, self.sortList)
end

-- 解析玩家称号配置表
function prasePlayerTitleConfig(self)
    self.mPlayerTitleDic = {}
    self.mPlayerTitleList = {}
    local baseData = RefMgr:getData("designation_data")
    for id, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(decorate.TitleDataRo)
        ro:parseData(id, data)
        self.mPlayerTitleDic[id] = ro
        table.insert(self.mPlayerTitleList, ro)
    end
    table.sort(self.mPlayerTitleList, self.sortList)
end

-- 排序
function __sort(vo_1, vo_2)
    if (vo_1 and vo_2) then
        if (vo_1:getSort() < vo_2:getSort()) then
            return true
        end
        if (vo_1:getSort() > vo_2:getSort()) then
            return false
        end
    end
    return false
end

-- 解析玩家称号配置表
function getChatBubbleConfig(self, bubble_id)
    bubble_id = bubble_id == 0 and 4001 or bubble_id -- 0是老消息，默认转换为基础的
    if not self.mChatBubbleConfigDic then
        self.mChatBubbleConfigDic = {}
        local baseData = RefMgr:getData("dialog_box_data")
        for id, data in pairs(baseData) do
            local ro = LuaPoolMgr:poolGet(decorate.ChatBubbleVo)
            ro:parseData(id, data)
            self.mChatBubbleConfigDic[id] = ro
        end
    end

    return self.mChatBubbleConfigDic[bubble_id]
end

--------------------------------------------------------------------服务器解析-------------------------------------------------------------------------
-- 解析服务器的头像列表
function praseDecorateListMsg(self, moduleType, msgList)
    if (not self.mDecorateDic) then
        self.mDecorateDic = {}
    end
    if (not self.newDic) then
        self.newDic = {}
    end
    local newIdDic = self.newDic[moduleType]
    if (not newIdDic) then
        self.newDic[moduleType] = {}
        newIdDic = self.newDic[moduleType]
    end

    local idDic = self.mDecorateDic[moduleType]
    if (idDic) then
        for _, msgVo in pairs(msgList) do
            local id = msgVo.avatar_id or msgVo.avatar_frame_id or msgVo.designation_id
            -- 是否新增
            if (not idDic[id]) then
                newIdDic[id] = true
            end
        end
    else
        self.mDecorateDic[moduleType] = {}
        idDic = self.mDecorateDic[moduleType]
    end

    for _, msgVo in pairs(msgList) do
        local vo = nil
        if (moduleType == decorate.ModuleType.HEAD) then
            vo = LuaPoolMgr:poolGet(decorate.DecorateHeadVo)
        elseif (moduleType == decorate.ModuleType.HEAD_FRAME) then
            vo = LuaPoolMgr:poolGet(decorate.DecorateHeadFrameVo)
        elseif (moduleType == decorate.ModuleType.TITLE) then
            vo = LuaPoolMgr:poolGet(decorate.DecorateTitleVo)
        end
        vo:praseMsgData(msgVo)
        idDic[vo.id] = vo
    end
    self:dispatchEvent(self.UPDATE_DECORATE_LIST, { moduleType = moduleType })
    self:updateBubble()
end

-- 删除外观
function praseDecorateDelMsg(self, moduleType, deleteId)
    local idDic = self.mDecorateDic[moduleType]
    if (idDic) then
        local vo = idDic[deleteId]
        LuaPoolMgr:poolRecover(vo)
        idDic[deleteId] = nil

        if (table.empty(idDic)) then
            self.mDecorateDic[moduleType] = nil
        end

        self:dispatchEvent(self.UPDATE_DECORATE_LIST, { moduleType = moduleType })
        self:updateBubble()
    end
end

-- 解析服务器聊天气泡
function praseChatBubbleMsg(self, msg)
    self.mChatBubbleDic = {}
    for _, chatInfo in pairs(msg.dialog_box_list) do
        self.mChatBubbleDic[chatInfo.dialog_box_id] = { expired_time = chatInfo.expired_time, is_like = chatInfo.is_like }
    end

    GameDispatcher:dispatchEvent(EventName.REFRESH_CHATBUBBLE_REDSTATE)
end

function getChatBubbleRedState(self)
    if not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CHAT, false) then
        return false
    end

    if self.mChatBubbleDic then
        for bubbleTid, bubbleInfo in pairs(self.mChatBubbleDic) do
            local bubbleConfig = decorate.DecorateManager:getChatBubbleConfig(bubbleTid)
            if bubbleConfig and bubbleConfig.unlock_type ~= 0 then
                if read.ReadManager:isModuleRead(ReadConst.CHAT_BUBBLE, bubbleTid) then
                    return true
                end
            end
        end
    end

    return false
end

function getChatBubbleData(self, chatBubbleTid)
    return self.mChatBubbleDic[chatBubbleTid]
end

function getChatBubbleDic(self)
    return self.mChatBubbleDic or {}
end

-- 根据指定moduleType获取字典
function getDicByModuleType(self, moduleType)
    if (not self.mDecorateDic) then
        return {}
    else
        return self.mDecorateDic[moduleType] or {}
    end
end

-- 根据指定moduleType和id获取vo
function getDecorateVo(self, moduleType, id)
    local dic = self:getDicByModuleType(moduleType)
    return dic[id]
end
--是否已拥有
function getBackGroundIsHasing(self, id)
    for i, vo in ipairs(self.mBackGroundList) do
        if id == vo then
            return true
        end
    end
    return false
end
--图像解锁
function getBackGroundIsActive(self, id)
    for i, vo in ipairs(self.mBackGroundList) do
        if id == vo then
            return true
        end
    end
    return false
end
-- 判断指定moduleType的id是否为喜欢
function getIsLike(self, moduleType, id)
    local decorateVo = self:getDecorateVo(moduleType, id)
    return decorateVo and decorateVo.isLike
end

-- 判断指定moduleType的id是否已激活
function getIsActive(self, moduleType, id)
    local decorateVo = self:getDecorateVo(moduleType, id)
    return decorateVo ~= nil
end

---- 判断指定moduleType的id是否新获得
--function getIsNew(self, moduleType, id)
--    if (self.newDic and self.newDic[moduleType] and self.newDic[moduleType][id]) then
--        return true
--    end
--    return false
--end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 获取头像配置列表
function getPlayerHeadConfigList(self)
    if (#self.mPlayerHeadList <= 0) then
        self:prasePlayerHeadConfig()
    end
    return self.mPlayerHeadList
end

-- 根据头像id获取头像配置
function getPlayerHeadConfigVo(self, id)
    if (not self.mPlayerHeadDic) then
        self:prasePlayerHeadConfig()
    end
    return self.mPlayerHeadDic[id]
end

-- 获取默认解锁的头像配置
function getDeaultPlayerHeadConfig(self)
    if (not self.mPlayerHeadList) then
        self:prasePlayerHeadConfig()
    end
    for id, configVo in pairs(self.mPlayerHeadDic) do
        if (configVo:getUnlockType() == decorate.HeadUnlockType.DEFAULT_UNLICK) then
            return configVo
        end
    end
end

-- 获取头像框配置列表
function getPlayerHeadFrameConfigList(self)
    if (#self.mPlayerHeadFrameList <= 0) then
        self:prasePlayerHeadFrameConfig()
    end
    return self.mPlayerHeadFrameList
end

-- 根据头像框id获取头像框配置
function getPlayerHeadFrameConfigVo(self, id)
    if (not self.mPlayerHeadFrameDic) then
        self:prasePlayerHeadFrameConfig()
    end
    return self.mPlayerHeadFrameDic[id]
end

-- 获取默认解锁的头像框配置
function getDeaultPlayerHeadFrameConfig(self)
    if (not self.mPlayerHeadFrameList) then
        self:prasePlayerHeadFrameConfig()
    end
    for id, configVo in pairs(self.mPlayerHeadFrameDic) do
        if (configVo:getUnlockType() == decorate.HeadFrameUnlockType.DEFAULT_UNLICK) then
            return configVo
        end
    end
end

-- 获取头像框类型及资源名
function getHeadFrameResUrl(self, frameId)
    local vo = self:getPlayerHeadFrameConfigVo(frameId)
    if not vo then
        return 0, UrlManager:getDynamicHeadFrameUrl(1)
    end
    if vo:getDynamics() == 1 then
        return vo:getDynamics(), UrlManager:getDynamicHeadFrameUrl(vo:getRes())
    end
    return vo:getDynamics(), UrlManager:getPlayerHeadFrameUrl(vo:getRes())
end

-- 获取称号配置列表
function getPlayerTitleConfigList(self)
    if (not self.mPlayerTitleList) then
        self:prasePlayerTitleConfig()
    end
    return self.mPlayerTitleList
end

-- 根据称号获取称号配置
function getPlayerTitleConfigVo(self, id)
    if (not self.mPlayerTitleDic) then
        self:prasePlayerTitleConfig()
    end
    return self.mPlayerTitleDic[id]
end

-- 获取默认解锁的称号配置
function getDeaultTitleConfig(self)
    if (not self.mPlayerTitleList) then
        self:prasePlayerTitleConfig()
    end
    for id, configVo in pairs(self.mPlayerTitleDic) do
        if (configVo:getUnlockType() == decorate.TitleUnlockType.DEFAULT_UNLICK) then
            return configVo
        end
    end
end

-- 列表排序
function sortList(configVo_1, configVo_2)
    local mgr = decorate.DecorateManager
    local id_1 = configVo_1:getRefID()
    local id_2 = configVo_2:getRefID()

    local isNew_1 = mgr:getIsNew(id_1)
    local isNew_2 = mgr:getIsNew(id_2)
    -- 由新到旧
    if (isNew_1 and not isNew_2) then
        return true
    end
    if (not isNew_1 and isNew_2) then
        return false
    end

    -- 由已解锁到未解锁
    if (mgr:getDecorateVo(decorate.ModuleType.HEAD, id_1) and not mgr:getDecorateVo(decorate.ModuleType.HEAD, id_2)) then
        return true
    end
    if (not mgr:getDecorateVo(decorate.ModuleType.HEAD, id_1) and mgr:getDecorateVo(decorate.ModuleType.HEAD, id_2)) then
        return false
    end
    -- id从小到大
    if (id_1 > id_2) then
        return false
    end
    if (id_1 < id_2) then
        return true
    end
    return false
end

function updateBubble(self)
    local isBubble = self:isBubble()
    mainui.MainUIManager:setHudRed(funcopen.FuncOpenConst.FUNC_ID_HOME_HEAD, isBubble)
    self:dispatchEvent(self.UPDATE_NEW_BUBBLE, isBubble)
end

function isBubble(self)
    local isBubble = false
    if (self.mDecorateDic and not isBubble) then
        for moduleType, idDic in pairs(self.mDecorateDic) do
            isBubble = self:isModuleTypeBubble(moduleType)
            if (isBubble) then
                break
            end
        end
    end
    return isBubble
end

function isModuleTypeBubble(self, moduleType)
    local isBubble = false
    local isOpen = false
    if (moduleType == decorate.ModuleType.HEAD) then
        isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_HEAD, false)
    elseif (moduleType == decorate.ModuleType.HEAD_FRAME) then
        isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_HEAD_FRAME, false)
    elseif (moduleType == decorate.ModuleType.TITLE) then
        isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_TITLE, false)
    elseif (moduleType == decorate.ModuleType.BACKGROUND) then
        isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_BACKGROUND, false)
    end
    if (isOpen) then
        local idDic = self:getDicByModuleType(moduleType)
        for id, decorateVo in pairs(idDic) do
            isBubble = self:getIsNew(moduleType, id)
            if (isBubble) then
                break
            end
        end
    end
    return isBubble
end

-- 判断指定moduleType的id是否新获得
function getIsNew(self, moduleType, id)
    local readType = decorate.getReadTypeByModuleType(moduleType)
    if ((self:getIsActive(moduleType, id)) and (read.ReadManager:isModuleRead(readType, id))) then
        return true
    end
    return false
end

-- 判断指定moduleType的id是否正在使用
function getIsUsing(self, moduleType, id)
    local roleVo = role.RoleManager:getPersonalInfoList()
    if moduleType == decorate.ModuleType.HEAD_FRAME then
        if (id == roleVo:getAvatarFrameId() and self:getFrameUsingId() <= 0) or id == self:getFrameUsingId() then
            return true
        end
    elseif moduleType == decorate.ModuleType.HEAD then
        if (id == roleVo:getAvatarId() and self:getUsingId() <= 0) or id == self:getUsingId() then
            return true
        end
    end
    return false
end

-- 修改头像框当前假使用(刷新较慢)
function setFrameUsingId(self, id)
    self.mFrameUsingId = id
end
--获取头像框当前假使用(刷新较慢)
function getFrameUsingId(self)
    return self.mFrameUsingId
end
-- 修改头像当前假使用(刷新较慢)
function setUsingId(self, id)
    self.mUsingId = id
end
--获取头像当前假使用(刷新较慢)
function getUsingId(self)
    return self.mUsingId
end
-- 修改当前显示头像框的index
function setFrameSelectIndex(self, index)
    self.mFrameSelectIndex = index
end
--获取当前显示头像框的index
function getFrameSelectIndex(self)
    return self.mFrameSelectIndex
end
-- 修改当前显示头像的index
function setSelectIndex(self, index)
    self.mSelectIndex = index
end
--获取当前显示头像的index
function getSelectIndex(self)
    return self.mSelectIndex
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]