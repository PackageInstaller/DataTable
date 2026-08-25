local CardPoemGenUtils = {}

function CardPoemGenUtils.GenPoem(things, randSeed)
  math.randomseed(randSeed or 0)
  CardPoemGenUtils.Shuffle(things)
  for index, itemKey in ipairs(things) do
    local decorateKeys = DT.GetOriginalConstant(itemKey)
    local decorateKey = decorateKeys[math.random(#decorateKeys)]
    local decorate = LT.Text(decorateKey)
    things[index] = decorate
  end
  local poemFormatGroup = DT.GetOriginalConstant("PoetryFormatGroup")
  local poemFormat = poemFormatGroup[math.random(#poemFormatGroup)]
  local formatContent = LT.Textf(poemFormat, table.unpack(things))
  return formatContent
end

function CardPoemGenUtils.Shuffle(t)
  local n = #t
  for i = n, 2, -1 do
    local j = math.random(i)
    t[i], t[j] = t[j], t[i]
  end
end

return CardPoemGenUtils
