_class("SortedDictionary", Object)
SortedDictionary = SortedDictionary

function SortedDictionary:Constructor(compare_method, less_comparer)
  self.sorted_key = SortedArray:New(compare_method, less_comparer)
  self.dictionary = {}
end

function SortedDictionary:Empty()
  return self.sorted_key:Empty()
end

function SortedDictionary:Insert(key, value)
  if not key or not value then
    return
  end
  self.sorted_key:Insert(key)
  self.dictionary[key] = value
end

function SortedDictionary:Remove(key)
  if self.sorted_key:Remove(key) then
    local value = self.dictionary[key]
    self.dictionary[key] = nil
    return value
  end
end

function SortedDictionary:RemoveByIndex(index)
  local key = self.sorted_key:RemoveByIndex(index)
  if key then
    local value = self.dictionary[key]
    self.dictionary[key] = nil
    return value
  end
end

function SortedDictionary:Clear()
  local cnt = self.sorted_key:Size()
  if cnt == 0 then
    return
  end
  local key
  for i = 1, cnt do
    key = self.sorted_key:GetAt(i)
    self.dictionary[key] = nil
  end
  self.sorted_key:Clear()
end

function SortedDictionary:Find(key)
  return self.dictionary[key]
end

function SortedDictionary:FindIndex(key)
  return self.sorted_key:Find(key)
end

function SortedDictionary:Modify(key, value)
  if not key or not value then
    return
  end
  if self.sorted_key:Contains(key) then
    self.dictionary[key] = value
  end
end

function SortedDictionary:ContainsKey(key)
  return self.sorted_key:Contains(key)
end

function SortedDictionary:Size()
  return self.sorted_key:Size()
end

function SortedDictionary:GetAt(index)
  local key = self.sorted_key:GetAt(index)
  if not key then
    return nil
  end
  return self.dictionary[key], key
end

function SortedDictionary:GetKeyAt(index)
  local key = self.sorted_key:GetAt(index)
  return key
end

function SortedDictionary:GetPairAt(index)
  local key = self.sorted_key:GetAt(index)
  if not key then
    return nil
  end
  return key, self.dictionary[key]
end

function SortedDictionary:Copy(src)
  if src == nil then
    return
  end
  for i = 1, src:Size() do
    self:Insert(src:GetKeyAt(i), src:GetAt(i))
  end
end
