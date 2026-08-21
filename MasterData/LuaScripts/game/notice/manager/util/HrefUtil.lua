module("notice.HrefUtil", Class.impl())

-- 角色
HREF_ROLE = "HREF_ROLE"
-- 道具
HREF_PROPS = "HREF_PROPS"

-- screenPos：屏幕坐标
-- localPos：相对父容器的本地坐标
function __hrefEventCall(self, screenPos, localPos, linkStr)
	local linkName, paramsTable = RichTextUtil:praseParamStr(linkStr)
	local str = ""
	for key, value in pairs(paramsTable) do
		str = str .. key .. "=" .. value .. ","
	end
	if(linkName == self.HREF_ROLE) then
		-- print(screenPos, localPos, "点击角色:" .. str)
		gs.Message.Show("点击玩家")
	elseif(linkName == self.HREF_PROPS) then
		-- print(screenPos, localPos, "点击道具:" .. str)
		local propsVo = props.PropsManager:getPropsConfigVo(tonumber(paramsTable.tid))
		TipsFactory:propsTips(propsVo)
	end
end

-- 将TextMeshPro的超链接内容文本解析为指定json数据字典（超链接示例：<link="['type':'HREF_WEB', 'url':'https://www.xxx.com']">我是链接</link>）
function praseTextMeshProLinkData(self, linkIdStr)
	if(linkIdStr and linkIdStr ~= "")then
		linkIdStr = string.gsub(linkIdStr, "\'", "\"")
		linkIdStr = string.gsub(linkIdStr, "%[", "{", 1)
		linkIdStr = string.gsub(linkIdStr, "%]", "}", 1)
        local function _tryParse()
            return JsonUtil.decode(linkIdStr)
        end
        local isParseOk, value = pcall(_tryParse)
        if isParseOk then
            return value
        else
			return nil
        end
	end
	return nil
end

-- 公用公告富文本超链接解析（技能描述示例：<link="['type':'HREF_WEB', 'url':'https://www.baidu.com']">百度</link>）
function commonNoticeDesLinkData(position, localPosition, linkIdStr, linkTextStr, param)
    if linkIdStr and linkTextStr then
        local linkData = notice.HrefUtil:praseTextMeshProLinkData(linkIdStr)
        local linkName = linkData["type"]
        local url = linkData["url"] or ""
        if (linkName == "HREF_WEB") then
			local bulletinVo = bulletin.BulletinManager:getBulletinVoById(param)
			if ((url == "" or url == nil) and bulletinVo and bulletinVo.url) then
				url = bulletinVo.url
			end
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.WebView, param = { webUrl = url} })
        elseif (linkName == "HREF_SURVEY_WEB") then
			local bulletinVo = bulletin.BulletinManager:getBulletinVoById(param)
			if ((url == "" or url == nil) and bulletinVo and bulletinVo.url) then
				url = bulletinVo.url
			end
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.SurveyWebView, param = { bulletinId = param, webUrl = url} })
        elseif (linkName == "HREF_BROWSER") then
            sdk.SdkManager:jumpBrowserWebView(url)
        elseif (linkName == "HREF_QQ_GROUP") then
            if (sdk.SdkManager:getIsShowJoinQQGroup()) then
                if (sdk.SdkManager:getJoinQQGroup()) then
                    -- gs.Message.Show("一键加群成功")
                    print("一键加群成功")
                else
                    -- gs.Message.Show("一键加群失败")
                    print("一键加群失败")
                end
            else
                -- gs.Message.Show("不允许一键加群")
                print("不允许一键加群")
            end
        else
            Debug:log_error("HrefUtil", "未定义公告超链接类型")
        end
    else
        Debug:log_error("HrefUtil", "公告超链接参数错误")
    end
end

-- 公用技能富文本超链接解析（技能描述示例：<link="['title':'标题', 'des':'120007']">我是技能</link>）
function commonTitleDesLinkData(position, localPosition, linkIdStr, linkTextStr)
    if linkIdStr and linkTextStr then
        local linkData = notice.HrefUtil:praseTextMeshProLinkData(linkIdStr)
        local title = linkData["title"]
        local des = linkData["des"]
        TipsFactory:SkillEffectTips({ title = title, des = des })
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
