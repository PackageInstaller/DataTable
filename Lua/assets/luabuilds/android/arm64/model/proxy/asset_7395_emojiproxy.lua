local EmojiProxy = class("EmojiProxy", import(".NetProxy"))

EmojiProxy.NEW_EMOJI_SAVE_TAG = "new_emoji_save_tag_"

function EmojiProxy:register()
	self._initedTag = false
	self._emojiIDList = {}
	self._newIDList = {}

	return
end

function EmojiProxy:getInitedTag()
	return self._initedTag
end

function EmojiProxy:setInitedTag()
	self._initedTag = true

	return
end

function EmojiProxy:getNewEmojiIDLIst()
	return Clone(self._newIDList)
end

function EmojiProxy:addToEmojiIDLIst(arg_5_1)
	if table.indexof(self._emojiIDList, arg_5_1, 1) then
		return
	end

	table.insert(self._emojiIDList, arg_5_1)

	return
end

function EmojiProxy:saveNewEmojiIDList()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self._newIDList) do
		table.insert(var_6_0, iter_6_1)
	end

	PlayerPrefs.SetString(EmojiProxy.NEW_EMOJI_SAVE_TAG .. getProxy(PlayerProxy):getRawData().id, table.concat(var_6_0, ":"))

	return
end

function EmojiProxy:loadNewEmojiIDList()
	self._newIDList = {}

	local var_7_0 = string.split(PlayerPrefs.GetString(EmojiProxy.NEW_EMOJI_SAVE_TAG .. getProxy(PlayerProxy):getRawData().id) or "", ":")

	if #var_7_0 > 0 then
		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			table.insert(self._newIDList, tonumber(iter_7_1))
		end
	end

	return
end

function EmojiProxy:addNewEmojiID(arg_8_1)
	if table.indexof(self._emojiIDList, arg_8_1, 1) then
		return
	end

	table.insert(self._emojiIDList, arg_8_1)
	table.insert(self._newIDList, arg_8_1)
	self:saveNewEmojiIDList()

	return
end

function EmojiProxy:removeNewEmojiID(arg_9_1)
	local var_9_0 = table.indexof(self._newIDList, arg_9_1, 1)

	if not var_9_0 then
		assert(false, "new emoji list does not exit this emojiID:" .. arg_9_1)
	else
		table.remove(self._newIDList, var_9_0)
	end

	self:saveNewEmojiIDList()

	return
end

function EmojiProxy:fliteNewEmojiDataByType()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(self._newIDList) do
		if not var_10_0[pg.emoji_template[iter_10_1].type[1]] then
			var_10_0[pg.emoji_template[iter_10_1].type[1]] = {
				pg.emoji_template[iter_10_1]
			}
		else
			table.insert(var_10_0[pg.emoji_template[iter_10_1].type[1]], pg.emoji_template[iter_10_1])
		end
	end

	return var_10_0
end

function EmojiProxy:getEmojiDataByType(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(self._emojiIDList) do
		if table.contains(pg.emoji_template[iter_11_1].type, arg_11_1) then
			table.insert(var_11_0, pg.emoji_template[iter_11_1])
		end
	end

	return var_11_0
end

function EmojiProxy:getExEmojiDataByType(arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self._emojiIDList) do
		if not table.contains(self._newIDList, iter_12_1) then
			if table.contains(pg.emoji_template[iter_12_1].type, arg_12_1) then
				table.insert(var_12_0, pg.emoji_template[iter_12_1])
			end
		end
	end

	return var_12_0
end

return EmojiProxy
