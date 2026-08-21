MarkdownFlag = {
  H1 = 1,
  H2 = 2,
  H3 = 3,
  H4 = 4,
  H5 = 5,
  H6 = 6,
  Bold = 7,
  Link = 8,
  Code = 9,
  Quote = 10,
  ColorGreen = 11,
  ColorGray = 12,
  ColorRed = 13,
  Text = 14
}
_enum("MarkdownFlag", MarkdownFlag)
_class("MarkdownBuilder", Object)
MarkdownBuilder = MarkdownBuilder

function MarkdownBuilder:Constructor()
  self._content = {}
end

function MarkdownBuilder:ClearBuilder()
  self._content = {}
end

function MarkdownBuilder:Append(flag, str)
  local key = GetEnumKey("MarkdownFlag", flag)
  self["Append" .. key](self, str)
  return self
end

function MarkdownBuilder:AppendH1(str)
  local s = "# " .. str .. "\n"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendH2(str)
  local s = [[

## ]] .. str .. "\n"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendH3(str)
  local s = "### " .. str .. "\n"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendH4(str)
  local s = "#### " .. str .. "\n"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendH5(str)
  local s = "##### " .. str .. "\n"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendH6(str)
  local s = "###### " .. str .. "\n"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendBold(str)
  local s = "**" .. str .. "**"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendLink(str, url)
  local s = "[" .. str .. "](" .. url .. ")"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendCode(str)
  local s = "`" .. str .. "`"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendQuote(str)
  local s = "> " .. str .. "\n"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendColorGreen(str)
  local s = "<font color=\"info\">" .. str .. "</font>"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendColorGray(str)
  local s = "<font color=\"comment\">" .. str .. "</font>"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendColorOrange(str)
  local s = "<font color=\"warning\">" .. str .. "</font>"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendColorRed(str)
  local s = "<font color='0xff0000'>" .. str .. "</font>"
  self._content[#self._content + 1] = s
  return self
end

function MarkdownBuilder:AppendText(str)
  self._content[#self._content + 1] = str
  return self
end

function MarkdownBuilder:ToString()
  local s = table.concat(self._content, " ")
  return s
end
