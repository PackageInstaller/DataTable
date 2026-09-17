local this = {}

function this:showOrHideAllPlayer(isShow)
  AzurWorldInstance:SetNodeVisible(L_Const.WorldNode.PLAYER, isShow, L_Const.worldNodeHideType.LuaUIControlHide)
  AzurWorldInstance:SetNodeVisible(L_Const.WorldNode.PLAYERPETNODE, isShow, L_Const.worldNodeHideType.LuaUIControlHide)
end

return this
