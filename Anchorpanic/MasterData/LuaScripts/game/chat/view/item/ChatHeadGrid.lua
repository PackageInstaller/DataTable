module("chat.ChatHeadGrid", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("chat/ChatHeaGrid.prefab")

function __init(self)
    super.__initData(self)
    
    --------------------------------------------- 数据源 self.m_data 为 chat.chatVo ---------------------------------------------
    self.m_playerHeadGrid = nil
end

function __reset(self)
    if(self.m_playerHeadGrid)then
        self.m_playerHeadGrid:poolRecover()
        self.m_playerHeadGrid = nil
    end
    super.__reset(self)
end

function setData(self, chatVo, cusIsAsyn)
    self:__reset()
    local name = self:__getPrefabName()
    self.m_uiGo = gs.GOPoolMgr:Get(name)
    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.m_uiGo)
    self:addOnClick(self.m_uiGo, self.__onClickHandler)
    self.m_isLoadFinish = true
    self.m_data = chatVo
    
    self:__updateHead(cusIsAsyn)
end

function __updateHead(self, cusIsAsyn)
    local chatVo = self:getData()
    if (chatVo) then
        self.m_playerHeadGrid = PlayerHeadGrid:poolGet()
        self.m_playerHeadGrid:setData(chatVo:getSendHead(), cusIsAsyn)
        self.m_playerHeadGrid:setHeadFrame(chatVo:getSendHeadFrame())
        self.m_playerHeadGrid:setParent(self.m_childTrans["BaseGrid"])
    end
end

function setCallBack(self, cusCallObj, cusCallFun, ...)
    super.setCallBack(self, cusCallObj, cusCallFun, ...)
    
    if (self.m_playerHeadGrid) then
        self.m_playerHeadGrid:setClickEnable(false)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
