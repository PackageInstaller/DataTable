local InvestCenter = {
  self = nil,
  Img_BG = nil,
  Img_BGMask = nil,
  Img_BGright = nil,
  Img_BGdi = nil,
  Group_NPC = {
    self = nil,
    Img_Role = nil,
    SpineAnimation_Character = nil,
    SpineAnimation_Alpha = nil,
    Img_Dialog = {self = nil, Txt_Talk = nil},
    Img_Name = {self = nil, Txt_Name = nil}
  },
  Img_NPCMask = nil,
  Group_Main = {
    self = nil,
    Group_Btn = {
      self = nil,
      Btn_GoodsTrade = {
        self = nil,
        Txt_ = nil,
        Img_ = nil
      },
      Btn_GoodsInvest = {
        self = nil,
        Txt_ = nil,
        Img_ = nil
      },
      Btn_Talk = {
        self = nil,
        Txt_ = nil,
        Img_ = nil,
        Img_RedPoint = {
          self = nil,
          Group_Track_Q = {
            self = nil,
            Img_ = nil,
            UI_guideTip_01 = {
              self = nil,
              ring = nil,
              ring2 = nil,
              glow = nil,
              lizi = nil,
              glow2 = nil
            }
          }
        }
      }
    },
    Group_NpcInfo = {
      self = nil,
      Group_Dingwei = {
        self = nil,
        Img_ = nil,
        Txt_Station = nil
      },
      Img_ = nil,
      Txt_ = nil,
      Img_1 = nil
    }
  },
  Group_GoodsTrade = {
    self = nil,
    Group_In = {
      self = nil,
      Img_Bg = nil,
      Img_icon = {self = nil, Txt_ = nil},
      Img_barD = nil,
      Img_barU = nil,
      Txt_LV = nil,
      Txt_num = nil,
      Txt_numMax = nil,
      Txt_MissionCoin = nil,
      Img_coin = nil,
      Txt_coin = nil,
      Img_inBuffBg = nil,
      Txt_Buff = nil,
      Img_Lv0 = {self = nil, Txt_ = nil},
      ScrollGrid_ = {
        self = nil,
        grid = {
          self = nil,
          Img_ItemBg = nil,
          Img_Item = nil,
          Img_Buff1 = {self = nil, Txt_ = nil},
          Img_Buff2 = {self = nil, Txt_ = nil}
        }
      },
      Img_detailBg = {
        self = nil,
        Img_ = nil,
        Txt_ = nil
      },
      Btn_detail = nil
    },
    Group_Out = {
      self = nil,
      Img_Bg = nil,
      Img_icon = {self = nil, Txt_ = nil},
      Img_barD = nil,
      Img_barU = nil,
      Txt_LV = nil,
      Txt_num = nil,
      Txt_numMax = nil,
      Txt_MissionCoin = nil,
      Img_coin = nil,
      Txt_coin = nil,
      Img_inBuffBg = nil,
      Txt_Buff = nil,
      Img_Lv0 = {self = nil, Txt_ = nil},
      ScrollGrid_ = {
        self = nil,
        grid = {
          self = nil,
          Img_ItemBg = nil,
          Img_Item = nil,
          Img_Buff1 = {self = nil, Txt_ = nil},
          Img_Buff2 = {self = nil, Txt_ = nil}
        }
      },
      Img_detailBg = {
        self = nil,
        Img_ = nil,
        Txt_ = nil
      },
      Btn_detail = nil
    }
  },
  Group_spItem = {
    self = nil,
    ScrollGrid_ = {
      self = nil,
      grid = {
        self = nil,
        Img_BG = nil,
        Img_ = nil,
        Btn_Item = nil,
        Txt_Name = nil,
        Txt_Lv = nil,
        Txt_LvNum = nil,
        Img_Frame = {
          self = nil,
          Img_Buy = {
            self = nil,
            Txt_ = nil,
            Txt_num = nil
          },
          Img_have = {
            self = nil,
            Txt_ = nil,
            Txt_num = nil
          }
        },
        Group_NoMax = {
          self = nil,
          Img_Dot = nil,
          Txt_Detail = nil,
          Img_Bg = {
            self = nil,
            Img_coinBg = nil,
            Img_coin = nil,
            Txt_coinNum = nil,
            Txt_pay = nil,
            Txt_unlock = nil
          },
          Btn_ = nil
        },
        Group_Max = {
          self = nil,
          Img_BG = nil,
          Txt_ = nil
        }
      }
    }
  },
  Group_CommonTopLeft = {
    self = nil,
    Btn_Return = nil,
    Btn_Home = nil,
    Btn_Menu = nil,
    Btn_Help = {
      self = nil,
      Group_Txt = {
        self = nil,
        Img_icon = nil,
        Txt_ = nil
      }
    }
  },
  Group_Trade = {
    self = nil,
    Group_Help = {
      self = nil,
      Img_BG = nil,
      Img_ = nil,
      Btn_icon = nil,
      Txt_ = nil
    },
    Group_TradeLv = {
      self = nil,
      Img_BG = nil,
      Img_Icon = nil,
      Txt_Num = nil,
      Btn_Tips = {self = nil, Img_Click = nil}
    },
    Group_GoldCoin = {
      self = nil,
      Img_BG = nil,
      Btn_GoldCoin = nil,
      Img_Icon = nil,
      Txt_Num = nil,
      Btn_Add = nil
    },
    Group_Energy = {
      self = nil,
      Img_BG = nil,
      Img_PBBG = nil,
      Img_PB = nil,
      Txt_Num = nil,
      Btn_Add = {self = nil, Img_Click = nil},
      Btn_Icon = nil
    }
  },
  Group_GoodsTradeMission = {
    self = nil,
    Btn_BG = {
      self = nil,
      Img_ = nil,
      Group_Tips = {
        self = nil,
        Img_Tips = nil,
        Txt_Tips = nil
      }
    },
    Group_In = {
      self = nil,
      Img_Bg = nil,
      Img_Icon = {
        self = nil,
        Txt_ = nil,
        Txt_en = nil
      },
      ScrollGrid_ = {
        self = nil,
        grid = {
          self = nil,
          Img_inMissionDetailBg = nil,
          Txt_QuestName = nil,
          Txt_Detail = nil,
          Img_BarD = nil,
          Txt_Bar = nil,
          ScrollGrid_Item = {
            self = nil,
            grid = {
              self = nil,
              Img_ItemBg = nil,
              Img_Item = nil,
              Btn_detail = nil
            }
          },
          Group_Max = {
            self = nil,
            Img_ = nil,
            Img_ = nil,
            Txt_ = nil
          }
        }
      }
    },
    Group_Out = {
      self = nil,
      Img_Bg = nil,
      Img_Icon = {
        self = nil,
        Txt_ = nil,
        Txt_en = nil
      },
      ScrollGrid_ = {
        self = nil,
        grid = {
          self = nil,
          Img_inMissionDetailBg = nil,
          Txt_QuestName = nil,
          Txt_Detail = nil,
          Img_BarD = nil,
          Txt_Bar = nil,
          ScrollGrid_Item = {
            self = nil,
            grid = {
              self = nil,
              Img_ItemBg = nil,
              Img_Item = nil,
              Btn_detail = nil
            }
          },
          Group_Max = {
            self = nil,
            Img_ = nil,
            Img_ = nil,
            Txt_ = nil
          }
        }
      }
    }
  }
}
return InvestCenter
