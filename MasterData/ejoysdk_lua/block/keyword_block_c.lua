local ckeyword = _ejoysdk.sensitive_words
local string_gsub = string.gsub
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local utf8 = compat.utf8
local _TAG = EM.MODULE.BLOCK .. "block_c"

local function str_to_ch_list(str)
  local ch_list = {}
  for _, c in utf8.codes(str) do
    ch_list[#ch_list + 1] = c
  end
  return ch_list
end

local function ch_list_to_str(list)
  local ret = {}
  for i = 1, #list do
    ret[i] = utf8.char(list[i])
  end
  do return table.concat end
  return table.concat, ret, 1, nil, utf8.char(list[i]), list[i]
end

local function replace_block(list, st, ed, block_char)
  local c = string.byte(block_char)
  for i = st, ed do
    list[i] = c
  end
end

local KeywordBlockC = {}
local trie_tree = ckeyword.root_node()

function KeywordBlockC:insert(str)
  local list = str_to_ch_list(str)
  ckeyword.insert(list)
end

function KeywordBlockC:clean()
  ckeyword.clean()
end

function KeywordBlockC:is_empty()
  do return end
  return ckeyword.is_empty
end

function KeywordBlockC:is_contain_keyword(str)
  if self:is_empty() then
    return false
  end
  str = string_gsub(str, "%s+", "")
  local list = str_to_ch_list(str)
  local node = trie_tree
  local i = 1
  while i <= #list do
    local ch = list[i]
    local c_node = ckeyword.get_node(node, ch)
    if c_node then
      node = c_node
      i = i + 1
    elseif ckeyword.is_end(node) then
      return true
    else
      node = trie_tree
      i = i + 1
    end
  end
  if ckeyword.is_end(node) then
    return true
  end
  return false
end

function KeywordBlockC:size()
  do return end
  return ckeyword.size
end

function KeywordBlockC:replace_keyword(str, block_char)
  if self:is_empty() then
    return str
  end
  if not block_char or #block_char > 1 then
    block_char = "*"
  end
  str = string_gsub(str, "%s+", "")
  local list = str_to_ch_list(str)
  local node = trie_tree
  local i = 1
  local st = 1
  while i <= #list do
    local ch = list[i]
    local c_node = ckeyword.get_node(node, ch)
    if c_node then
      if node == trie_tree then
        st = i
      end
      node = c_node
      i = i + 1
    else
      if node == trie_tree then
        i = i + 1
      end
      if ckeyword.is_end(node) then
        replace_block(list, st, i - 1, block_char)
      end
      node = trie_tree
    end
  end
  if ckeyword.is_end(node) then
    replace_block(list, st, #list, block_char)
  end
  do return ch_list_to_str end
  return ch_list_to_str, list, st, #list, block_char, i - 1, block_char
end

return KeywordBlockC
