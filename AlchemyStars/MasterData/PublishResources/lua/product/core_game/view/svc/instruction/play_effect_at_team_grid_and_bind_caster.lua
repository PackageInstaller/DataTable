LuaS 

xV           (w@m@../PublishResources/lua/product/core_game/view/svc/instruction/play_effect_at_team_grid_and_bind_caster.lua             @ A@  $@ @ AÀ   A $@À@  À@ l   
@À@ l@  
@ À@ l  
@&     requirebase_ins_r_class-PlayEffectAtTeamGridAndBindCasterInstructionBaseInstructionConstructorGetCacheResourceDoInstruction        	          @@ ÇÀ ¤ 
 @@ Ç Á ¤ ¢@    @ 
&     
_effectID	tonumber	effectID_bindCasterbindCaster                   
   
   
   
                              self       
paramList          _ENV           K    @ ¢    @  À@ À@À   FA GAÁ@ GGÁÁ +A ¤@f  &     
_effectID        tableinsertCfgcfg_effectResPath                                                                                     self       t         _ENV    )       @$ LA@Á  dÁ@¤ A¤ ÌAAä A ÀA@ÂBB À  $BÀ ÂBB À$B &     GetOwnerWorldGetServiceEffectPlayerGetCurrentTeamEntityGetGridPosition_bindCaster       !CreateGridEffectWithEffectHolder
_effectIDCreateWorldPositionEffect                          !   !   !   !   "   "   $   $   $   %   %   %   %   %   %   '   '   '   '   )      self       TT       casterEntity       phaseContext       world      effectService      teamEntity	      gridPos                                        	      	               )      )          _ENV