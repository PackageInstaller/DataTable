module("decorate.ChatBubbleVo", Class.impl())

function parseData(self, key, cusData)
    self.tid = key

    self.unlock_type = cusData.unlock_type
    self.unlock_list = cusData.unlock_list
    self.get_description = cusData.get_description
    self.res_name = cusData.res_name
    self.prefab_name = cusData.prefab_name
    self.sort = cusData.sort
    self.font_color = cusData.font_color
    self.icon = cusData.icon
end

function getPrefabPath(self)
    return "arts/fx/ui/chatItem/prefabs/" .. self.prefab_name
    -- return self.prefab_name
end

function getName(self)
    return _TT(self.res_name)
end

function getColorContent(self, content)
    return string.format("<color=#%s>%s</color>", self.font_color, content)
end

function getIcon(self )
    return "arts/ui/icon/chat5/".. self.icon
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
