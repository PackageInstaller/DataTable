module("web.WebServerVo", Class.impl())

function ctor(self)
end

function setData(self, cusData)
    self.game_cdn = cusData.cdn
    self.server_id = cusData.srv_id
    self.server_name = cusData.srv_name
    self.server_type = cusData.srv_type
    self.ip = cusData.domain
    self.port = cusData.client_port
    self.is_weihu = cusData.status == "0"
    self.is_grayscale = cusData.is_grayscale
    self.is_merge = cusData.is_merge

    -- cusData.is_hot_update
    -- cusData.is_recommend
    -- cusData.logsrv_id
    -- cusData.maintain_time
    -- cusData.open_time
    -- cusData.sort
    -- cusData.type_status
end

function toString(self)
    local serverVoDic = {}
    serverVoDic["game_cdn"] = self.game_cdn
    serverVoDic["server_id"] = self.server_id
    serverVoDic["server_name"] = self.server_name
    serverVoDic["server_type"] = self.server_type
    serverVoDic["ip"] = self.ip
    serverVoDic["port"] = self.port
    serverVoDic["is_weihu"] = self.is_weihu
    serverVoDic["is_grayscale"] = self.is_grayscale
    serverVoDic["is_merge"] = self.is_merge

    local str = self:TableToStr(serverVoDic)
    return str
end

function toTable(self, str)
    local serverVoDic = self:StrToTable(str)
    if(serverVoDic)then
        self.game_cdn = serverVoDic["game_cdn"]
        self.server_id = serverVoDic["server_id"]
        self.server_name = serverVoDic["server_name"]
        self.server_type = serverVoDic["server_type"]
        self.ip = serverVoDic["ip"]
        self.port = serverVoDic["port"]
        self.is_weihu = serverVoDic["is_weihu"]
        self.is_grayscale = serverVoDic["is_grayscale"]
        self.is_merge = serverVoDic["is_merge"]
    end

    return self.game_cdn and self.server_id and self.server_name and self.server_type and self.ip and self.port
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ToStringEx(self, value)
    if type(value) == "table" then
        return self:TableToStr(value)
    elseif type(value) == "string" then
        return "'" .. value .. "'"
    else
        return tostring(value)
    end
end

function TableToStr(self, t)
    if t == nil then
        return ""
    end
    local retstr = "{"

    local i = 1
    for key, value in pairs(t) do
        local signal = ","
        if i == 1 then
            signal = ""
        end

        if key == i then
            retstr = retstr .. signal .. self:ToStringEx(value)
        else
            if type(key) == "number" or type(key) == "string" then
                retstr = retstr .. signal .. "[" .. self:ToStringEx(key) .. "]=" .. self:ToStringEx(value)
            else
                if type(key) == "userdata" then
                    retstr =
                        retstr ..
                        signal .. "*s" .. self:TableToStr(getmetatable(key)) .. "*e" .. "=" .. self:ToStringEx(value)
                else
                    retstr = retstr .. signal .. key .. "=" .. self:ToStringEx(value)
                end
            end
        end

        i = i + 1
    end

    retstr = retstr .. "}"
    return retstr
end

function StrToTable(self, str)
    if str == nil or type(str) ~= "string" then
        return
    end

    return loadstring("return " .. str)()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
