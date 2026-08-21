module("fight.PlayerController", Class.impl(Controller))
--模块间事件监听
function listNotification(self)
	GameDispatcher:addEventListener(EventName.FIGHT_SKILL_LANUCH_PLAYER,self.onUseSkillHandler,self)
	GameDispatcher:addEventListener(EventName.BREAK_SKILL,self.onBreakSkillHandler,self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_IS_RENAME = self.onIsRename,
    }
end

function onUseSkillHandler(self,cusData)
	fight.PlayerManager:creaetSkillPlayer(cusData)
end

function onBreakSkillHandler(self,cusData)

end

function onIsRename(self,msg)
	fight.PlayerManager:setIsRename(msg.is_rename==1)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
