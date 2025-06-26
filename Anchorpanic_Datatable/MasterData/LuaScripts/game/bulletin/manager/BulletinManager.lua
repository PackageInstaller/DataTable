--[[  
-----------------------------------------------------
@filename       : BulletinManager
@Description    : 游戏内公告数据管理器
@date           : 2020-08-04 11:18:55
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.bulletin.manager.BulletinManager', Class.impl(Manager))

-- 公告刷新
EVENT_BULLETIN_UPDATE = "EVENT_BULLETIN_UPDATE"

-- 公告界面关闭
EVENT_BULLETIN_PANEL_CLOSE = "EVENT_BULLETIN_PANEL_CLOSE"

--构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

--初始化
function __init(self)
    self.bulletinData = {}
    self.mBulletinDic = nil
end

-- 解析公告数据
function parseBulletinMsg(self, msg)
    self.bulletinData = {}
    self.mBulletinDic = {}
    for i = 1, #msg.announce_list do
        local pt_announce_info = msg.announce_list[i]
        local vo = LuaPoolMgr:poolGet(bulletin.BulletinVo)
        vo:parseMsgData(pt_announce_info)
        if not self.mBulletinDic[vo.type] then
            self.mBulletinDic[vo.type] = {}
        end
        if table.indexof(self.mBulletinDic[vo.type], vo) == false then
            table.insert(self.mBulletinDic[vo.type], vo)
        end
        table.insert(self.bulletinData, vo)
    end
    for _, bulletinList in pairs(self.mBulletinDic) do
        table.sort(bulletinList, function(a, b)
            return a.sort < b.sort
        end)
    end
    self:dispatchEvent(self.EVENT_BULLETIN_UPDATE)

    self:updateBubble()
end

-- 公告数据
function getBulletinData(self)
    return self.bulletinData or {}
end

function getBulletinDataByType(self, type)
    if not self.mBulletinDic then
        return {}
    end
    return self.mBulletinDic[type] or {}
end

-- 根据公告id获取数据
function getBulletinVoById(self, bulletinId)
    local list = self:getBulletinData()
    for i, bulletinVo in ipairs(list) do
        if (bulletinVo.id == bulletinId) then
            return bulletinVo
        end
    end
    return nil
end

function getIsBubble(self)
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BULLETIN)
    if not isOpen then
        return false
    end
    local isBubble = false
    local list = self:getBulletinData()
    for i, bulletinVo in ipairs(list) do
        if bulletinVo.type ~= bulletin.BulletinConst.BULLETIN_SYSTEM then
            if (self:__isBulletIdBubble(bulletinVo.id)) then
                isBubble = true
                break
            end
        end
    end
    return isBubble
end

function updateBubble(self)
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_BULLETIN, self:getIsBubble())
end

function __isBulletIdBubble(self, bulletinId)
    if (read.ReadManager:isModuleRead(ReadConst.SYSTEM_BULLETIN, bulletinId)) then
        return false
    else
        return true
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]