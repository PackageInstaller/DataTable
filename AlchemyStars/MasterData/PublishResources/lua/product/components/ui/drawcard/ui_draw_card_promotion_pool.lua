LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/drawcard/ui_draw_card_promotion_pool.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ &     _classUIDrawCardPromotionPoolUICustomWidgetOnShowOnHideSetDataUpdatePoolData                  &                       self                      G @ b   F@@ Gΐ d Lΐΐ Η @ d@
 A&     timerGameGlobalTimerCancelEvent             	   	   	   
   
   
   
   
   
            self          _ENV    '    	'   
@  @ @@Ζ@ Ηΐΐ_ΐ  A @AΑ @ A@€@&  ΐA B €Ζ@B ΗΒΑB$ δ  @ CACΑ   @ ΐCΐFAD GΔd LΑΔΐ ,  d 
@&     	poolDataclose_typePrizePoolTypePROMOTION_POOLLogfatal([DrawCard] pool type is not promotion: 
GetModuleSvrTimeModulemathfloorGetServerTimeextend_dataθ               \&    timerGameGlobalTimer	AddEvent         !   $        @@   @ ΐ@ Ε   $@ &     timer 
StartTaskUpdatePoolData           "   #   #   #   #   #   $          self'                                                                                                             $      %   '      self    '   data    '   timeModule   '   now   '   
deltaTime   '      _ENV )   4    	     @ @@Ζ@ € Μΐ@@ δΑ$ "   AA AAΑ $A B AB B$AAA AAΑ $A C ACLCΜΑΓδ d  $A  &     GameGlobal
GetModuleGambleModuleApplyAllPoolInfoGetSuccLognotice,[DrawCard] promotion time up, refresh poolsSwitchStateUIStateTypeUIDrawCard3[DrawCard] promotion time up, refresh pools failedToastManager
ShowToastGetReasonByErrorCode
GetResult             +   +   +   +   ,   ,   ,   -   -   -   -   .   .   .   .   /   /   /   /   /   1   1   1   1   2   2   2   2   2   2   2   4      self        TT        module       ack          _ENV                                          '      )   4   )   4          _ENV