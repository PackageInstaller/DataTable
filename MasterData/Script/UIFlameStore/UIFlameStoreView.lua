local FlameStore = {
  self = nil,
  Img_BG = nil,
  UI_Img_BackGround_Drak = nil,
  Group_NPC = {
    self = nil,
    Img_Role = nil,
    SpineAnimation_Character = nil,
    SpineAnimation_Alpha = nil,
    Img_Dialog = {self = nil, Txt_Talk = nil},
    Img_Name = {self = nil, Txt_Name = nil},
    Btn_Chat = nil
  },
  Img_NPCMask = nil,
  Img_Icon = {self = nil, Txt_Name = nil},
  Group_Right = {
    self = nil,
    NewScrollGrid_CommodityList = {
      self = nil,
      grid = {
        self = nil,
        Btn_Item = {
          self = nil,
          Img_BG = nil,
          Img_NumBG = nil,
          Txt_PurchaseNum = {self = nil, Txt_Num = nil},
          Txt_SY = nil,
          Group_Money = {
            self = nil,
            Img_Money = nil,
            Txt_Price = nil
          },
          Group_SoldOut = {
            self = nil,
            Img_Mask = nil,
            Txt_SoldOut = nil,
            Img_ = nil
          },
          Group_Item = {
            self = nil,
            Btn_Item = nil,
            Img_Bottom = nil,
            Img_Item = nil,
            Img_Mask = nil,
            Group_Break = {
              self = nil,
              Img_Mask = {self = nil, Img_Face = nil},
              Img_F = nil
            },
            Txt_Num = nil,
            Img_Type01 = nil,
            Img_Type02 = nil,
            Group_EType = {
              self = nil,
              Img_IconBg = nil,
              Img_Icon = nil
            },
            Img_TimeLeft = {
              self = nil,
              Img_ = nil,
              Txt_ = nil
            },
            Group_Extra = {
              self = nil,
              Img_bg = {self = nil, Txt_txt = nil}
            },
            Group_Effect = nil
          },
          Txt_CommodityName = nil
        }
      }
    }
  },
  Group_TopRight = {
    self = nil,
    Img_BG = nil,
    Txt_Num = {self = nil, Txt_ = nil},
    Img_Money = nil,
    Btn_ = nil
  },
  StaticGrid_Coin = {
    self = nil,
    grid = {
      self = nil,
      Img_BG = nil,
      Txt_Num = {self = nil, Txt_ = nil},
      Img_Money = nil,
      Btn_ = nil
    }
  },
  Group_CommonTopLeft = {
    self = nil,
    Btn_Return = nil,
    Btn_Home = nil,
    Btn_Menu = nil,
    Btn_Help = {
      self = nil,
      Img_Tips = {
        self = nil,
        Img_icon = nil,
        Txt_ = nil
      }
    }
  }
}
return FlameStore
