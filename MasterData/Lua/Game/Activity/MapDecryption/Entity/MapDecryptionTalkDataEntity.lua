

---@class MapDecryptionTalkDataEntity
local MapDecryptionTalkDataEntity = Class('MapDecryptionTalkDataEntity')


function MapDecryptionTalkDataEntity:__init()
    self.people          = 0        --- 角色id

    self.isUnlockNewTalk = false
    self.talkList   = {
        -- {talkId, unlockTime}
    }
end


function MapDecryptionTalkDataEntity:__delete()

end

---Fill
---填充数据
---@param serverData table { --- 理想数据
--      people = 0,  --- 角色id 
--      talkId = 0,  --- 闲聊id
--      time = 0,    --- 解锁时间
---@}
function MapDecryptionTalkDataEntity:Fill(serverData)
    self.people    = checkNumber(serverData.people)
    self:AddTalk(serverData)

    return self

end

function MapDecryptionTalkDataEntity:AddTalk(serverData)
    table.insert(self.talkList, {talkId = checkNumber(serverData.talkId), unlockTime = checkNumber(serverData.time)})
    
end


return MapDecryptionTalkDataEntity
