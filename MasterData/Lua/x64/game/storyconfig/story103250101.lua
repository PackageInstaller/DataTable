return {
	Play325011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325011001
		arg_1_1.duration_ = 3.73

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2015 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2015")
				var_4_0.name = "ST2015"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2015 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2015

				arg_1_1.bgs_.ST2015.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2015" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "1077ui_story"

			if arg_1_1.actors_["1077ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1077ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1077ui_story"].transform

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.73333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos1077ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 1.73333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.73333333333333 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_1_1.time_ - 1.73333333333333) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.73333333333333 + var_4_15 and arg_1_1.time_ < 1.73333333333333 + var_4_15 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, 100, 0)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles

				local var_4_16 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_16 then
					var_4_16:EnableDynamicBone(true)
				end
			end

			local var_4_17 = arg_1_1.actors_["1077ui_story"]

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.73333333333333 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1077ui_story == nil then
				arg_1_1.var_.characterEffect1077ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 1.73333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.73333333333333 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect1077ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.73333333333333 + var_4_18 and arg_1_1.time_ < 1.73333333333333 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1077ui_story then
				arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.73333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.73333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_town", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 1.93333333631357
			local var_4_26 = 0.175

			if 1.93333333631357 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_28 = arg_1_1:GetWordFromCfg(325011001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 7 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 7)

				if (7 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 7)) > 0 and var_4_26 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_25 = var_4_25 + 0.3

					if var_4_31 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011001", "story_v_out_325011.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_325011", "325011001", "story_v_out_325011.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_325011", "325011001", "story_v_out_325011.awb")

						arg_1_1:RecordAudio("325011001", var_4_33)
						arg_1_1:RecordAudio("325011001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325011", "325011001", "story_v_out_325011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325011", "325011001", "story_v_out_325011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_34 = var_4_25 + 0.3
			local var_4_35 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325011002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1077ui_story = arg_8_1.actors_["1077ui_story"].transform.localPosition

				local var_11_0 = GameObjectTools.GetOrAddComponent(arg_8_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_11_0 then
					var_11_0:EnableDynamicBone(false)
				end
			end

			local var_11_1 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_1 then
				arg_8_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_1)
				arg_8_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).z)
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles = arg_8_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_1 and arg_8_1.time_ < 0 + var_11_1 + arg_11_0 then
				arg_8_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1077ui_story"].transform.position).z)
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["1077ui_story"].transform.localEulerAngles = arg_8_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_11_2 = GameObjectTools.GetOrAddComponent(arg_8_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(true)
				end
			end

			local var_11_3 = arg_8_1.actors_["1077ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1077ui_story == nil then
				arg_8_1.var_.characterEffect1077ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1077ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_4)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1077ui_story then
				arg_8_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_11_5 = 0
			local var_11_6 = 1.35

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_7 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325011002).content)

				arg_8_1.text_.text = var_11_7

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_9 = 54 <= 0 and var_11_6 or var_11_6 * (utf8.len(var_11_7) / 54)

				if (54 <= 0 and var_11_6 or var_11_6 * (utf8.len(var_11_7) / 54)) > 0 and var_11_6 < var_11_9 then
					arg_8_1.talkMaxDuration = var_11_9

					if var_11_9 + var_11_5 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_9 + var_11_5
					end
				end

				arg_8_1.text_.text = var_11_7
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_6, arg_8_1.talkMaxDuration)

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_5) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_5 + var_11_10 and arg_8_1.time_ < var_11_5 + var_11_10 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play325011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325011003
		arg_12_1.duration_ = 2.8

		local var_12_0 = {
			zh = 2.7,
			ja = 2.8
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1077ui_story = arg_12_1.actors_["1077ui_story"].transform.localPosition

				local var_15_0 = GameObjectTools.GetOrAddComponent(arg_12_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_15_0 then
					var_15_0:EnableDynamicBone(false)
				end
			end

			local var_15_1 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_1 then
				arg_12_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_12_1.time_ - 0) / var_15_1)
				arg_12_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1077ui_story"].transform.position).z)
				arg_12_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["1077ui_story"].transform.localEulerAngles = arg_12_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_1 and arg_12_1.time_ < 0 + var_15_1 + arg_15_0 then
				arg_12_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_12_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1077ui_story"].transform.position).z)
				arg_12_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["1077ui_story"].transform.localEulerAngles = arg_12_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_15_2 = GameObjectTools.GetOrAddComponent(arg_12_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(true)
				end
			end

			local var_15_3 = arg_12_1.actors_["1077ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1077ui_story == nil then
				arg_12_1.var_.characterEffect1077ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect1077ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1077ui_story then
				arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_15_6 = 0
			local var_15_7 = 0.25

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_8 = arg_12_1:GetWordFromCfg(325011003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 10 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_9) / 10)

				if (10 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_9) / 10)) > 0 and var_15_7 < var_15_11 then
					arg_12_1.talkMaxDuration = var_15_11

					if var_15_11 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_11 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011003", "story_v_out_325011.awb") ~= 0 then
					local var_15_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011003", "story_v_out_325011.awb") / 1000

					if var_15_12 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_6
					end

					if var_15_8.prefab_name ~= "" and arg_12_1.actors_[var_15_8.prefab_name] ~= nil then
						local var_15_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_8.prefab_name].transform, "story_v_out_325011", "325011003", "story_v_out_325011.awb")

						arg_12_1:RecordAudio("325011003", var_15_13)
						arg_12_1:RecordAudio("325011003", var_15_13)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325011", "325011003", "story_v_out_325011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325011", "325011003", "story_v_out_325011.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play325011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325011004
		arg_16_1.duration_ = 6.07

		local var_16_0 = {
			zh = 4.9,
			ja = 6.066
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1077ui_story"]) and arg_16_1.var_.characterEffect1077ui_story == nil then
				arg_16_1.var_.characterEffect1077ui_story = arg_16_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1077ui_story"]) then
				if arg_16_1.var_.characterEffect1077ui_story and not isNil(arg_16_1.actors_["1077ui_story"]) then
					arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_0)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1077ui_story"]) and arg_16_1.var_.characterEffect1077ui_story then
				arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_19_1 = 0
			local var_19_2 = 0.6

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1465].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(325011004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 24 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 24)

				if (24 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 24)) > 0 and var_19_2 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011004", "story_v_out_325011.awb") ~= 0 then
					local var_19_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011004", "story_v_out_325011.awb") / 1000

					if var_19_7 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_1
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_325011", "325011004", "story_v_out_325011.awb")

						arg_16_1:RecordAudio("325011004", var_19_8)
						arg_16_1:RecordAudio("325011004", var_19_8)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325011", "325011004", "story_v_out_325011.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325011", "325011004", "story_v_out_325011.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_9 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_9 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_9

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_9 and arg_16_1.time_ < var_19_1 + var_19_9 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play325011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325011005
		arg_20_1.duration_ = 6.7

		local var_20_0 = {
			zh = 4.566,
			ja = 6.7
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1077ui_story"]) and arg_20_1.var_.characterEffect1077ui_story == nil then
				arg_20_1.var_.characterEffect1077ui_story = arg_20_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1077ui_story"]) then
				if arg_20_1.var_.characterEffect1077ui_story and not isNil(arg_20_1.actors_["1077ui_story"]) then
					arg_20_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1077ui_story"]) and arg_20_1.var_.characterEffect1077ui_story then
				arg_20_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_23_2 = 0
			local var_23_3 = 0.475

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_4 = arg_20_1:GetWordFromCfg(325011005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 19 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 19)

				if (19 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 19)) > 0 and var_23_3 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011005", "story_v_out_325011.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011005", "story_v_out_325011.awb") / 1000

					if var_23_8 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_2
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_out_325011", "325011005", "story_v_out_325011.awb")

						arg_20_1:RecordAudio("325011005", var_23_9)
						arg_20_1:RecordAudio("325011005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325011", "325011005", "story_v_out_325011.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325011", "325011005", "story_v_out_325011.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_3, arg_20_1.talkMaxDuration)

			if var_23_2 <= arg_20_1.time_ and arg_20_1.time_ < var_23_2 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_2) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_2 + var_23_10 and arg_20_1.time_ < var_23_2 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325011006
		arg_24_1.duration_ = 12.5

		local var_24_0 = {
			zh = 7.133,
			ja = 12.5
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1077ui_story"]) and arg_24_1.var_.characterEffect1077ui_story == nil then
				arg_24_1.var_.characterEffect1077ui_story = arg_24_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1077ui_story"]) then
				if arg_24_1.var_.characterEffect1077ui_story and not isNil(arg_24_1.actors_["1077ui_story"]) then
					arg_24_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1077ui_story"]) and arg_24_1.var_.characterEffect1077ui_story then
				arg_24_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.875

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1465].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(325011006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 35 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_4) / 35)

				if (35 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_4) / 35)) > 0 and var_27_2 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011006", "story_v_out_325011.awb") ~= 0 then
					local var_27_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011006", "story_v_out_325011.awb") / 1000

					if var_27_7 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_1
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_325011", "325011006", "story_v_out_325011.awb")

						arg_24_1:RecordAudio("325011006", var_27_8)
						arg_24_1:RecordAudio("325011006", var_27_8)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325011", "325011006", "story_v_out_325011.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325011", "325011006", "story_v_out_325011.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_9 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_9 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_9

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_9 and arg_24_1.time_ < var_27_1 + var_27_9 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325011007
		arg_28_1.duration_ = 8.6

		local var_28_0 = {
			zh = 7.5,
			ja = 8.6
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325011008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.95

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1465].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:GetWordFromCfg(325011007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 38 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 38)

				if (38 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 38)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011007", "story_v_out_325011.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011007", "story_v_out_325011.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_325011", "325011007", "story_v_out_325011.awb")

						arg_28_1:RecordAudio("325011007", var_31_6)
						arg_28_1:RecordAudio("325011007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325011", "325011007", "story_v_out_325011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325011", "325011007", "story_v_out_325011.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325011008
		arg_32_1.duration_ = 8

		local var_32_0 = {
			zh = 8,
			ja = 5.433
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1077ui_story"]) and arg_32_1.var_.characterEffect1077ui_story == nil then
				arg_32_1.var_.characterEffect1077ui_story = arg_32_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1077ui_story"]) then
				if arg_32_1.var_.characterEffect1077ui_story and not isNil(arg_32_1.actors_["1077ui_story"]) then
					arg_32_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1077ui_story"]) and arg_32_1.var_.characterEffect1077ui_story then
				arg_32_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_35_2 = 0
			local var_35_3 = 0.8

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_4 = arg_32_1:GetWordFromCfg(325011008)
				local var_35_5 = arg_32_1:FormatText(var_35_4.content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 32 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 32)

				if (32 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 32)) > 0 and var_35_3 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011008", "story_v_out_325011.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011008", "story_v_out_325011.awb") / 1000

					if var_35_8 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_2
					end

					if var_35_4.prefab_name ~= "" and arg_32_1.actors_[var_35_4.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_4.prefab_name].transform, "story_v_out_325011", "325011008", "story_v_out_325011.awb")

						arg_32_1:RecordAudio("325011008", var_35_9)
						arg_32_1:RecordAudio("325011008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325011", "325011008", "story_v_out_325011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325011", "325011008", "story_v_out_325011.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_10 and arg_32_1.time_ < var_35_2 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325011009
		arg_36_1.duration_ = 10.1

		local var_36_0 = {
			zh = 8.866,
			ja = 10.1
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325011010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1077ui_story"]) and arg_36_1.var_.characterEffect1077ui_story == nil then
				arg_36_1.var_.characterEffect1077ui_story = arg_36_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1077ui_story"]) then
				if arg_36_1.var_.characterEffect1077ui_story and not isNil(arg_36_1.actors_["1077ui_story"]) then
					arg_36_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1077ui_story"]) and arg_36_1.var_.characterEffect1077ui_story then
				arg_36_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_39_1 = 0
			local var_39_2 = 1.05

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1465].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(325011009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 42 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_4) / 42)

				if (42 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_4) / 42)) > 0 and var_39_2 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011009", "story_v_out_325011.awb") ~= 0 then
					local var_39_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011009", "story_v_out_325011.awb") / 1000

					if var_39_7 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_1
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_325011", "325011009", "story_v_out_325011.awb")

						arg_36_1:RecordAudio("325011009", var_39_8)
						arg_36_1:RecordAudio("325011009", var_39_8)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325011", "325011009", "story_v_out_325011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325011", "325011009", "story_v_out_325011.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_9 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_9 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_9

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_9 and arg_36_1.time_ < var_39_1 + var_39_9 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play325011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325011010
		arg_40_1.duration_ = 10.33

		local var_40_0 = {
			zh = 8.133,
			ja = 10.333
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325011011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.875

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1465].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:GetWordFromCfg(325011010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 35 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 35)

				if (35 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 35)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011010", "story_v_out_325011.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011010", "story_v_out_325011.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_325011", "325011010", "story_v_out_325011.awb")

						arg_40_1:RecordAudio("325011010", var_43_6)
						arg_40_1:RecordAudio("325011010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325011", "325011010", "story_v_out_325011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325011", "325011010", "story_v_out_325011.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325011011
		arg_44_1.duration_ = 2.73

		local var_44_0 = {
			zh = 1.999999999999,
			ja = 2.733
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1077ui_story"]) and arg_44_1.var_.characterEffect1077ui_story == nil then
				arg_44_1.var_.characterEffect1077ui_story = arg_44_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1077ui_story"]) then
				if arg_44_1.var_.characterEffect1077ui_story and not isNil(arg_44_1.actors_["1077ui_story"]) then
					arg_44_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1077ui_story"]) and arg_44_1.var_.characterEffect1077ui_story then
				arg_44_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_47_2 = 0
			local var_47_3 = 0.15

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(325011011)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 6 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 6)

				if (6 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 6)) > 0 and var_47_3 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011011", "story_v_out_325011.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011011", "story_v_out_325011.awb") / 1000

					if var_47_8 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_2
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_out_325011", "325011011", "story_v_out_325011.awb")

						arg_44_1:RecordAudio("325011011", var_47_9)
						arg_44_1:RecordAudio("325011011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325011", "325011011", "story_v_out_325011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325011", "325011011", "story_v_out_325011.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_10 and arg_44_1.time_ < var_47_2 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play325011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325011012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325011013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1077ui_story = arg_48_1.actors_["1077ui_story"].transform.localPosition

				local var_51_0 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_0 then
					var_51_0:EnableDynamicBone(false)
				end
			end

			local var_51_1 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_1 then
				arg_48_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_1)
				arg_48_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1077ui_story"].transform.position).z)
				arg_48_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1077ui_story"].transform.localEulerAngles = arg_48_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_1 and arg_48_1.time_ < 0 + var_51_1 + arg_51_0 then
				arg_48_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1077ui_story"].transform.position).z)
				arg_48_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1077ui_story"].transform.localEulerAngles = arg_48_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_51_2 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(true)
				end
			end

			local var_51_3 = arg_48_1.actors_["1077ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect1077ui_story == nil then
				arg_48_1.var_.characterEffect1077ui_story = var_51_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_4 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 and not isNil(var_51_3) then
				if arg_48_1.var_.characterEffect1077ui_story and not isNil(var_51_3) then
					arg_48_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_4)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect1077ui_story then
				arg_48_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_51_5 = 0
			local var_51_6 = 1.35

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_7 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(325011012).content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 54 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_7) / 54)

				if (54 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_7) / 54)) > 0 and var_51_6 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_5
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_6, arg_48_1.talkMaxDuration)

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_5) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_5 + var_51_10 and arg_48_1.time_ < var_51_5 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play325011013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325011013
		arg_52_1.duration_ = 2.83

		local var_52_0 = {
			zh = 2.833,
			ja = 2.633
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325011014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1077ui_story = arg_52_1.actors_["1077ui_story"].transform.localPosition

				local var_55_0 = GameObjectTools.GetOrAddComponent(arg_52_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_55_0 then
					var_55_0:EnableDynamicBone(false)
				end
			end

			local var_55_1 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_1 then
				arg_52_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_52_1.time_ - 0) / var_55_1)
				arg_52_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1077ui_story"].transform.position).z)
				arg_52_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1077ui_story"].transform.localEulerAngles = arg_52_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_1 and arg_52_1.time_ < 0 + var_55_1 + arg_55_0 then
				arg_52_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_52_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1077ui_story"].transform.position).z)
				arg_52_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1077ui_story"].transform.localEulerAngles = arg_52_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_55_2 = GameObjectTools.GetOrAddComponent(arg_52_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(true)
				end
			end

			local var_55_3 = arg_52_1.actors_["1077ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_3) and arg_52_1.var_.characterEffect1077ui_story == nil then
				arg_52_1.var_.characterEffect1077ui_story = var_55_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_4 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 and not isNil(var_55_3) then
				if arg_52_1.var_.characterEffect1077ui_story and not isNil(var_55_3) then
					arg_52_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 and not isNil(var_55_3) and arg_52_1.var_.characterEffect1077ui_story then
				arg_52_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_55_6 = 0
			local var_55_7 = 0.225

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_8 = arg_52_1:GetWordFromCfg(325011013)
				local var_55_9 = arg_52_1:FormatText(var_55_8.content)

				arg_52_1.text_.text = var_55_9

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 9 <= 0 and var_55_7 or var_55_7 * (utf8.len(var_55_9) / 9)

				if (9 <= 0 and var_55_7 or var_55_7 * (utf8.len(var_55_9) / 9)) > 0 and var_55_7 < var_55_11 then
					arg_52_1.talkMaxDuration = var_55_11

					if var_55_11 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_9
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011013", "story_v_out_325011.awb") ~= 0 then
					local var_55_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011013", "story_v_out_325011.awb") / 1000

					if var_55_12 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_12 + var_55_6
					end

					if var_55_8.prefab_name ~= "" and arg_52_1.actors_[var_55_8.prefab_name] ~= nil then
						local var_55_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_8.prefab_name].transform, "story_v_out_325011", "325011013", "story_v_out_325011.awb")

						arg_52_1:RecordAudio("325011013", var_55_13)
						arg_52_1:RecordAudio("325011013", var_55_13)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325011", "325011013", "story_v_out_325011.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325011", "325011013", "story_v_out_325011.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_14 and arg_52_1.time_ < var_55_6 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play325011014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325011014
		arg_56_1.duration_ = 5.8

		local var_56_0 = {
			zh = 4.1,
			ja = 5.8
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325011015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1077ui_story"]) and arg_56_1.var_.characterEffect1077ui_story == nil then
				arg_56_1.var_.characterEffect1077ui_story = arg_56_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1077ui_story"]) then
				if arg_56_1.var_.characterEffect1077ui_story and not isNil(arg_56_1.actors_["1077ui_story"]) then
					arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1077ui_story"]) and arg_56_1.var_.characterEffect1077ui_story then
				arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_59_1 = 0
			local var_59_2 = 0.45

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[688].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(325011014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 18 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 18)

				if (18 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 18)) > 0 and var_59_2 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011014", "story_v_out_325011.awb") ~= 0 then
					local var_59_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011014", "story_v_out_325011.awb") / 1000

					if var_59_7 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_1
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_325011", "325011014", "story_v_out_325011.awb")

						arg_56_1:RecordAudio("325011014", var_59_8)
						arg_56_1:RecordAudio("325011014", var_59_8)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325011", "325011014", "story_v_out_325011.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325011", "325011014", "story_v_out_325011.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_9 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_9 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_9

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_9 and arg_56_1.time_ < var_59_1 + var_59_9 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play325011015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325011015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play325011016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1077ui_story = arg_60_1.actors_["1077ui_story"].transform.localPosition

				local var_63_0 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_0 then
					var_63_0:EnableDynamicBone(false)
				end
			end

			local var_63_1 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_1 then
				arg_60_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_1)
				arg_60_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1077ui_story"].transform.position).z)
				arg_60_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1077ui_story"].transform.localEulerAngles = arg_60_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_1 and arg_60_1.time_ < 0 + var_63_1 + arg_63_0 then
				arg_60_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1077ui_story"].transform.position).z)
				arg_60_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1077ui_story"].transform.localEulerAngles = arg_60_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_63_2 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(true)
				end
			end

			local var_63_3 = 0
			local var_63_4 = 1.05

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_3 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_5 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(325011015).content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_7 = 42 <= 0 and var_63_4 or var_63_4 * (utf8.len(var_63_5) / 42)

				if (42 <= 0 and var_63_4 or var_63_4 * (utf8.len(var_63_5) / 42)) > 0 and var_63_4 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_3 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_3
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_4, arg_60_1.talkMaxDuration)

			if var_63_3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_3 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_3) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_3 + var_63_8 and arg_60_1.time_ < var_63_3 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play325011016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325011016
		arg_64_1.duration_ = 5.57

		local var_64_0 = {
			zh = 2.733,
			ja = 5.566
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325011017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.3

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[688].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:GetWordFromCfg(325011016)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 12 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 12)

				if (12 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 12)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011016", "story_v_out_325011.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011016", "story_v_out_325011.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_325011", "325011016", "story_v_out_325011.awb")

						arg_64_1:RecordAudio("325011016", var_67_6)
						arg_64_1:RecordAudio("325011016", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325011", "325011016", "story_v_out_325011.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325011", "325011016", "story_v_out_325011.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play325011017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325011017
		arg_68_1.duration_ = 10.27

		local var_68_0 = {
			zh = 10.266,
			ja = 9.866
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play325011018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1077ui_story"]) and arg_68_1.var_.characterEffect1077ui_story == nil then
				arg_68_1.var_.characterEffect1077ui_story = arg_68_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1077ui_story"]) then
				if arg_68_1.var_.characterEffect1077ui_story and not isNil(arg_68_1.actors_["1077ui_story"]) then
					arg_68_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1077ui_story"]) and arg_68_1.var_.characterEffect1077ui_story then
				arg_68_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_71_2 = arg_68_1.actors_["1077ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1077ui_story = var_71_2.localPosition

				local var_71_3 = GameObjectTools.GetOrAddComponent(var_71_2.gameObject, typeof(DynamicBoneHelper))

				if var_71_3 then
					var_71_3:EnableDynamicBone(false)
				end
			end

			local var_71_4 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				var_71_2.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_68_1.time_ - 0) / var_71_4)
				var_71_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_2.position).x, (manager.ui.mainCamera.transform.position - var_71_2.position).y, (manager.ui.mainCamera.transform.position - var_71_2.position).z)
				var_71_2.localEulerAngles.z = 0
				var_71_2.localEulerAngles.x = 0
				var_71_2.localEulerAngles = var_71_2.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				var_71_2.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_71_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_2.position).x, (manager.ui.mainCamera.transform.position - var_71_2.position).y, (manager.ui.mainCamera.transform.position - var_71_2.position).z)
				var_71_2.localEulerAngles.z = 0
				var_71_2.localEulerAngles.x = 0
				var_71_2.localEulerAngles = var_71_2.localEulerAngles

				local var_71_5 = GameObjectTools.GetOrAddComponent(var_71_2.gameObject, typeof(DynamicBoneHelper))

				if var_71_5 then
					var_71_5:EnableDynamicBone(true)
				end
			end

			local var_71_6 = 0
			local var_71_7 = 1.1

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_8 = arg_68_1:GetWordFromCfg(325011017)
				local var_71_9 = arg_68_1:FormatText(var_71_8.content)

				arg_68_1.text_.text = var_71_9

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 44 <= 0 and var_71_7 or var_71_7 * (utf8.len(var_71_9) / 44)

				if (44 <= 0 and var_71_7 or var_71_7 * (utf8.len(var_71_9) / 44)) > 0 and var_71_7 < var_71_11 then
					arg_68_1.talkMaxDuration = var_71_11

					if var_71_11 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_11 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_9
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011017", "story_v_out_325011.awb") ~= 0 then
					local var_71_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011017", "story_v_out_325011.awb") / 1000

					if var_71_12 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_12 + var_71_6
					end

					if var_71_8.prefab_name ~= "" and arg_68_1.actors_[var_71_8.prefab_name] ~= nil then
						local var_71_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_8.prefab_name].transform, "story_v_out_325011", "325011017", "story_v_out_325011.awb")

						arg_68_1:RecordAudio("325011017", var_71_13)
						arg_68_1:RecordAudio("325011017", var_71_13)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325011", "325011017", "story_v_out_325011.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325011", "325011017", "story_v_out_325011.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_14 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_14 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_14

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_14 and arg_68_1.time_ < var_71_6 + var_71_14 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play325011018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325011018
		arg_72_1.duration_ = 9

		local var_72_0 = {
			zh = 5.333,
			ja = 9
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play325011019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1077ui_story"]) and arg_72_1.var_.characterEffect1077ui_story == nil then
				arg_72_1.var_.characterEffect1077ui_story = arg_72_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1077ui_story"]) then
				if arg_72_1.var_.characterEffect1077ui_story and not isNil(arg_72_1.actors_["1077ui_story"]) then
					arg_72_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1077ui_story"]) and arg_72_1.var_.characterEffect1077ui_story then
				arg_72_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_75_1 = 0
			local var_75_2 = 0.725

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[688].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:GetWordFromCfg(325011018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_6 = 29 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_4) / 29)

				if (29 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_4) / 29)) > 0 and var_75_2 < var_75_6 then
					arg_72_1.talkMaxDuration = var_75_6

					if var_75_6 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011018", "story_v_out_325011.awb") ~= 0 then
					local var_75_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011018", "story_v_out_325011.awb") / 1000

					if var_75_7 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_1
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_325011", "325011018", "story_v_out_325011.awb")

						arg_72_1:RecordAudio("325011018", var_75_8)
						arg_72_1:RecordAudio("325011018", var_75_8)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325011", "325011018", "story_v_out_325011.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325011", "325011018", "story_v_out_325011.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_9 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_9 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_9

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_9 and arg_72_1.time_ < var_75_1 + var_75_9 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play325011019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325011019
		arg_76_1.duration_ = 3.33

		local var_76_0 = {
			zh = 2.1,
			ja = 3.333
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play325011020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1077ui_story"]) and arg_76_1.var_.characterEffect1077ui_story == nil then
				arg_76_1.var_.characterEffect1077ui_story = arg_76_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1077ui_story"]) then
				if arg_76_1.var_.characterEffect1077ui_story and not isNil(arg_76_1.actors_["1077ui_story"]) then
					arg_76_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1077ui_story"]) and arg_76_1.var_.characterEffect1077ui_story then
				arg_76_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_79_2 = 0
			local var_79_3 = 0.225

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:GetWordFromCfg(325011019)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 9 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 9)

				if (9 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 9)) > 0 and var_79_3 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011019", "story_v_out_325011.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011019", "story_v_out_325011.awb") / 1000

					if var_79_8 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_2
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_out_325011", "325011019", "story_v_out_325011.awb")

						arg_76_1:RecordAudio("325011019", var_79_9)
						arg_76_1:RecordAudio("325011019", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325011", "325011019", "story_v_out_325011.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325011", "325011019", "story_v_out_325011.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_3, arg_76_1.talkMaxDuration)

			if var_79_2 <= arg_76_1.time_ and arg_76_1.time_ < var_79_2 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_2) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_2 + var_79_10 and arg_76_1.time_ < var_79_2 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play325011020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325011020
		arg_80_1.duration_ = 10.63

		local var_80_0 = {
			zh = 5.9,
			ja = 10.633
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play325011021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1077ui_story"]) and arg_80_1.var_.characterEffect1077ui_story == nil then
				arg_80_1.var_.characterEffect1077ui_story = arg_80_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1077ui_story"]) then
				if arg_80_1.var_.characterEffect1077ui_story and not isNil(arg_80_1.actors_["1077ui_story"]) then
					arg_80_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1077ui_story"]) and arg_80_1.var_.characterEffect1077ui_story then
				arg_80_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.75

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[688].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(325011020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_6 = 30 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 30)

				if (30 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 30)) > 0 and var_83_2 < var_83_6 then
					arg_80_1.talkMaxDuration = var_83_6

					if var_83_6 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011020", "story_v_out_325011.awb") ~= 0 then
					local var_83_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011020", "story_v_out_325011.awb") / 1000

					if var_83_7 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_1
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_325011", "325011020", "story_v_out_325011.awb")

						arg_80_1:RecordAudio("325011020", var_83_8)
						arg_80_1:RecordAudio("325011020", var_83_8)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_325011", "325011020", "story_v_out_325011.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_325011", "325011020", "story_v_out_325011.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_9 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_9 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_9

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_9 and arg_80_1.time_ < var_83_1 + var_83_9 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play325011021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325011021
		arg_84_1.duration_ = 2.3

		local var_84_0 = {
			zh = 2.233,
			ja = 2.3
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play325011022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1077ui_story"]) and arg_84_1.var_.characterEffect1077ui_story == nil then
				arg_84_1.var_.characterEffect1077ui_story = arg_84_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1077ui_story"]) then
				if arg_84_1.var_.characterEffect1077ui_story and not isNil(arg_84_1.actors_["1077ui_story"]) then
					arg_84_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1077ui_story"]) and arg_84_1.var_.characterEffect1077ui_story then
				arg_84_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077actionlink/1077action453")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_87_2 = 0
			local var_87_3 = 0.275

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:GetWordFromCfg(325011021)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 11 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 11)

				if (11 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 11)) > 0 and var_87_3 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011021", "story_v_out_325011.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011021", "story_v_out_325011.awb") / 1000

					if var_87_8 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_2
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_325011", "325011021", "story_v_out_325011.awb")

						arg_84_1:RecordAudio("325011021", var_87_9)
						arg_84_1:RecordAudio("325011021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_325011", "325011021", "story_v_out_325011.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_325011", "325011021", "story_v_out_325011.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_10 and arg_84_1.time_ < var_87_2 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play325011022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325011022
		arg_88_1.duration_ = 9.2

		local var_88_0 = {
			zh = 5.4,
			ja = 9.2
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play325011023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1077ui_story"]) and arg_88_1.var_.characterEffect1077ui_story == nil then
				arg_88_1.var_.characterEffect1077ui_story = arg_88_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1077ui_story"]) then
				if arg_88_1.var_.characterEffect1077ui_story and not isNil(arg_88_1.actors_["1077ui_story"]) then
					arg_88_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1077ui_story"]) and arg_88_1.var_.characterEffect1077ui_story then
				arg_88_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_91_1 = 0
			local var_91_2 = 0.65

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[688].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:GetWordFromCfg(325011022)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_6 = 26 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_4) / 26)

				if (26 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_4) / 26)) > 0 and var_91_2 < var_91_6 then
					arg_88_1.talkMaxDuration = var_91_6

					if var_91_6 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_1
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011022", "story_v_out_325011.awb") ~= 0 then
					local var_91_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011022", "story_v_out_325011.awb") / 1000

					if var_91_7 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_1
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_325011", "325011022", "story_v_out_325011.awb")

						arg_88_1:RecordAudio("325011022", var_91_8)
						arg_88_1:RecordAudio("325011022", var_91_8)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_325011", "325011022", "story_v_out_325011.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_325011", "325011022", "story_v_out_325011.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_9 = math.max(var_91_2, arg_88_1.talkMaxDuration)

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_9 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_1) / var_91_9

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_1 + var_91_9 and arg_88_1.time_ < var_91_1 + var_91_9 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play325011023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325011023
		arg_92_1.duration_ = 9.27

		local var_92_0 = {
			zh = 7.2,
			ja = 9.266
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play325011024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 1

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[688].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:GetWordFromCfg(325011023)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 40 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 40)

				if (40 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 40)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011023", "story_v_out_325011.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011023", "story_v_out_325011.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_325011", "325011023", "story_v_out_325011.awb")

						arg_92_1:RecordAudio("325011023", var_95_6)
						arg_92_1:RecordAudio("325011023", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325011", "325011023", "story_v_out_325011.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325011", "325011023", "story_v_out_325011.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play325011024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325011024
		arg_96_1.duration_ = 1.5

		local var_96_0 = {
			zh = 1.1,
			ja = 1.5
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325011025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1077ui_story"]) and arg_96_1.var_.characterEffect1077ui_story == nil then
				arg_96_1.var_.characterEffect1077ui_story = arg_96_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1077ui_story"]) then
				if arg_96_1.var_.characterEffect1077ui_story and not isNil(arg_96_1.actors_["1077ui_story"]) then
					arg_96_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1077ui_story"]) and arg_96_1.var_.characterEffect1077ui_story then
				arg_96_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_99_2 = 0
			local var_99_3 = 0.075

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:GetWordFromCfg(325011024)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 3 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 3)

				if (3 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 3)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011024", "story_v_out_325011.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011024", "story_v_out_325011.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_out_325011", "325011024", "story_v_out_325011.awb")

						arg_96_1:RecordAudio("325011024", var_99_9)
						arg_96_1:RecordAudio("325011024", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325011", "325011024", "story_v_out_325011.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325011", "325011024", "story_v_out_325011.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_10 and arg_96_1.time_ < var_99_2 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play325011025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325011025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play325011026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1077ui_story"]) and arg_100_1.var_.characterEffect1077ui_story == nil then
				arg_100_1.var_.characterEffect1077ui_story = arg_100_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1077ui_story"]) then
				if arg_100_1.var_.characterEffect1077ui_story and not isNil(arg_100_1.actors_["1077ui_story"]) then
					arg_100_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1077ui_story"]) and arg_100_1.var_.characterEffect1077ui_story then
				arg_100_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_103_1 = arg_100_1.actors_["1077ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1077ui_story = var_103_1.localPosition

				local var_103_2 = GameObjectTools.GetOrAddComponent(var_103_1.gameObject, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(false)
				end
			end

			local var_103_3 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 then
				var_103_1.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_3)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 then
				var_103_1.localPosition = Vector3.New(0, 100, 0)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles

				local var_103_4 = GameObjectTools.GetOrAddComponent(var_103_1.gameObject, typeof(DynamicBoneHelper))

				if var_103_4 then
					var_103_4:EnableDynamicBone(true)
				end
			end

			local var_103_5 = 0
			local var_103_6 = 0.7

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_7 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(325011025).content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 28 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_7) / 28)

				if (28 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_7) / 28)) > 0 and var_103_6 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_5 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_5
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_6, arg_100_1.talkMaxDuration)

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_5) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_5 + var_103_10 and arg_100_1.time_ < var_103_5 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play325011026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 325011026
		arg_104_1.duration_ = 4.23

		local var_104_0 = {
			zh = 1.033,
			ja = 4.233
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play325011027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.125

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[688].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_1 = arg_104_1:GetWordFromCfg(325011026)
				local var_107_2 = arg_104_1:FormatText(var_107_1.content)

				arg_104_1.text_.text = var_107_2

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 5 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 5)

				if (5 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 5)) > 0 and var_107_0 < var_107_4 then
					arg_104_1.talkMaxDuration = var_107_4

					if var_107_4 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_4 + 0
					end
				end

				arg_104_1.text_.text = var_107_2
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011026", "story_v_out_325011.awb") ~= 0 then
					local var_107_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011026", "story_v_out_325011.awb") / 1000

					if var_107_5 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + 0
					end

					if var_107_1.prefab_name ~= "" and arg_104_1.actors_[var_107_1.prefab_name] ~= nil then
						local var_107_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_1.prefab_name].transform, "story_v_out_325011", "325011026", "story_v_out_325011.awb")

						arg_104_1:RecordAudio("325011026", var_107_6)
						arg_104_1:RecordAudio("325011026", var_107_6)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_325011", "325011026", "story_v_out_325011.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_325011", "325011026", "story_v_out_325011.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play325011027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325011027
		arg_108_1.duration_ = 7.8

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play325011028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 1.3 < arg_108_1.time_ and arg_108_1.time_ <= 1.3 + arg_111_0 then
				local var_111_0 = arg_108_1.bgs_.ST2015

				arg_108_1.bgs_.ST2015.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_111_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_111_1 = var_111_0:GetComponent("SpriteRenderer")

				if var_111_1 and var_111_1.sprite then
					local var_111_2 = 2 * (var_111_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_111_0.transform.localScale = Vector3.New(var_111_2 / var_111_1.sprite.bounds.size.y < var_111_2 * manager.ui.mainCameraCom_.aspect / var_111_1.sprite.bounds.size.x and var_111_2 * manager.ui.mainCameraCom_.aspect / var_111_1.sprite.bounds.size.x or var_111_2 / var_111_1.sprite.bounds.size.y, var_111_2 / var_111_1.sprite.bounds.size.y < var_111_2 * manager.ui.mainCameraCom_.aspect / var_111_1.sprite.bounds.size.x and var_111_2 * manager.ui.mainCameraCom_.aspect / var_111_1.sprite.bounds.size.x or var_111_2 / var_111_1.sprite.bounds.size.y, 0)
				end

				for iter_111_0, iter_111_1 in pairs(arg_108_1.bgs_) do
					if iter_111_0 ~= "ST2015" then
						iter_111_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_111_3 = 1.3

			if 1.3 < arg_108_1.time_ and arg_108_1.time_ <= var_111_3 + arg_111_0 then
				arg_108_1.allBtn_.enabled = false
			end

			if arg_108_1.time_ >= var_111_3 + 0.3 and arg_108_1.time_ < var_111_3 + 0.3 + arg_111_0 then
				arg_108_1.allBtn_.enabled = true
			end

			local var_111_4 = 0

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.mask_.enabled = true
				arg_108_1.mask_.raycastTarget = true

				arg_108_1:SetGaussion(false)
			end

			local var_111_5 = 1.3

			if var_111_4 <= arg_108_1.time_ and arg_108_1.time_ < var_111_4 + var_111_5 then
				local var_111_6 = Color.New(0, 0, 0)

				var_111_6.a = Mathf.Lerp(0, 1, (arg_108_1.time_ - var_111_4) / var_111_5)
				arg_108_1.mask_.color = var_111_6
			end

			if arg_108_1.time_ >= var_111_4 + var_111_5 and arg_108_1.time_ < var_111_4 + var_111_5 + arg_111_0 then
				local var_111_7 = Color.New(0, 0, 0)

				var_111_7.a = 1
				arg_108_1.mask_.color = var_111_7
			end

			local var_111_8 = 1.3

			if 1.3 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.mask_.enabled = true
				arg_108_1.mask_.raycastTarget = true

				arg_108_1:SetGaussion(false)
			end

			local var_111_9 = 2

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_9 then
				local var_111_10 = Color.New(0, 0, 0)

				var_111_10.a = Mathf.Lerp(1, 0, (arg_108_1.time_ - var_111_8) / var_111_9)
				arg_108_1.mask_.color = var_111_10
			end

			if arg_108_1.time_ >= var_111_8 + var_111_9 and arg_108_1.time_ < var_111_8 + var_111_9 + arg_111_0 then
				local var_111_11 = Color.New(0, 0, 0)

				arg_108_1.mask_.enabled = false
				var_111_11.a = 0
				arg_108_1.mask_.color = var_111_11
			end

			local var_111_12 = arg_108_1.actors_["1077ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1077ui_story = var_111_12.localPosition

				local var_111_13 = GameObjectTools.GetOrAddComponent(var_111_12.gameObject, typeof(DynamicBoneHelper))

				if var_111_13 then
					var_111_13:EnableDynamicBone(false)
				end
			end

			local var_111_14 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_14 then
				var_111_12.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_14)
				var_111_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_12.position).x, (manager.ui.mainCamera.transform.position - var_111_12.position).y, (manager.ui.mainCamera.transform.position - var_111_12.position).z)
				var_111_12.localEulerAngles.z = 0
				var_111_12.localEulerAngles.x = 0
				var_111_12.localEulerAngles = var_111_12.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_14 and arg_108_1.time_ < 0 + var_111_14 + arg_111_0 then
				var_111_12.localPosition = Vector3.New(0, 100, 0)
				var_111_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_12.position).x, (manager.ui.mainCamera.transform.position - var_111_12.position).y, (manager.ui.mainCamera.transform.position - var_111_12.position).z)
				var_111_12.localEulerAngles.z = 0
				var_111_12.localEulerAngles.x = 0
				var_111_12.localEulerAngles = var_111_12.localEulerAngles

				local var_111_15 = GameObjectTools.GetOrAddComponent(var_111_12.gameObject, typeof(DynamicBoneHelper))

				if var_111_15 then
					var_111_15:EnableDynamicBone(true)
				end
			end

			if arg_108_1.frameCnt_ <= 1 then
				arg_108_1.dialog_:SetActive(false)
			end

			local var_111_16 = 2.8
			local var_111_17 = 1.375

			if 2.8 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0

				arg_108_1.dialog_:SetActive(true)

				arg_108_1.dialogCg_.alpha = 0

				local var_111_18 = LeanTween.value(arg_108_1.dialog_, 0, 1, 0.3)

				var_111_18:setOnUpdate(LuaHelper.FloatAction(function(arg_112_0)
					arg_108_1.dialogCg_.alpha = arg_112_0
				end))
				var_111_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_108_1.dialog_)
					var_111_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_108_1.duration_ = arg_108_1.duration_ + 0.3

				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_19 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(325011027).content)

				arg_108_1.text_.text = var_111_19

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_21 = 55 <= 0 and var_111_17 or var_111_17 * (utf8.len(var_111_19) / 55)

				if (55 <= 0 and var_111_17 or var_111_17 * (utf8.len(var_111_19) / 55)) > 0 and var_111_17 < var_111_21 then
					arg_108_1.talkMaxDuration = var_111_21
					var_111_16 = var_111_16 + 0.3

					if var_111_21 + var_111_16 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_21 + var_111_16
					end
				end

				arg_108_1.text_.text = var_111_19
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_22 = var_111_16 + 0.3
			local var_111_23 = math.max(var_111_17, arg_108_1.talkMaxDuration)

			if var_111_16 + 0.3 <= arg_108_1.time_ and arg_108_1.time_ < var_111_22 + var_111_23 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_22) / var_111_23

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_22 + var_111_23 and arg_108_1.time_ < var_111_22 + var_111_23 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play325011028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325011028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play325011029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 1.3

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(325011028).content)

				arg_114_1.text_.text = var_117_1

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_3 = 52 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 52)

				if (52 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 52)) > 0 and var_117_0 < var_117_3 then
					arg_114_1.talkMaxDuration = var_117_3

					if var_117_3 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_3 + 0
					end
				end

				arg_114_1.text_.text = var_117_1
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_4 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_4

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play325011029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325011029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play325011030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 1.375

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(325011029).content)

				arg_118_1.text_.text = var_121_1

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_3 = 55 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 55)

				if (55 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 55)) > 0 and var_121_0 < var_121_3 then
					arg_118_1.talkMaxDuration = var_121_3

					if var_121_3 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_3 + 0
					end
				end

				arg_118_1.text_.text = var_121_1
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_4 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_4

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play325011030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325011030
		arg_122_1.duration_ = 1.5

		local var_122_0 = {
			zh = 1,
			ja = 1.5
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play325011031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1077ui_story = arg_122_1.actors_["1077ui_story"].transform.localPosition

				local var_125_0 = GameObjectTools.GetOrAddComponent(arg_122_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_125_0 then
					var_125_0:EnableDynamicBone(false)
				end
			end

			local var_125_1 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_1 then
				arg_122_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_122_1.time_ - 0) / var_125_1)
				arg_122_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1077ui_story"].transform.position).z)
				arg_122_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1077ui_story"].transform.localEulerAngles = arg_122_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_1 and arg_122_1.time_ < 0 + var_125_1 + arg_125_0 then
				arg_122_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1077ui_story"].transform.position).z)
				arg_122_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1077ui_story"].transform.localEulerAngles = arg_122_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_125_2 = GameObjectTools.GetOrAddComponent(arg_122_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_125_2 then
					var_125_2:EnableDynamicBone(true)
				end
			end

			local var_125_3 = arg_122_1.actors_["1077ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_3) and arg_122_1.var_.characterEffect1077ui_story == nil then
				arg_122_1.var_.characterEffect1077ui_story = var_125_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_4 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 and not isNil(var_125_3) then
				if arg_122_1.var_.characterEffect1077ui_story and not isNil(var_125_3) then
					arg_122_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 and not isNil(var_125_3) and arg_122_1.var_.characterEffect1077ui_story then
				arg_122_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_125_6 = 0
			local var_125_7 = 0.05

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_8 = arg_122_1:GetWordFromCfg(325011030)
				local var_125_9 = arg_122_1:FormatText(var_125_8.content)

				arg_122_1.text_.text = var_125_9

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 2 <= 0 and var_125_7 or var_125_7 * (utf8.len(var_125_9) / 2)

				if (2 <= 0 and var_125_7 or var_125_7 * (utf8.len(var_125_9) / 2)) > 0 and var_125_7 < var_125_11 then
					arg_122_1.talkMaxDuration = var_125_11

					if var_125_11 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_11 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_9
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011030", "story_v_out_325011.awb") ~= 0 then
					local var_125_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011030", "story_v_out_325011.awb") / 1000

					if var_125_12 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_12 + var_125_6
					end

					if var_125_8.prefab_name ~= "" and arg_122_1.actors_[var_125_8.prefab_name] ~= nil then
						local var_125_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_8.prefab_name].transform, "story_v_out_325011", "325011030", "story_v_out_325011.awb")

						arg_122_1:RecordAudio("325011030", var_125_13)
						arg_122_1:RecordAudio("325011030", var_125_13)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_325011", "325011030", "story_v_out_325011.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_325011", "325011030", "story_v_out_325011.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_14 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_14 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_14

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_14 and arg_122_1.time_ < var_125_6 + var_125_14 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play325011031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325011031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play325011032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1077ui_story = arg_126_1.actors_["1077ui_story"].transform.localPosition

				local var_129_0 = GameObjectTools.GetOrAddComponent(arg_126_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_129_0 then
					var_129_0:EnableDynamicBone(false)
				end
			end

			local var_129_1 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_1 then
				arg_126_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_1)
				arg_126_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1077ui_story"].transform.position).z)
				arg_126_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1077ui_story"].transform.localEulerAngles = arg_126_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_1 and arg_126_1.time_ < 0 + var_129_1 + arg_129_0 then
				arg_126_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1077ui_story"].transform.position).z)
				arg_126_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1077ui_story"].transform.localEulerAngles = arg_126_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_129_2 = GameObjectTools.GetOrAddComponent(arg_126_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_129_2 then
					var_129_2:EnableDynamicBone(true)
				end
			end

			local var_129_3 = arg_126_1.actors_["1077ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_3) and arg_126_1.var_.characterEffect1077ui_story == nil then
				arg_126_1.var_.characterEffect1077ui_story = var_129_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_4 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 and not isNil(var_129_3) then
				if arg_126_1.var_.characterEffect1077ui_story and not isNil(var_129_3) then
					arg_126_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_4)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 and not isNil(var_129_3) and arg_126_1.var_.characterEffect1077ui_story then
				arg_126_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_129_5 = 0
			local var_129_6 = 1.45

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_7 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(325011031).content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_9 = 58 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_7) / 58)

				if (58 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_7) / 58)) > 0 and var_129_6 < var_129_9 then
					arg_126_1.talkMaxDuration = var_129_9

					if var_129_9 + var_129_5 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_9 + var_129_5
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = math.max(var_129_6, arg_126_1.talkMaxDuration)

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_10 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_5) / var_129_10

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_5 + var_129_10 and arg_126_1.time_ < var_129_5 + var_129_10 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play325011032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325011032
		arg_130_1.duration_ = 7.9

		local var_130_0 = {
			zh = 5.533,
			ja = 7.9
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play325011033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.6

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[1521].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_1 = arg_130_1:GetWordFromCfg(325011032)
				local var_133_2 = arg_130_1:FormatText(var_133_1.content)

				arg_130_1.text_.text = var_133_2

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 24 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 24)

				if (24 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 24)) > 0 and var_133_0 < var_133_4 then
					arg_130_1.talkMaxDuration = var_133_4

					if var_133_4 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_4 + 0
					end
				end

				arg_130_1.text_.text = var_133_2
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011032", "story_v_out_325011.awb") ~= 0 then
					local var_133_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011032", "story_v_out_325011.awb") / 1000

					if var_133_5 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + 0
					end

					if var_133_1.prefab_name ~= "" and arg_130_1.actors_[var_133_1.prefab_name] ~= nil then
						local var_133_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_1.prefab_name].transform, "story_v_out_325011", "325011032", "story_v_out_325011.awb")

						arg_130_1:RecordAudio("325011032", var_133_6)
						arg_130_1:RecordAudio("325011032", var_133_6)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_325011", "325011032", "story_v_out_325011.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_325011", "325011032", "story_v_out_325011.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_7 and arg_130_1.time_ < 0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play325011033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325011033
		arg_134_1.duration_ = 6.57

		local var_134_0 = {
			zh = 4.3,
			ja = 6.566
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play325011034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1077ui_story"]) and arg_134_1.var_.characterEffect1077ui_story == nil then
				arg_134_1.var_.characterEffect1077ui_story = arg_134_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1077ui_story"]) then
				if arg_134_1.var_.characterEffect1077ui_story and not isNil(arg_134_1.actors_["1077ui_story"]) then
					arg_134_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1077ui_story"]) and arg_134_1.var_.characterEffect1077ui_story then
				arg_134_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_137_2 = arg_134_1.actors_["1077ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1077ui_story = var_137_2.localPosition

				local var_137_3 = GameObjectTools.GetOrAddComponent(var_137_2.gameObject, typeof(DynamicBoneHelper))

				if var_137_3 then
					var_137_3:EnableDynamicBone(false)
				end
			end

			local var_137_4 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 then
				var_137_2.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_134_1.time_ - 0) / var_137_4)
				var_137_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_2.position).x, (manager.ui.mainCamera.transform.position - var_137_2.position).y, (manager.ui.mainCamera.transform.position - var_137_2.position).z)
				var_137_2.localEulerAngles.z = 0
				var_137_2.localEulerAngles.x = 0
				var_137_2.localEulerAngles = var_137_2.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 then
				var_137_2.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_137_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_2.position).x, (manager.ui.mainCamera.transform.position - var_137_2.position).y, (manager.ui.mainCamera.transform.position - var_137_2.position).z)
				var_137_2.localEulerAngles.z = 0
				var_137_2.localEulerAngles.x = 0
				var_137_2.localEulerAngles = var_137_2.localEulerAngles

				local var_137_5 = GameObjectTools.GetOrAddComponent(var_137_2.gameObject, typeof(DynamicBoneHelper))

				if var_137_5 then
					var_137_5:EnableDynamicBone(true)
				end
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_137_6 = 0
			local var_137_7 = 0.475

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_8 = arg_134_1:GetWordFromCfg(325011033)
				local var_137_9 = arg_134_1:FormatText(var_137_8.content)

				arg_134_1.text_.text = var_137_9

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 19 <= 0 and var_137_7 or var_137_7 * (utf8.len(var_137_9) / 19)

				if (19 <= 0 and var_137_7 or var_137_7 * (utf8.len(var_137_9) / 19)) > 0 and var_137_7 < var_137_11 then
					arg_134_1.talkMaxDuration = var_137_11

					if var_137_11 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_11 + var_137_6
					end
				end

				arg_134_1.text_.text = var_137_9
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011033", "story_v_out_325011.awb") ~= 0 then
					local var_137_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011033", "story_v_out_325011.awb") / 1000

					if var_137_12 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_12 + var_137_6
					end

					if var_137_8.prefab_name ~= "" and arg_134_1.actors_[var_137_8.prefab_name] ~= nil then
						local var_137_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_8.prefab_name].transform, "story_v_out_325011", "325011033", "story_v_out_325011.awb")

						arg_134_1:RecordAudio("325011033", var_137_13)
						arg_134_1:RecordAudio("325011033", var_137_13)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_325011", "325011033", "story_v_out_325011.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_325011", "325011033", "story_v_out_325011.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_14 = math.max(var_137_7, arg_134_1.talkMaxDuration)

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_14 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_6) / var_137_14

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_6 + var_137_14 and arg_134_1.time_ < var_137_6 + var_137_14 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play325011034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325011034
		arg_138_1.duration_ = 5.9

		local var_138_0 = {
			zh = 5.5,
			ja = 5.9
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play325011035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1077ui_story"]) and arg_138_1.var_.characterEffect1077ui_story == nil then
				arg_138_1.var_.characterEffect1077ui_story = arg_138_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1077ui_story"]) then
				if arg_138_1.var_.characterEffect1077ui_story and not isNil(arg_138_1.actors_["1077ui_story"]) then
					arg_138_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1077ui_story"]) and arg_138_1.var_.characterEffect1077ui_story then
				arg_138_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_141_1 = 0
			local var_141_2 = 0.475

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1521].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(325011034)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_6 = 19 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_4) / 19)

				if (19 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_4) / 19)) > 0 and var_141_2 < var_141_6 then
					arg_138_1.talkMaxDuration = var_141_6

					if var_141_6 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011034", "story_v_out_325011.awb") ~= 0 then
					local var_141_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011034", "story_v_out_325011.awb") / 1000

					if var_141_7 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_1
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_out_325011", "325011034", "story_v_out_325011.awb")

						arg_138_1:RecordAudio("325011034", var_141_8)
						arg_138_1:RecordAudio("325011034", var_141_8)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_325011", "325011034", "story_v_out_325011.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_325011", "325011034", "story_v_out_325011.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_9 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_9 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_9

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_9 and arg_138_1.time_ < var_141_1 + var_141_9 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play325011035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 325011035
		arg_142_1.duration_ = 3.87

		local var_142_0 = {
			zh = 2.333,
			ja = 3.866
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play325011036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1077ui_story"]) and arg_142_1.var_.characterEffect1077ui_story == nil then
				arg_142_1.var_.characterEffect1077ui_story = arg_142_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1077ui_story"]) then
				if arg_142_1.var_.characterEffect1077ui_story and not isNil(arg_142_1.actors_["1077ui_story"]) then
					arg_142_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1077ui_story"]) and arg_142_1.var_.characterEffect1077ui_story then
				arg_142_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_145_2 = 0

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_2 + arg_145_0 then
				arg_142_1.allBtn_.enabled = false
			end

			if arg_142_1.time_ >= var_145_2 + 1.13333333333333 and arg_142_1.time_ < var_145_2 + 1.13333333333333 + arg_145_0 then
				arg_142_1.allBtn_.enabled = true
			end

			if arg_142_1.frameCnt_ <= 1 then
				arg_142_1.dialog_:SetActive(false)
			end

			local var_145_3 = 0.6
			local var_145_4 = 0.175

			if 0.6 < arg_142_1.time_ and arg_142_1.time_ <= var_145_3 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0

				arg_142_1.dialog_:SetActive(true)

				arg_142_1.dialogCg_.alpha = 0

				local var_145_5 = LeanTween.value(arg_142_1.dialog_, 0, 1, 0.3)

				var_145_5:setOnUpdate(LuaHelper.FloatAction(function(arg_146_0)
					arg_142_1.dialogCg_.alpha = arg_146_0
				end))
				var_145_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_142_1.dialog_)
					var_145_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_142_1.duration_ = arg_142_1.duration_ + 0.3

				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_6 = arg_142_1:GetWordFromCfg(325011035)
				local var_145_7 = arg_142_1:FormatText(var_145_6.content)

				arg_142_1.text_.text = var_145_7

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_9 = 7 <= 0 and var_145_4 or var_145_4 * (utf8.len(var_145_7) / 7)

				if (7 <= 0 and var_145_4 or var_145_4 * (utf8.len(var_145_7) / 7)) > 0 and var_145_4 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9
					var_145_3 = var_145_3 + 0.3

					if var_145_9 + var_145_3 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_3
					end
				end

				arg_142_1.text_.text = var_145_7
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011035", "story_v_out_325011.awb") ~= 0 then
					local var_145_10 = manager.audio:GetVoiceLength("story_v_out_325011", "325011035", "story_v_out_325011.awb") / 1000

					if var_145_10 + var_145_3 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_3
					end

					if var_145_6.prefab_name ~= "" and arg_142_1.actors_[var_145_6.prefab_name] ~= nil then
						local var_145_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_6.prefab_name].transform, "story_v_out_325011", "325011035", "story_v_out_325011.awb")

						arg_142_1:RecordAudio("325011035", var_145_11)
						arg_142_1:RecordAudio("325011035", var_145_11)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_325011", "325011035", "story_v_out_325011.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_325011", "325011035", "story_v_out_325011.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_12 = var_145_3 + 0.3
			local var_145_13 = math.max(var_145_4, arg_142_1.talkMaxDuration)

			if var_145_3 + 0.3 <= arg_142_1.time_ and arg_142_1.time_ < var_145_12 + var_145_13 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_12) / var_145_13

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_12 + var_145_13 and arg_142_1.time_ < var_145_12 + var_145_13 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play325011036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325011036
		arg_148_1.duration_ = 6.1

		local var_148_0 = {
			zh = 4.033,
			ja = 6.1
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play325011037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1077ui_story"]) and arg_148_1.var_.characterEffect1077ui_story == nil then
				arg_148_1.var_.characterEffect1077ui_story = arg_148_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1077ui_story"]) then
				if arg_148_1.var_.characterEffect1077ui_story and not isNil(arg_148_1.actors_["1077ui_story"]) then
					arg_148_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_0)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1077ui_story"]) and arg_148_1.var_.characterEffect1077ui_story then
				arg_148_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_151_1 = 0
			local var_151_2 = 0.375

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1521].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_3 = arg_148_1:GetWordFromCfg(325011036)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_6 = 15 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_4) / 15)

				if (15 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_4) / 15)) > 0 and var_151_2 < var_151_6 then
					arg_148_1.talkMaxDuration = var_151_6

					if var_151_6 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011036", "story_v_out_325011.awb") ~= 0 then
					local var_151_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011036", "story_v_out_325011.awb") / 1000

					if var_151_7 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_1
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_325011", "325011036", "story_v_out_325011.awb")

						arg_148_1:RecordAudio("325011036", var_151_8)
						arg_148_1:RecordAudio("325011036", var_151_8)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_325011", "325011036", "story_v_out_325011.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_325011", "325011036", "story_v_out_325011.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_9 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_9 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_9

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_9 and arg_148_1.time_ < var_151_1 + var_151_9 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play325011037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 325011037
		arg_152_1.duration_ = 7.13

		local var_152_0 = {
			zh = 4.866,
			ja = 7.133
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play325011038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1077ui_story"]) and arg_152_1.var_.characterEffect1077ui_story == nil then
				arg_152_1.var_.characterEffect1077ui_story = arg_152_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1077ui_story"]) then
				if arg_152_1.var_.characterEffect1077ui_story and not isNil(arg_152_1.actors_["1077ui_story"]) then
					arg_152_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1077ui_story"]) and arg_152_1.var_.characterEffect1077ui_story then
				arg_152_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_155_2 = 0
			local var_155_3 = 0.575

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_4 = arg_152_1:GetWordFromCfg(325011037)
				local var_155_5 = arg_152_1:FormatText(var_155_4.content)

				arg_152_1.text_.text = var_155_5

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_7 = 23 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 23)

				if (23 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 23)) > 0 and var_155_3 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_5
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011037", "story_v_out_325011.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011037", "story_v_out_325011.awb") / 1000

					if var_155_8 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_2
					end

					if var_155_4.prefab_name ~= "" and arg_152_1.actors_[var_155_4.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_4.prefab_name].transform, "story_v_out_325011", "325011037", "story_v_out_325011.awb")

						arg_152_1:RecordAudio("325011037", var_155_9)
						arg_152_1:RecordAudio("325011037", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_325011", "325011037", "story_v_out_325011.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_325011", "325011037", "story_v_out_325011.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_10 and arg_152_1.time_ < var_155_2 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play325011038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325011038
		arg_156_1.duration_ = 7.3

		local var_156_0 = {
			zh = 6.566,
			ja = 7.3
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play325011039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1077ui_story"]) and arg_156_1.var_.characterEffect1077ui_story == nil then
				arg_156_1.var_.characterEffect1077ui_story = arg_156_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1077ui_story"]) then
				if arg_156_1.var_.characterEffect1077ui_story and not isNil(arg_156_1.actors_["1077ui_story"]) then
					arg_156_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1077ui_story"]) and arg_156_1.var_.characterEffect1077ui_story then
				arg_156_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_159_1 = 0
			local var_159_2 = 0.7

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1521].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_3 = arg_156_1:GetWordFromCfg(325011038)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_6 = 28 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_4) / 28)

				if (28 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_4) / 28)) > 0 and var_159_2 < var_159_6 then
					arg_156_1.talkMaxDuration = var_159_6

					if var_159_6 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_6 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011038", "story_v_out_325011.awb") ~= 0 then
					local var_159_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011038", "story_v_out_325011.awb") / 1000

					if var_159_7 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_1
					end

					if var_159_3.prefab_name ~= "" and arg_156_1.actors_[var_159_3.prefab_name] ~= nil then
						local var_159_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_3.prefab_name].transform, "story_v_out_325011", "325011038", "story_v_out_325011.awb")

						arg_156_1:RecordAudio("325011038", var_159_8)
						arg_156_1:RecordAudio("325011038", var_159_8)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_325011", "325011038", "story_v_out_325011.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_325011", "325011038", "story_v_out_325011.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_9 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_9 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_9

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_9 and arg_156_1.time_ < var_159_1 + var_159_9 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play325011039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 325011039
		arg_160_1.duration_ = 2

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play325011040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1077ui_story"]) and arg_160_1.var_.characterEffect1077ui_story == nil then
				arg_160_1.var_.characterEffect1077ui_story = arg_160_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1077ui_story"]) then
				if arg_160_1.var_.characterEffect1077ui_story and not isNil(arg_160_1.actors_["1077ui_story"]) then
					arg_160_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1077ui_story"]) and arg_160_1.var_.characterEffect1077ui_story then
				arg_160_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_163_2 = 0
			local var_163_3 = 0.125

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_4 = arg_160_1:GetWordFromCfg(325011039)
				local var_163_5 = arg_160_1:FormatText(var_163_4.content)

				arg_160_1.text_.text = var_163_5

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 5 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 5)

				if (5 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 5)) > 0 and var_163_3 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_2
					end
				end

				arg_160_1.text_.text = var_163_5
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011039", "story_v_out_325011.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011039", "story_v_out_325011.awb") / 1000

					if var_163_8 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_2
					end

					if var_163_4.prefab_name ~= "" and arg_160_1.actors_[var_163_4.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_4.prefab_name].transform, "story_v_out_325011", "325011039", "story_v_out_325011.awb")

						arg_160_1:RecordAudio("325011039", var_163_9)
						arg_160_1:RecordAudio("325011039", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_325011", "325011039", "story_v_out_325011.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_325011", "325011039", "story_v_out_325011.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_3, arg_160_1.talkMaxDuration)

			if var_163_2 <= arg_160_1.time_ and arg_160_1.time_ < var_163_2 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_2) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_2 + var_163_10 and arg_160_1.time_ < var_163_2 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play325011040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 325011040
		arg_164_1.duration_ = 3.4

		local var_164_0 = {
			zh = 1.2,
			ja = 3.4
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play325011041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1077ui_story"]) and arg_164_1.var_.characterEffect1077ui_story == nil then
				arg_164_1.var_.characterEffect1077ui_story = arg_164_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1077ui_story"]) then
				if arg_164_1.var_.characterEffect1077ui_story and not isNil(arg_164_1.actors_["1077ui_story"]) then
					arg_164_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_0)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1077ui_story"]) and arg_164_1.var_.characterEffect1077ui_story then
				arg_164_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_167_1 = 0
			local var_167_2 = 0.175

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1521].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_3 = arg_164_1:GetWordFromCfg(325011040)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_6 = 7 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_4) / 7)

				if (7 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_4) / 7)) > 0 and var_167_2 < var_167_6 then
					arg_164_1.talkMaxDuration = var_167_6

					if var_167_6 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_6 + var_167_1
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011040", "story_v_out_325011.awb") ~= 0 then
					local var_167_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011040", "story_v_out_325011.awb") / 1000

					if var_167_7 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_1
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_out_325011", "325011040", "story_v_out_325011.awb")

						arg_164_1:RecordAudio("325011040", var_167_8)
						arg_164_1:RecordAudio("325011040", var_167_8)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_325011", "325011040", "story_v_out_325011.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_325011", "325011040", "story_v_out_325011.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_9 = math.max(var_167_2, arg_164_1.talkMaxDuration)

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_9 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_1) / var_167_9

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_1 + var_167_9 and arg_164_1.time_ < var_167_1 + var_167_9 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play325011041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 325011041
		arg_168_1.duration_ = 4.43

		local var_168_0 = {
			zh = 2.733,
			ja = 4.433
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play325011042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["1077ui_story"]) and arg_168_1.var_.characterEffect1077ui_story == nil then
				arg_168_1.var_.characterEffect1077ui_story = arg_168_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["1077ui_story"]) then
				if arg_168_1.var_.characterEffect1077ui_story and not isNil(arg_168_1.actors_["1077ui_story"]) then
					arg_168_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1077ui_story"]) and arg_168_1.var_.characterEffect1077ui_story then
				arg_168_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_171_2 = 0
			local var_171_3 = 0.3

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_2 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_4 = arg_168_1:GetWordFromCfg(325011041)
				local var_171_5 = arg_168_1:FormatText(var_171_4.content)

				arg_168_1.text_.text = var_171_5

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_7 = 12 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 12)

				if (12 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 12)) > 0 and var_171_3 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_2
					end
				end

				arg_168_1.text_.text = var_171_5
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011041", "story_v_out_325011.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011041", "story_v_out_325011.awb") / 1000

					if var_171_8 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_2
					end

					if var_171_4.prefab_name ~= "" and arg_168_1.actors_[var_171_4.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_4.prefab_name].transform, "story_v_out_325011", "325011041", "story_v_out_325011.awb")

						arg_168_1:RecordAudio("325011041", var_171_9)
						arg_168_1:RecordAudio("325011041", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_325011", "325011041", "story_v_out_325011.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_325011", "325011041", "story_v_out_325011.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_3, arg_168_1.talkMaxDuration)

			if var_171_2 <= arg_168_1.time_ and arg_168_1.time_ < var_171_2 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_2) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_2 + var_171_10 and arg_168_1.time_ < var_171_2 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play325011042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 325011042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play325011043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1077ui_story"]) and arg_172_1.var_.characterEffect1077ui_story == nil then
				arg_172_1.var_.characterEffect1077ui_story = arg_172_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1077ui_story"]) then
				if arg_172_1.var_.characterEffect1077ui_story and not isNil(arg_172_1.actors_["1077ui_story"]) then
					arg_172_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1077ui_story"]) and arg_172_1.var_.characterEffect1077ui_story then
				arg_172_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_175_1 = arg_172_1.actors_["1077ui_story"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1077ui_story = var_175_1.localPosition

				local var_175_2 = GameObjectTools.GetOrAddComponent(var_175_1.gameObject, typeof(DynamicBoneHelper))

				if var_175_2 then
					var_175_2:EnableDynamicBone(false)
				end
			end

			local var_175_3 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_3 then
				var_175_1.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_172_1.time_ - 0) / var_175_3)
				var_175_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_1.position).x, (manager.ui.mainCamera.transform.position - var_175_1.position).y, (manager.ui.mainCamera.transform.position - var_175_1.position).z)
				var_175_1.localEulerAngles.z = 0
				var_175_1.localEulerAngles.x = 0
				var_175_1.localEulerAngles = var_175_1.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_3 and arg_172_1.time_ < 0 + var_175_3 + arg_175_0 then
				var_175_1.localPosition = Vector3.New(0, 100, 0)
				var_175_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_1.position).x, (manager.ui.mainCamera.transform.position - var_175_1.position).y, (manager.ui.mainCamera.transform.position - var_175_1.position).z)
				var_175_1.localEulerAngles.z = 0
				var_175_1.localEulerAngles.x = 0
				var_175_1.localEulerAngles = var_175_1.localEulerAngles

				local var_175_4 = GameObjectTools.GetOrAddComponent(var_175_1.gameObject, typeof(DynamicBoneHelper))

				if var_175_4 then
					var_175_4:EnableDynamicBone(true)
				end
			end

			local var_175_5 = 0
			local var_175_6 = 1.45

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_7 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(325011042).content)

				arg_172_1.text_.text = var_175_7

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_9 = 58 <= 0 and var_175_6 or var_175_6 * (utf8.len(var_175_7) / 58)

				if (58 <= 0 and var_175_6 or var_175_6 * (utf8.len(var_175_7) / 58)) > 0 and var_175_6 < var_175_9 then
					arg_172_1.talkMaxDuration = var_175_9

					if var_175_9 + var_175_5 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_9 + var_175_5
					end
				end

				arg_172_1.text_.text = var_175_7
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_10 = math.max(var_175_6, arg_172_1.talkMaxDuration)

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_10 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_5) / var_175_10

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_5 + var_175_10 and arg_172_1.time_ < var_175_5 + var_175_10 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play325011043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 325011043
		arg_176_1.duration_ = 8.1

		local var_176_0 = {
			zh = 7.6,
			ja = 8.1
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play325011044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1077ui_story"]) and arg_176_1.var_.characterEffect1077ui_story == nil then
				arg_176_1.var_.characterEffect1077ui_story = arg_176_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1077ui_story"]) then
				if arg_176_1.var_.characterEffect1077ui_story and not isNil(arg_176_1.actors_["1077ui_story"]) then
					arg_176_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1077ui_story"]) and arg_176_1.var_.characterEffect1077ui_story then
				arg_176_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_179_2 = arg_176_1.actors_["1077ui_story"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1077ui_story = var_179_2.localPosition

				local var_179_3 = GameObjectTools.GetOrAddComponent(var_179_2.gameObject, typeof(DynamicBoneHelper))

				if var_179_3 then
					var_179_3:EnableDynamicBone(false)
				end
			end

			local var_179_4 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				var_179_2.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_176_1.time_ - 0) / var_179_4)
				var_179_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_2.position).x, (manager.ui.mainCamera.transform.position - var_179_2.position).y, (manager.ui.mainCamera.transform.position - var_179_2.position).z)
				var_179_2.localEulerAngles.z = 0
				var_179_2.localEulerAngles.x = 0
				var_179_2.localEulerAngles = var_179_2.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				var_179_2.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_179_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_2.position).x, (manager.ui.mainCamera.transform.position - var_179_2.position).y, (manager.ui.mainCamera.transform.position - var_179_2.position).z)
				var_179_2.localEulerAngles.z = 0
				var_179_2.localEulerAngles.x = 0
				var_179_2.localEulerAngles = var_179_2.localEulerAngles

				local var_179_5 = GameObjectTools.GetOrAddComponent(var_179_2.gameObject, typeof(DynamicBoneHelper))

				if var_179_5 then
					var_179_5:EnableDynamicBone(true)
				end
			end

			local var_179_6 = 0
			local var_179_7 = 0.85

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_8 = arg_176_1:GetWordFromCfg(325011043)
				local var_179_9 = arg_176_1:FormatText(var_179_8.content)

				arg_176_1.text_.text = var_179_9

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_11 = 34 <= 0 and var_179_7 or var_179_7 * (utf8.len(var_179_9) / 34)

				if (34 <= 0 and var_179_7 or var_179_7 * (utf8.len(var_179_9) / 34)) > 0 and var_179_7 < var_179_11 then
					arg_176_1.talkMaxDuration = var_179_11

					if var_179_11 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_11 + var_179_6
					end
				end

				arg_176_1.text_.text = var_179_9
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011043", "story_v_out_325011.awb") ~= 0 then
					local var_179_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011043", "story_v_out_325011.awb") / 1000

					if var_179_12 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_12 + var_179_6
					end

					if var_179_8.prefab_name ~= "" and arg_176_1.actors_[var_179_8.prefab_name] ~= nil then
						local var_179_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_8.prefab_name].transform, "story_v_out_325011", "325011043", "story_v_out_325011.awb")

						arg_176_1:RecordAudio("325011043", var_179_13)
						arg_176_1:RecordAudio("325011043", var_179_13)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_325011", "325011043", "story_v_out_325011.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_325011", "325011043", "story_v_out_325011.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_14 = math.max(var_179_7, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_14 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_6) / var_179_14

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_14 and arg_176_1.time_ < var_179_6 + var_179_14 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play325011044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 325011044
		arg_180_1.duration_ = 7.23

		local var_180_0 = {
			zh = 3.166,
			ja = 7.233
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play325011045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["1077ui_story"]) and arg_180_1.var_.characterEffect1077ui_story == nil then
				arg_180_1.var_.characterEffect1077ui_story = arg_180_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["1077ui_story"]) then
				if arg_180_1.var_.characterEffect1077ui_story and not isNil(arg_180_1.actors_["1077ui_story"]) then
					arg_180_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_0)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["1077ui_story"]) and arg_180_1.var_.characterEffect1077ui_story then
				arg_180_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_183_1 = 0
			local var_183_2 = 0.3

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1521].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_3 = arg_180_1:GetWordFromCfg(325011044)
				local var_183_4 = arg_180_1:FormatText(var_183_3.content)

				arg_180_1.text_.text = var_183_4

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_6 = 12 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_4) / 12)

				if (12 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_4) / 12)) > 0 and var_183_2 < var_183_6 then
					arg_180_1.talkMaxDuration = var_183_6

					if var_183_6 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_6 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_4
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011044", "story_v_out_325011.awb") ~= 0 then
					local var_183_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011044", "story_v_out_325011.awb") / 1000

					if var_183_7 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_1
					end

					if var_183_3.prefab_name ~= "" and arg_180_1.actors_[var_183_3.prefab_name] ~= nil then
						local var_183_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_3.prefab_name].transform, "story_v_out_325011", "325011044", "story_v_out_325011.awb")

						arg_180_1:RecordAudio("325011044", var_183_8)
						arg_180_1:RecordAudio("325011044", var_183_8)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_325011", "325011044", "story_v_out_325011.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_325011", "325011044", "story_v_out_325011.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_9 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_9 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_9

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_9 and arg_180_1.time_ < var_183_1 + var_183_9 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play325011045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 325011045
		arg_184_1.duration_ = 2.23

		local var_184_0 = {
			zh = 1.999999999999,
			ja = 2.233
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play325011046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1077ui_story"]) and arg_184_1.var_.characterEffect1077ui_story == nil then
				arg_184_1.var_.characterEffect1077ui_story = arg_184_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1077ui_story"]) then
				if arg_184_1.var_.characterEffect1077ui_story and not isNil(arg_184_1.actors_["1077ui_story"]) then
					arg_184_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1077ui_story"]) and arg_184_1.var_.characterEffect1077ui_story then
				arg_184_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_1")
			end

			local var_187_2 = 0
			local var_187_3 = 0.1

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:GetWordFromCfg(325011045)
				local var_187_5 = arg_184_1:FormatText(var_187_4.content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 4 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 4)

				if (4 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 4)) > 0 and var_187_3 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011045", "story_v_out_325011.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011045", "story_v_out_325011.awb") / 1000

					if var_187_8 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_2
					end

					if var_187_4.prefab_name ~= "" and arg_184_1.actors_[var_187_4.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_4.prefab_name].transform, "story_v_out_325011", "325011045", "story_v_out_325011.awb")

						arg_184_1:RecordAudio("325011045", var_187_9)
						arg_184_1:RecordAudio("325011045", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_325011", "325011045", "story_v_out_325011.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_325011", "325011045", "story_v_out_325011.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_10 and arg_184_1.time_ < var_187_2 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play325011046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 325011046
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play325011047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1077ui_story"]) and arg_188_1.var_.characterEffect1077ui_story == nil then
				arg_188_1.var_.characterEffect1077ui_story = arg_188_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1077ui_story"]) then
				if arg_188_1.var_.characterEffect1077ui_story and not isNil(arg_188_1.actors_["1077ui_story"]) then
					arg_188_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_0)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1077ui_story"]) and arg_188_1.var_.characterEffect1077ui_story then
				arg_188_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_191_1 = 0
			local var_191_2 = 0.95

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_3 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(325011046).content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 38 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 38)

				if (38 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 38)) > 0 and var_191_2 < var_191_5 then
					arg_188_1.talkMaxDuration = var_191_5

					if var_191_5 + var_191_1 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + var_191_1
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_6 = math.max(var_191_2, arg_188_1.talkMaxDuration)

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_6 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_1) / var_191_6

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_1 + var_191_6 and arg_188_1.time_ < var_191_1 + var_191_6 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play325011047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 325011047
		arg_192_1.duration_ = 10.77

		local var_192_0 = {
			zh = 3.5,
			ja = 10.766
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play325011048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.425

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1521].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_1 = arg_192_1:GetWordFromCfg(325011047)
				local var_195_2 = arg_192_1:FormatText(var_195_1.content)

				arg_192_1.text_.text = var_195_2

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_4 = 17 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 17)

				if (17 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 17)) > 0 and var_195_0 < var_195_4 then
					arg_192_1.talkMaxDuration = var_195_4

					if var_195_4 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_4 + 0
					end
				end

				arg_192_1.text_.text = var_195_2
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011047", "story_v_out_325011.awb") ~= 0 then
					local var_195_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011047", "story_v_out_325011.awb") / 1000

					if var_195_5 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + 0
					end

					if var_195_1.prefab_name ~= "" and arg_192_1.actors_[var_195_1.prefab_name] ~= nil then
						local var_195_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_1.prefab_name].transform, "story_v_out_325011", "325011047", "story_v_out_325011.awb")

						arg_192_1:RecordAudio("325011047", var_195_6)
						arg_192_1:RecordAudio("325011047", var_195_6)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_325011", "325011047", "story_v_out_325011.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_325011", "325011047", "story_v_out_325011.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_7 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_7 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_7

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_7 and arg_192_1.time_ < 0 + var_195_7 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play325011048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 325011048
		arg_196_1.duration_ = 8.4

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play325011049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if arg_196_1.bgs_.ST13 == nil then
				local var_199_0 = Object.Instantiate(arg_196_1.paintGo_)

				var_199_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST13")
				var_199_0.name = "ST13"
				var_199_0.transform.parent = arg_196_1.stage_.transform
				var_199_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_196_1.bgs_.ST13 = var_199_0
			end

			if 1.8 < arg_196_1.time_ and arg_196_1.time_ <= 1.8 + arg_199_0 then
				local var_199_1 = arg_196_1.bgs_.ST13

				arg_196_1.bgs_.ST13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_199_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_199_2 = var_199_1:GetComponent("SpriteRenderer")

				if var_199_2 and var_199_2.sprite then
					local var_199_3 = 2 * (var_199_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_199_1.transform.localScale = Vector3.New(var_199_3 / var_199_2.sprite.bounds.size.y < var_199_3 * manager.ui.mainCameraCom_.aspect / var_199_2.sprite.bounds.size.x and var_199_3 * manager.ui.mainCameraCom_.aspect / var_199_2.sprite.bounds.size.x or var_199_3 / var_199_2.sprite.bounds.size.y, var_199_3 / var_199_2.sprite.bounds.size.y < var_199_3 * manager.ui.mainCameraCom_.aspect / var_199_2.sprite.bounds.size.x and var_199_3 * manager.ui.mainCameraCom_.aspect / var_199_2.sprite.bounds.size.x or var_199_3 / var_199_2.sprite.bounds.size.y, 0)
				end

				for iter_199_0, iter_199_1 in pairs(arg_196_1.bgs_) do
					if iter_199_0 ~= "ST13" then
						iter_199_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_199_4 = 1.8

			if 1.8 < arg_196_1.time_ and arg_196_1.time_ <= var_199_4 + arg_199_0 then
				arg_196_1.allBtn_.enabled = false
			end

			if arg_196_1.time_ >= var_199_4 + 0.3 and arg_196_1.time_ < var_199_4 + 0.3 + arg_199_0 then
				arg_196_1.allBtn_.enabled = true
			end

			local var_199_5 = 0

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 then
				arg_196_1.mask_.enabled = true
				arg_196_1.mask_.raycastTarget = true

				arg_196_1:SetGaussion(false)
			end

			local var_199_6 = 1.8

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_6 then
				local var_199_7 = Color.New(0, 0, 0)

				var_199_7.a = Mathf.Lerp(0, 1, (arg_196_1.time_ - var_199_5) / var_199_6)
				arg_196_1.mask_.color = var_199_7
			end

			if arg_196_1.time_ >= var_199_5 + var_199_6 and arg_196_1.time_ < var_199_5 + var_199_6 + arg_199_0 then
				local var_199_8 = Color.New(0, 0, 0)

				var_199_8.a = 1
				arg_196_1.mask_.color = var_199_8
			end

			local var_199_9 = 1.8

			if 1.8 < arg_196_1.time_ and arg_196_1.time_ <= var_199_9 + arg_199_0 then
				arg_196_1.mask_.enabled = true
				arg_196_1.mask_.raycastTarget = true

				arg_196_1:SetGaussion(false)
			end

			local var_199_10 = 2

			if var_199_9 <= arg_196_1.time_ and arg_196_1.time_ < var_199_9 + var_199_10 then
				local var_199_11 = Color.New(0, 0, 0)

				var_199_11.a = Mathf.Lerp(1, 0, (arg_196_1.time_ - var_199_9) / var_199_10)
				arg_196_1.mask_.color = var_199_11
			end

			if arg_196_1.time_ >= var_199_9 + var_199_10 and arg_196_1.time_ < var_199_9 + var_199_10 + arg_199_0 then
				local var_199_12 = Color.New(0, 0, 0)

				arg_196_1.mask_.enabled = false
				var_199_12.a = 0
				arg_196_1.mask_.color = var_199_12
			end

			local var_199_13 = arg_196_1.actors_["1077ui_story"].transform

			if 1.8 < arg_196_1.time_ and arg_196_1.time_ <= 1.8 + arg_199_0 then
				arg_196_1.var_.moveOldPos1077ui_story = var_199_13.localPosition

				local var_199_14 = GameObjectTools.GetOrAddComponent(var_199_13.gameObject, typeof(DynamicBoneHelper))

				if var_199_14 then
					var_199_14:EnableDynamicBone(false)
				end
			end

			local var_199_15 = 0.001

			if 1.8 <= arg_196_1.time_ and arg_196_1.time_ < 1.8 + var_199_15 then
				var_199_13.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_196_1.time_ - 1.8) / var_199_15)
				var_199_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_13.position).x, (manager.ui.mainCamera.transform.position - var_199_13.position).y, (manager.ui.mainCamera.transform.position - var_199_13.position).z)
				var_199_13.localEulerAngles.z = 0
				var_199_13.localEulerAngles.x = 0
				var_199_13.localEulerAngles = var_199_13.localEulerAngles
			end

			if arg_196_1.time_ >= 1.8 + var_199_15 and arg_196_1.time_ < 1.8 + var_199_15 + arg_199_0 then
				var_199_13.localPosition = Vector3.New(0, 100, 0)
				var_199_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_13.position).x, (manager.ui.mainCamera.transform.position - var_199_13.position).y, (manager.ui.mainCamera.transform.position - var_199_13.position).z)
				var_199_13.localEulerAngles.z = 0
				var_199_13.localEulerAngles.x = 0
				var_199_13.localEulerAngles = var_199_13.localEulerAngles

				local var_199_16 = GameObjectTools.GetOrAddComponent(var_199_13.gameObject, typeof(DynamicBoneHelper))

				if var_199_16 then
					var_199_16:EnableDynamicBone(true)
				end
			end

			if 1.2 < arg_196_1.time_ and arg_196_1.time_ <= 1.2 + arg_199_0 then
				arg_196_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 1.5 < arg_196_1.time_ and arg_196_1.time_ <= 1.5 + arg_199_0 then
				arg_196_1:AudioAction("play", "effect", "se_story_16", "se_story_16_door03", "")
			end

			if 0.1 < arg_196_1.time_ and arg_196_1.time_ <= 0.1 + arg_199_0 then
				arg_196_1:AudioAction("stop", "effect", "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			if 0.1 < arg_196_1.time_ and arg_196_1.time_ <= 0.1 + arg_199_0 then
				arg_196_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_town", "")
			end

			if arg_196_1.frameCnt_ <= 1 then
				arg_196_1.dialog_:SetActive(false)
			end

			local var_199_21 = 3.4
			local var_199_22 = 1.55

			if 3.4 < arg_196_1.time_ and arg_196_1.time_ <= var_199_21 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0

				arg_196_1.dialog_:SetActive(true)

				arg_196_1.dialogCg_.alpha = 0

				local var_199_23 = LeanTween.value(arg_196_1.dialog_, 0, 1, 0.3)

				var_199_23:setOnUpdate(LuaHelper.FloatAction(function(arg_200_0)
					arg_196_1.dialogCg_.alpha = arg_200_0
				end))
				var_199_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_196_1.dialog_)
					var_199_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_196_1.duration_ = arg_196_1.duration_ + 0.3

				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_24 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(325011048).content)

				arg_196_1.text_.text = var_199_24

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_26 = 62 <= 0 and var_199_22 or var_199_22 * (utf8.len(var_199_24) / 62)

				if (62 <= 0 and var_199_22 or var_199_22 * (utf8.len(var_199_24) / 62)) > 0 and var_199_22 < var_199_26 then
					arg_196_1.talkMaxDuration = var_199_26
					var_199_21 = var_199_21 + 0.3

					if var_199_26 + var_199_21 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_26 + var_199_21
					end
				end

				arg_196_1.text_.text = var_199_24
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_27 = var_199_21 + 0.3
			local var_199_28 = math.max(var_199_22, arg_196_1.talkMaxDuration)

			if var_199_21 + 0.3 <= arg_196_1.time_ and arg_196_1.time_ < var_199_27 + var_199_28 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_27) / var_199_28

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_27 + var_199_28 and arg_196_1.time_ < var_199_27 + var_199_28 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play325011049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 325011049
		arg_202_1.duration_ = 4.83

		local var_202_0 = {
			zh = 4.7,
			ja = 4.833
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play325011050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.4

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_1 = arg_202_1:GetWordFromCfg(325011049)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.text_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 16 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 16)

				if (16 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 16)) > 0 and var_205_0 < var_205_4 then
					arg_202_1.talkMaxDuration = var_205_4

					if var_205_4 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_4 + 0
					end
				end

				arg_202_1.text_.text = var_205_2
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011049", "story_v_out_325011.awb") ~= 0 then
					local var_205_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011049", "story_v_out_325011.awb") / 1000

					if var_205_5 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + 0
					end

					if var_205_1.prefab_name ~= "" and arg_202_1.actors_[var_205_1.prefab_name] ~= nil then
						local var_205_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_1.prefab_name].transform, "story_v_out_325011", "325011049", "story_v_out_325011.awb")

						arg_202_1:RecordAudio("325011049", var_205_6)
						arg_202_1:RecordAudio("325011049", var_205_6)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_325011", "325011049", "story_v_out_325011.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_325011", "325011049", "story_v_out_325011.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play325011050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 325011050
		arg_206_1.duration_ = 6.2

		local var_206_0 = {
			zh = 5.066,
			ja = 6.2
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play325011051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.4

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_1 = arg_206_1:GetWordFromCfg(325011050)
				local var_209_2 = arg_206_1:FormatText(var_209_1.content)

				arg_206_1.text_.text = var_209_2

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 16 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 16)

				if (16 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 16)) > 0 and var_209_0 < var_209_4 then
					arg_206_1.talkMaxDuration = var_209_4

					if var_209_4 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_4 + 0
					end
				end

				arg_206_1.text_.text = var_209_2
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011050", "story_v_out_325011.awb") ~= 0 then
					local var_209_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011050", "story_v_out_325011.awb") / 1000

					if var_209_5 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + 0
					end

					if var_209_1.prefab_name ~= "" and arg_206_1.actors_[var_209_1.prefab_name] ~= nil then
						local var_209_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_1.prefab_name].transform, "story_v_out_325011", "325011050", "story_v_out_325011.awb")

						arg_206_1:RecordAudio("325011050", var_209_6)
						arg_206_1:RecordAudio("325011050", var_209_6)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_325011", "325011050", "story_v_out_325011.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_325011", "325011050", "story_v_out_325011.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play325011051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 325011051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play325011052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 1.125

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_1 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(325011051).content)

				arg_210_1.text_.text = var_213_1

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_3 = 45 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 45)

				if (45 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 45)) > 0 and var_213_0 < var_213_3 then
					arg_210_1.talkMaxDuration = var_213_3

					if var_213_3 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_3 + 0
					end
				end

				arg_210_1.text_.text = var_213_1
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_4 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_4

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play325011052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 325011052
		arg_214_1.duration_ = 4.43

		local var_214_0 = {
			zh = 3.7,
			ja = 4.433
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play325011053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1077ui_story = arg_214_1.actors_["1077ui_story"].transform.localPosition

				local var_217_0 = GameObjectTools.GetOrAddComponent(arg_214_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_217_0 then
					var_217_0:EnableDynamicBone(false)
				end
			end

			local var_217_1 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_1 then
				arg_214_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_214_1.time_ - 0) / var_217_1)
				arg_214_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1077ui_story"].transform.position).z)
				arg_214_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1077ui_story"].transform.localEulerAngles = arg_214_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_1 and arg_214_1.time_ < 0 + var_217_1 + arg_217_0 then
				arg_214_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_214_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1077ui_story"].transform.position).z)
				arg_214_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1077ui_story"].transform.localEulerAngles = arg_214_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_217_2 = GameObjectTools.GetOrAddComponent(arg_214_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_217_2 then
					var_217_2:EnableDynamicBone(true)
				end
			end

			local var_217_3 = arg_214_1.actors_["1077ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_3) and arg_214_1.var_.characterEffect1077ui_story == nil then
				arg_214_1.var_.characterEffect1077ui_story = var_217_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_4 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 and not isNil(var_217_3) then
				if arg_214_1.var_.characterEffect1077ui_story and not isNil(var_217_3) then
					arg_214_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 and not isNil(var_217_3) and arg_214_1.var_.characterEffect1077ui_story then
				arg_214_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_217_6 = 0
			local var_217_7 = 0.55

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_8 = arg_214_1:GetWordFromCfg(325011052)
				local var_217_9 = arg_214_1:FormatText(var_217_8.content)

				arg_214_1.text_.text = var_217_9

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 22 <= 0 and var_217_7 or var_217_7 * (utf8.len(var_217_9) / 22)

				if (22 <= 0 and var_217_7 or var_217_7 * (utf8.len(var_217_9) / 22)) > 0 and var_217_7 < var_217_11 then
					arg_214_1.talkMaxDuration = var_217_11

					if var_217_11 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_11 + var_217_6
					end
				end

				arg_214_1.text_.text = var_217_9
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011052", "story_v_out_325011.awb") ~= 0 then
					local var_217_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011052", "story_v_out_325011.awb") / 1000

					if var_217_12 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_12 + var_217_6
					end

					if var_217_8.prefab_name ~= "" and arg_214_1.actors_[var_217_8.prefab_name] ~= nil then
						local var_217_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_8.prefab_name].transform, "story_v_out_325011", "325011052", "story_v_out_325011.awb")

						arg_214_1:RecordAudio("325011052", var_217_13)
						arg_214_1:RecordAudio("325011052", var_217_13)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_325011", "325011052", "story_v_out_325011.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_325011", "325011052", "story_v_out_325011.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_14 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_14 and arg_214_1.time_ < var_217_6 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play325011053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 325011053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play325011054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1077ui_story = arg_218_1.actors_["1077ui_story"].transform.localPosition

				local var_221_0 = GameObjectTools.GetOrAddComponent(arg_218_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_221_0 then
					var_221_0:EnableDynamicBone(false)
				end
			end

			local var_221_1 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_1 then
				arg_218_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_1)
				arg_218_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1077ui_story"].transform.position).z)
				arg_218_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1077ui_story"].transform.localEulerAngles = arg_218_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_1 and arg_218_1.time_ < 0 + var_221_1 + arg_221_0 then
				arg_218_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_218_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1077ui_story"].transform.position).z)
				arg_218_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1077ui_story"].transform.localEulerAngles = arg_218_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_221_2 = GameObjectTools.GetOrAddComponent(arg_218_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_221_2 then
					var_221_2:EnableDynamicBone(true)
				end
			end

			local var_221_3 = arg_218_1.actors_["1077ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_3) and arg_218_1.var_.characterEffect1077ui_story == nil then
				arg_218_1.var_.characterEffect1077ui_story = var_221_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_4 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 and not isNil(var_221_3) then
				if arg_218_1.var_.characterEffect1077ui_story and not isNil(var_221_3) then
					arg_218_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_4)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 and not isNil(var_221_3) and arg_218_1.var_.characterEffect1077ui_story then
				arg_218_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_218_1.time_ and arg_218_1.time_ <= 0.1 + arg_221_0 then
				arg_218_1:AudioAction("play", "effect", "se_story_side_1085", "se_story_side_1085_sit", "")
			end

			if 0.5 < arg_218_1.time_ and arg_218_1.time_ <= 0.5 + arg_221_0 then
				arg_218_1:AudioAction("play", "effect", "se_story_15", "se_story_15_ui", "")
			end

			local var_221_7 = 0
			local var_221_8 = 0.95

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_7 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_9 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(325011053).content)

				arg_218_1.text_.text = var_221_9

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_11 = 38 <= 0 and var_221_8 or var_221_8 * (utf8.len(var_221_9) / 38)

				if (38 <= 0 and var_221_8 or var_221_8 * (utf8.len(var_221_9) / 38)) > 0 and var_221_8 < var_221_11 then
					arg_218_1.talkMaxDuration = var_221_11

					if var_221_11 + var_221_7 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_11 + var_221_7
					end
				end

				arg_218_1.text_.text = var_221_9
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_8, arg_218_1.talkMaxDuration)

			if var_221_7 <= arg_218_1.time_ and arg_218_1.time_ < var_221_7 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_7) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_7 + var_221_12 and arg_218_1.time_ < var_221_7 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play325011054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 325011054
		arg_222_1.duration_ = 6.9

		local var_222_0 = {
			zh = 6.9,
			ja = 6.133
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play325011055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1077ui_story = arg_222_1.actors_["1077ui_story"].transform.localPosition

				local var_225_0 = GameObjectTools.GetOrAddComponent(arg_222_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_225_0 then
					var_225_0:EnableDynamicBone(false)
				end
			end

			local var_225_1 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_1 then
				arg_222_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_222_1.time_ - 0) / var_225_1)
				arg_222_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1077ui_story"].transform.position).z)
				arg_222_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1077ui_story"].transform.localEulerAngles = arg_222_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_1 and arg_222_1.time_ < 0 + var_225_1 + arg_225_0 then
				arg_222_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_222_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1077ui_story"].transform.position).z)
				arg_222_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1077ui_story"].transform.localEulerAngles = arg_222_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_225_2 = GameObjectTools.GetOrAddComponent(arg_222_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_225_2 then
					var_225_2:EnableDynamicBone(true)
				end
			end

			local var_225_3 = arg_222_1.actors_["1077ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_3) and arg_222_1.var_.characterEffect1077ui_story == nil then
				arg_222_1.var_.characterEffect1077ui_story = var_225_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_4 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 and not isNil(var_225_3) then
				if arg_222_1.var_.characterEffect1077ui_story and not isNil(var_225_3) then
					arg_222_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 and not isNil(var_225_3) and arg_222_1.var_.characterEffect1077ui_story then
				arg_222_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_225_6 = 0
			local var_225_7 = 0.8

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_8 = arg_222_1:GetWordFromCfg(325011054)
				local var_225_9 = arg_222_1:FormatText(var_225_8.content)

				arg_222_1.text_.text = var_225_9

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_11 = 32 <= 0 and var_225_7 or var_225_7 * (utf8.len(var_225_9) / 32)

				if (32 <= 0 and var_225_7 or var_225_7 * (utf8.len(var_225_9) / 32)) > 0 and var_225_7 < var_225_11 then
					arg_222_1.talkMaxDuration = var_225_11

					if var_225_11 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_11 + var_225_6
					end
				end

				arg_222_1.text_.text = var_225_9
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011054", "story_v_out_325011.awb") ~= 0 then
					local var_225_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011054", "story_v_out_325011.awb") / 1000

					if var_225_12 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_12 + var_225_6
					end

					if var_225_8.prefab_name ~= "" and arg_222_1.actors_[var_225_8.prefab_name] ~= nil then
						local var_225_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_8.prefab_name].transform, "story_v_out_325011", "325011054", "story_v_out_325011.awb")

						arg_222_1:RecordAudio("325011054", var_225_13)
						arg_222_1:RecordAudio("325011054", var_225_13)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_325011", "325011054", "story_v_out_325011.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_325011", "325011054", "story_v_out_325011.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_14 = math.max(var_225_7, arg_222_1.talkMaxDuration)

			if var_225_6 <= arg_222_1.time_ and arg_222_1.time_ < var_225_6 + var_225_14 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_6) / var_225_14

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_6 + var_225_14 and arg_222_1.time_ < var_225_6 + var_225_14 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play325011055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 325011055
		arg_226_1.duration_ = 10.33

		local var_226_0 = {
			zh = 10.333,
			ja = 8.633
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play325011056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 1.175

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_1 = arg_226_1:GetWordFromCfg(325011055)
				local var_229_2 = arg_226_1:FormatText(var_229_1.content)

				arg_226_1.text_.text = var_229_2

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_4 = 46 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 46)

				if (46 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 46)) > 0 and var_229_0 < var_229_4 then
					arg_226_1.talkMaxDuration = var_229_4

					if var_229_4 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_4 + 0
					end
				end

				arg_226_1.text_.text = var_229_2
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011055", "story_v_out_325011.awb") ~= 0 then
					local var_229_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011055", "story_v_out_325011.awb") / 1000

					if var_229_5 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + 0
					end

					if var_229_1.prefab_name ~= "" and arg_226_1.actors_[var_229_1.prefab_name] ~= nil then
						local var_229_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_1.prefab_name].transform, "story_v_out_325011", "325011055", "story_v_out_325011.awb")

						arg_226_1:RecordAudio("325011055", var_229_6)
						arg_226_1:RecordAudio("325011055", var_229_6)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_325011", "325011055", "story_v_out_325011.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_325011", "325011055", "story_v_out_325011.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_7 and arg_226_1.time_ < 0 + var_229_7 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play325011056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 325011056
		arg_230_1.duration_ = 6.23

		local var_230_0 = {
			zh = 3.933,
			ja = 6.233
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play325011057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.375

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:GetWordFromCfg(325011056)
				local var_233_2 = arg_230_1:FormatText(var_233_1.content)

				arg_230_1.text_.text = var_233_2

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 15 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 15)

				if (15 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 15)) > 0 and var_233_0 < var_233_4 then
					arg_230_1.talkMaxDuration = var_233_4

					if var_233_4 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_4 + 0
					end
				end

				arg_230_1.text_.text = var_233_2
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011056", "story_v_out_325011.awb") ~= 0 then
					local var_233_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011056", "story_v_out_325011.awb") / 1000

					if var_233_5 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + 0
					end

					if var_233_1.prefab_name ~= "" and arg_230_1.actors_[var_233_1.prefab_name] ~= nil then
						local var_233_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_1.prefab_name].transform, "story_v_out_325011", "325011056", "story_v_out_325011.awb")

						arg_230_1:RecordAudio("325011056", var_233_6)
						arg_230_1:RecordAudio("325011056", var_233_6)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_325011", "325011056", "story_v_out_325011.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_325011", "325011056", "story_v_out_325011.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play325011057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 325011057
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play325011058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1077ui_story = arg_234_1.actors_["1077ui_story"].transform.localPosition

				local var_237_0 = GameObjectTools.GetOrAddComponent(arg_234_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_237_0 then
					var_237_0:EnableDynamicBone(false)
				end
			end

			local var_237_1 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_1 then
				arg_234_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_234_1.time_ - 0) / var_237_1)
				arg_234_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1077ui_story"].transform.position).z)
				arg_234_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1077ui_story"].transform.localEulerAngles = arg_234_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_1 and arg_234_1.time_ < 0 + var_237_1 + arg_237_0 then
				arg_234_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1077ui_story"].transform.position).z)
				arg_234_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1077ui_story"].transform.localEulerAngles = arg_234_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_237_2 = GameObjectTools.GetOrAddComponent(arg_234_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_237_2 then
					var_237_2:EnableDynamicBone(true)
				end
			end

			local var_237_3 = arg_234_1.actors_["1077ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect1077ui_story == nil then
				arg_234_1.var_.characterEffect1077ui_story = var_237_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_4 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 and not isNil(var_237_3) then
				if arg_234_1.var_.characterEffect1077ui_story and not isNil(var_237_3) then
					arg_234_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_4)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect1077ui_story then
				arg_234_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_237_5 = 0
			local var_237_6 = 1.6

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_5 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_7 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(325011057).content)

				arg_234_1.text_.text = var_237_7

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_9 = 64 <= 0 and var_237_6 or var_237_6 * (utf8.len(var_237_7) / 64)

				if (64 <= 0 and var_237_6 or var_237_6 * (utf8.len(var_237_7) / 64)) > 0 and var_237_6 < var_237_9 then
					arg_234_1.talkMaxDuration = var_237_9

					if var_237_9 + var_237_5 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_5
					end
				end

				arg_234_1.text_.text = var_237_7
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_6, arg_234_1.talkMaxDuration)

			if var_237_5 <= arg_234_1.time_ and arg_234_1.time_ < var_237_5 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_5) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_5 + var_237_10 and arg_234_1.time_ < var_237_5 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play325011058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 325011058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play325011059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 1.5

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(325011058).content)

				arg_238_1.text_.text = var_241_1

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_3 = 60 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 60)

				if (60 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 60)) > 0 and var_241_0 < var_241_3 then
					arg_238_1.talkMaxDuration = var_241_3

					if var_241_3 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_3 + 0
					end
				end

				arg_238_1.text_.text = var_241_1
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_4 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_4

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play325011059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 325011059
		arg_242_1.duration_ = 4.07

		local var_242_0 = {
			zh = 4.066,
			ja = 2.4
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play325011060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1077ui_story = arg_242_1.actors_["1077ui_story"].transform.localPosition

				local var_245_0 = GameObjectTools.GetOrAddComponent(arg_242_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_245_0 then
					var_245_0:EnableDynamicBone(false)
				end
			end

			local var_245_1 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_1 then
				arg_242_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_242_1.time_ - 0) / var_245_1)
				arg_242_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1077ui_story"].transform.position).z)
				arg_242_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1077ui_story"].transform.localEulerAngles = arg_242_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_1 and arg_242_1.time_ < 0 + var_245_1 + arg_245_0 then
				arg_242_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_242_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1077ui_story"].transform.position).z)
				arg_242_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1077ui_story"].transform.localEulerAngles = arg_242_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_245_2 = GameObjectTools.GetOrAddComponent(arg_242_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_245_2 then
					var_245_2:EnableDynamicBone(true)
				end
			end

			local var_245_3 = arg_242_1.actors_["1077ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_3) and arg_242_1.var_.characterEffect1077ui_story == nil then
				arg_242_1.var_.characterEffect1077ui_story = var_245_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_4 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 and not isNil(var_245_3) then
				if arg_242_1.var_.characterEffect1077ui_story and not isNil(var_245_3) then
					arg_242_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 and not isNil(var_245_3) and arg_242_1.var_.characterEffect1077ui_story then
				arg_242_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_245_6 = 0
			local var_245_7 = 0.275

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_8 = arg_242_1:GetWordFromCfg(325011059)
				local var_245_9 = arg_242_1:FormatText(var_245_8.content)

				arg_242_1.text_.text = var_245_9

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_11 = 11 <= 0 and var_245_7 or var_245_7 * (utf8.len(var_245_9) / 11)

				if (11 <= 0 and var_245_7 or var_245_7 * (utf8.len(var_245_9) / 11)) > 0 and var_245_7 < var_245_11 then
					arg_242_1.talkMaxDuration = var_245_11

					if var_245_11 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_11 + var_245_6
					end
				end

				arg_242_1.text_.text = var_245_9
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011059", "story_v_out_325011.awb") ~= 0 then
					local var_245_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011059", "story_v_out_325011.awb") / 1000

					if var_245_12 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_12 + var_245_6
					end

					if var_245_8.prefab_name ~= "" and arg_242_1.actors_[var_245_8.prefab_name] ~= nil then
						local var_245_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_8.prefab_name].transform, "story_v_out_325011", "325011059", "story_v_out_325011.awb")

						arg_242_1:RecordAudio("325011059", var_245_13)
						arg_242_1:RecordAudio("325011059", var_245_13)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_325011", "325011059", "story_v_out_325011.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_325011", "325011059", "story_v_out_325011.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_14 = math.max(var_245_7, arg_242_1.talkMaxDuration)

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_14 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_6) / var_245_14

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_6 + var_245_14 and arg_242_1.time_ < var_245_6 + var_245_14 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play325011060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 325011060
		arg_246_1.duration_ = 6.33

		local var_246_0 = {
			zh = 5.633,
			ja = 6.333
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play325011061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.625

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:GetWordFromCfg(325011060)
				local var_249_2 = arg_246_1:FormatText(var_249_1.content)

				arg_246_1.text_.text = var_249_2

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 25 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 25)

				if (25 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 25)) > 0 and var_249_0 < var_249_4 then
					arg_246_1.talkMaxDuration = var_249_4

					if var_249_4 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_4 + 0
					end
				end

				arg_246_1.text_.text = var_249_2
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011060", "story_v_out_325011.awb") ~= 0 then
					local var_249_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011060", "story_v_out_325011.awb") / 1000

					if var_249_5 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + 0
					end

					if var_249_1.prefab_name ~= "" and arg_246_1.actors_[var_249_1.prefab_name] ~= nil then
						local var_249_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_1.prefab_name].transform, "story_v_out_325011", "325011060", "story_v_out_325011.awb")

						arg_246_1:RecordAudio("325011060", var_249_6)
						arg_246_1:RecordAudio("325011060", var_249_6)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_325011", "325011060", "story_v_out_325011.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_325011", "325011060", "story_v_out_325011.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play325011061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 325011061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play325011062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1077ui_story"]) and arg_250_1.var_.characterEffect1077ui_story == nil then
				arg_250_1.var_.characterEffect1077ui_story = arg_250_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1077ui_story"]) then
				if arg_250_1.var_.characterEffect1077ui_story and not isNil(arg_250_1.actors_["1077ui_story"]) then
					arg_250_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_0)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1077ui_story"]) and arg_250_1.var_.characterEffect1077ui_story then
				arg_250_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_253_1 = arg_250_1.actors_["1077ui_story"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1077ui_story = var_253_1.localPosition

				local var_253_2 = GameObjectTools.GetOrAddComponent(var_253_1.gameObject, typeof(DynamicBoneHelper))

				if var_253_2 then
					var_253_2:EnableDynamicBone(false)
				end
			end

			local var_253_3 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_3 then
				var_253_1.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 0) / var_253_3)
				var_253_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_1.position).x, (manager.ui.mainCamera.transform.position - var_253_1.position).y, (manager.ui.mainCamera.transform.position - var_253_1.position).z)
				var_253_1.localEulerAngles.z = 0
				var_253_1.localEulerAngles.x = 0
				var_253_1.localEulerAngles = var_253_1.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_3 and arg_250_1.time_ < 0 + var_253_3 + arg_253_0 then
				var_253_1.localPosition = Vector3.New(0, 100, 0)
				var_253_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_1.position).x, (manager.ui.mainCamera.transform.position - var_253_1.position).y, (manager.ui.mainCamera.transform.position - var_253_1.position).z)
				var_253_1.localEulerAngles.z = 0
				var_253_1.localEulerAngles.x = 0
				var_253_1.localEulerAngles = var_253_1.localEulerAngles

				local var_253_4 = GameObjectTools.GetOrAddComponent(var_253_1.gameObject, typeof(DynamicBoneHelper))

				if var_253_4 then
					var_253_4:EnableDynamicBone(true)
				end
			end

			local var_253_5 = 0
			local var_253_6 = 1.1

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_7 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(325011061).content)

				arg_250_1.text_.text = var_253_7

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_9 = 44 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_7) / 44)

				if (44 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_7) / 44)) > 0 and var_253_6 < var_253_9 then
					arg_250_1.talkMaxDuration = var_253_9

					if var_253_9 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_9 + var_253_5
					end
				end

				arg_250_1.text_.text = var_253_7
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_6, arg_250_1.talkMaxDuration)

			if var_253_5 <= arg_250_1.time_ and arg_250_1.time_ < var_253_5 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_5) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_5 + var_253_10 and arg_250_1.time_ < var_253_5 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play325011062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 325011062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play325011063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0.3 < arg_254_1.time_ and arg_254_1.time_ <= 0.3 + arg_257_0 then
				arg_254_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_foley_cloth", "")
			end

			local var_257_1 = 0
			local var_257_2 = 0.95

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_3 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(325011062).content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 38 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 38)

				if (38 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 38)) > 0 and var_257_2 < var_257_5 then
					arg_254_1.talkMaxDuration = var_257_5

					if var_257_5 + var_257_1 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + var_257_1
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_6 = math.max(var_257_2, arg_254_1.talkMaxDuration)

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_6 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_1) / var_257_6

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_1 + var_257_6 and arg_254_1.time_ < var_257_1 + var_257_6 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play325011063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 325011063
		arg_258_1.duration_ = 9.73

		local var_258_0 = {
			zh = 6.266,
			ja = 9.733
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play325011064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1077ui_story = arg_258_1.actors_["1077ui_story"].transform.localPosition

				local var_261_0 = GameObjectTools.GetOrAddComponent(arg_258_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_261_0 then
					var_261_0:EnableDynamicBone(false)
				end
			end

			local var_261_1 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_1 then
				arg_258_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_258_1.time_ - 0) / var_261_1)
				arg_258_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1077ui_story"].transform.position).z)
				arg_258_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1077ui_story"].transform.localEulerAngles = arg_258_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_1 and arg_258_1.time_ < 0 + var_261_1 + arg_261_0 then
				arg_258_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_258_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1077ui_story"].transform.position).z)
				arg_258_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1077ui_story"].transform.localEulerAngles = arg_258_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_261_2 = GameObjectTools.GetOrAddComponent(arg_258_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_261_2 then
					var_261_2:EnableDynamicBone(true)
				end
			end

			local var_261_3 = arg_258_1.actors_["1077ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_3) and arg_258_1.var_.characterEffect1077ui_story == nil then
				arg_258_1.var_.characterEffect1077ui_story = var_261_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_4 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 and not isNil(var_261_3) then
				if arg_258_1.var_.characterEffect1077ui_story and not isNil(var_261_3) then
					arg_258_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 and not isNil(var_261_3) and arg_258_1.var_.characterEffect1077ui_story then
				arg_258_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_261_6 = 0
			local var_261_7 = 0.6

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_6 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_8 = arg_258_1:GetWordFromCfg(325011063)
				local var_261_9 = arg_258_1:FormatText(var_261_8.content)

				arg_258_1.text_.text = var_261_9

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_11 = 24 <= 0 and var_261_7 or var_261_7 * (utf8.len(var_261_9) / 24)

				if (24 <= 0 and var_261_7 or var_261_7 * (utf8.len(var_261_9) / 24)) > 0 and var_261_7 < var_261_11 then
					arg_258_1.talkMaxDuration = var_261_11

					if var_261_11 + var_261_6 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_11 + var_261_6
					end
				end

				arg_258_1.text_.text = var_261_9
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011063", "story_v_out_325011.awb") ~= 0 then
					local var_261_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011063", "story_v_out_325011.awb") / 1000

					if var_261_12 + var_261_6 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_12 + var_261_6
					end

					if var_261_8.prefab_name ~= "" and arg_258_1.actors_[var_261_8.prefab_name] ~= nil then
						local var_261_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_8.prefab_name].transform, "story_v_out_325011", "325011063", "story_v_out_325011.awb")

						arg_258_1:RecordAudio("325011063", var_261_13)
						arg_258_1:RecordAudio("325011063", var_261_13)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_325011", "325011063", "story_v_out_325011.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_325011", "325011063", "story_v_out_325011.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_14 = math.max(var_261_7, arg_258_1.talkMaxDuration)

			if var_261_6 <= arg_258_1.time_ and arg_258_1.time_ < var_261_6 + var_261_14 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_6) / var_261_14

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_6 + var_261_14 and arg_258_1.time_ < var_261_6 + var_261_14 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play325011064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 325011064
		arg_262_1.duration_ = 6.27

		local var_262_0 = {
			zh = 4.566,
			ja = 6.266
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play325011065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			local var_265_0 = 0
			local var_265_1 = 0.625

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_2 = arg_262_1:GetWordFromCfg(325011064)
				local var_265_3 = arg_262_1:FormatText(var_265_2.content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 25 <= 0 and var_265_1 or var_265_1 * (utf8.len(var_265_3) / 25)

				if (25 <= 0 and var_265_1 or var_265_1 * (utf8.len(var_265_3) / 25)) > 0 and var_265_1 < var_265_5 then
					arg_262_1.talkMaxDuration = var_265_5

					if var_265_5 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011064", "story_v_out_325011.awb") ~= 0 then
					local var_265_6 = manager.audio:GetVoiceLength("story_v_out_325011", "325011064", "story_v_out_325011.awb") / 1000

					if var_265_6 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_6 + var_265_0
					end

					if var_265_2.prefab_name ~= "" and arg_262_1.actors_[var_265_2.prefab_name] ~= nil then
						local var_265_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_2.prefab_name].transform, "story_v_out_325011", "325011064", "story_v_out_325011.awb")

						arg_262_1:RecordAudio("325011064", var_265_7)
						arg_262_1:RecordAudio("325011064", var_265_7)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_325011", "325011064", "story_v_out_325011.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_325011", "325011064", "story_v_out_325011.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_8 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_8 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_8

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_8 and arg_262_1.time_ < var_265_0 + var_265_8 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play325011065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 325011065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play325011066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1077ui_story"]) and arg_266_1.var_.characterEffect1077ui_story == nil then
				arg_266_1.var_.characterEffect1077ui_story = arg_266_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1077ui_story"]) then
				if arg_266_1.var_.characterEffect1077ui_story and not isNil(arg_266_1.actors_["1077ui_story"]) then
					arg_266_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_0)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1077ui_story"]) and arg_266_1.var_.characterEffect1077ui_story then
				arg_266_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_269_1 = 0
			local var_269_2 = 0.15

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_3 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(325011065).content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 6 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 6)

				if (6 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 6)) > 0 and var_269_2 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_6 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_6 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_1) / var_269_6

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_1 + var_269_6 and arg_266_1.time_ < var_269_1 + var_269_6 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play325011066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 325011066
		arg_270_1.duration_ = 5.6

		local var_270_0 = {
			zh = 3.7,
			ja = 5.6
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play325011067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1077ui_story"]) and arg_270_1.var_.characterEffect1077ui_story == nil then
				arg_270_1.var_.characterEffect1077ui_story = arg_270_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1077ui_story"]) then
				if arg_270_1.var_.characterEffect1077ui_story and not isNil(arg_270_1.actors_["1077ui_story"]) then
					arg_270_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1077ui_story"]) and arg_270_1.var_.characterEffect1077ui_story then
				arg_270_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_273_2 = 0
			local var_273_3 = 0.475

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_2 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_4 = arg_270_1:GetWordFromCfg(325011066)
				local var_273_5 = arg_270_1:FormatText(var_273_4.content)

				arg_270_1.text_.text = var_273_5

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_7 = 19 <= 0 and var_273_3 or var_273_3 * (utf8.len(var_273_5) / 19)

				if (19 <= 0 and var_273_3 or var_273_3 * (utf8.len(var_273_5) / 19)) > 0 and var_273_3 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_2 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_2
					end
				end

				arg_270_1.text_.text = var_273_5
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011066", "story_v_out_325011.awb") ~= 0 then
					local var_273_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011066", "story_v_out_325011.awb") / 1000

					if var_273_8 + var_273_2 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_2
					end

					if var_273_4.prefab_name ~= "" and arg_270_1.actors_[var_273_4.prefab_name] ~= nil then
						local var_273_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_4.prefab_name].transform, "story_v_out_325011", "325011066", "story_v_out_325011.awb")

						arg_270_1:RecordAudio("325011066", var_273_9)
						arg_270_1:RecordAudio("325011066", var_273_9)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_325011", "325011066", "story_v_out_325011.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_325011", "325011066", "story_v_out_325011.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_10 = math.max(var_273_3, arg_270_1.talkMaxDuration)

			if var_273_2 <= arg_270_1.time_ and arg_270_1.time_ < var_273_2 + var_273_10 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_2) / var_273_10

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_2 + var_273_10 and arg_270_1.time_ < var_273_2 + var_273_10 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play325011067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 325011067
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play325011068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1077ui_story = arg_274_1.actors_["1077ui_story"].transform.localPosition

				local var_277_0 = GameObjectTools.GetOrAddComponent(arg_274_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_277_0 then
					var_277_0:EnableDynamicBone(false)
				end
			end

			local var_277_1 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_1 then
				arg_274_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0) / var_277_1)
				arg_274_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1077ui_story"].transform.position).z)
				arg_274_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1077ui_story"].transform.localEulerAngles = arg_274_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_1 and arg_274_1.time_ < 0 + var_277_1 + arg_277_0 then
				arg_274_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1077ui_story"].transform.position).z)
				arg_274_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1077ui_story"].transform.localEulerAngles = arg_274_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_277_2 = GameObjectTools.GetOrAddComponent(arg_274_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_277_2 then
					var_277_2:EnableDynamicBone(true)
				end
			end

			local var_277_3 = arg_274_1.actors_["1077ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_3) and arg_274_1.var_.characterEffect1077ui_story == nil then
				arg_274_1.var_.characterEffect1077ui_story = var_277_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_4 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 and not isNil(var_277_3) then
				if arg_274_1.var_.characterEffect1077ui_story and not isNil(var_277_3) then
					arg_274_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_4)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 and not isNil(var_277_3) and arg_274_1.var_.characterEffect1077ui_story then
				arg_274_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_277_5 = 0
			local var_277_6 = 0.2

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_5 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_7 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(325011067).content)

				arg_274_1.text_.text = var_277_7

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_9 = 8 <= 0 and var_277_6 or var_277_6 * (utf8.len(var_277_7) / 8)

				if (8 <= 0 and var_277_6 or var_277_6 * (utf8.len(var_277_7) / 8)) > 0 and var_277_6 < var_277_9 then
					arg_274_1.talkMaxDuration = var_277_9

					if var_277_9 + var_277_5 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_9 + var_277_5
					end
				end

				arg_274_1.text_.text = var_277_7
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_6, arg_274_1.talkMaxDuration)

			if var_277_5 <= arg_274_1.time_ and arg_274_1.time_ < var_277_5 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_5) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_5 + var_277_10 and arg_274_1.time_ < var_277_5 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play325011068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 325011068
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play325011069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1077ui_story = arg_278_1.actors_["1077ui_story"].transform.localPosition

				local var_281_0 = GameObjectTools.GetOrAddComponent(arg_278_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_281_0 then
					var_281_0:EnableDynamicBone(false)
				end
			end

			local var_281_1 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_1 then
				arg_278_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 0) / var_281_1)
				arg_278_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1077ui_story"].transform.position).z)
				arg_278_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1077ui_story"].transform.localEulerAngles = arg_278_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_1 and arg_278_1.time_ < 0 + var_281_1 + arg_281_0 then
				arg_278_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_278_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1077ui_story"].transform.position).z)
				arg_278_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1077ui_story"].transform.localEulerAngles = arg_278_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_281_2 = GameObjectTools.GetOrAddComponent(arg_278_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_281_2 then
					var_281_2:EnableDynamicBone(true)
				end
			end

			local var_281_3 = 0
			local var_281_4 = 0.9

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_3 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_5 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(325011068).content)

				arg_278_1.text_.text = var_281_5

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_7 = 36 <= 0 and var_281_4 or var_281_4 * (utf8.len(var_281_5) / 36)

				if (36 <= 0 and var_281_4 or var_281_4 * (utf8.len(var_281_5) / 36)) > 0 and var_281_4 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_3 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_3
					end
				end

				arg_278_1.text_.text = var_281_5
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_8 = math.max(var_281_4, arg_278_1.talkMaxDuration)

			if var_281_3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_3 + var_281_8 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_3) / var_281_8

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_3 + var_281_8 and arg_278_1.time_ < var_281_3 + var_281_8 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play325011069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 325011069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play325011070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.95

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_1 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(325011069).content)

				arg_282_1.text_.text = var_285_1

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_3 = 38 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 38)

				if (38 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 38)) > 0 and var_285_0 < var_285_3 then
					arg_282_1.talkMaxDuration = var_285_3

					if var_285_3 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_3 + 0
					end
				end

				arg_282_1.text_.text = var_285_1
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_4 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_4

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play325011070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 325011070
		arg_286_1.duration_ = 3.37

		local var_286_0 = {
			zh = 3.166,
			ja = 3.366
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play325011071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos1077ui_story = arg_286_1.actors_["1077ui_story"].transform.localPosition

				local var_289_0 = GameObjectTools.GetOrAddComponent(arg_286_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_289_0 then
					var_289_0:EnableDynamicBone(false)
				end
			end

			local var_289_1 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_1 then
				arg_286_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_286_1.time_ - 0) / var_289_1)
				arg_286_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1077ui_story"].transform.position).z)
				arg_286_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1077ui_story"].transform.localEulerAngles = arg_286_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_1 and arg_286_1.time_ < 0 + var_289_1 + arg_289_0 then
				arg_286_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_286_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1077ui_story"].transform.position).z)
				arg_286_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1077ui_story"].transform.localEulerAngles = arg_286_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_289_2 = GameObjectTools.GetOrAddComponent(arg_286_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_289_2 then
					var_289_2:EnableDynamicBone(true)
				end
			end

			local var_289_3 = arg_286_1.actors_["1077ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_3) and arg_286_1.var_.characterEffect1077ui_story == nil then
				arg_286_1.var_.characterEffect1077ui_story = var_289_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_4 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 and not isNil(var_289_3) then
				if arg_286_1.var_.characterEffect1077ui_story and not isNil(var_289_3) then
					arg_286_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 and not isNil(var_289_3) and arg_286_1.var_.characterEffect1077ui_story then
				arg_286_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_289_6 = 0
			local var_289_7 = 0.175

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_8 = arg_286_1:GetWordFromCfg(325011070)
				local var_289_9 = arg_286_1:FormatText(var_289_8.content)

				arg_286_1.text_.text = var_289_9

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_11 = 7 <= 0 and var_289_7 or var_289_7 * (utf8.len(var_289_9) / 7)

				if (7 <= 0 and var_289_7 or var_289_7 * (utf8.len(var_289_9) / 7)) > 0 and var_289_7 < var_289_11 then
					arg_286_1.talkMaxDuration = var_289_11

					if var_289_11 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_11 + var_289_6
					end
				end

				arg_286_1.text_.text = var_289_9
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011070", "story_v_out_325011.awb") ~= 0 then
					local var_289_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011070", "story_v_out_325011.awb") / 1000

					if var_289_12 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_12 + var_289_6
					end

					if var_289_8.prefab_name ~= "" and arg_286_1.actors_[var_289_8.prefab_name] ~= nil then
						local var_289_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_8.prefab_name].transform, "story_v_out_325011", "325011070", "story_v_out_325011.awb")

						arg_286_1:RecordAudio("325011070", var_289_13)
						arg_286_1:RecordAudio("325011070", var_289_13)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_325011", "325011070", "story_v_out_325011.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_325011", "325011070", "story_v_out_325011.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_14 = math.max(var_289_7, arg_286_1.talkMaxDuration)

			if var_289_6 <= arg_286_1.time_ and arg_286_1.time_ < var_289_6 + var_289_14 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_6) / var_289_14

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_6 + var_289_14 and arg_286_1.time_ < var_289_6 + var_289_14 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play325011071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 325011071
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play325011072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos1077ui_story = arg_290_1.actors_["1077ui_story"].transform.localPosition

				local var_293_0 = GameObjectTools.GetOrAddComponent(arg_290_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_293_0 then
					var_293_0:EnableDynamicBone(false)
				end
			end

			local var_293_1 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_1 then
				arg_290_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_290_1.time_ - 0) / var_293_1)
				arg_290_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1077ui_story"].transform.position).z)
				arg_290_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["1077ui_story"].transform.localEulerAngles = arg_290_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_290_1.time_ >= 0 + var_293_1 and arg_290_1.time_ < 0 + var_293_1 + arg_293_0 then
				arg_290_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_290_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1077ui_story"].transform.position).z)
				arg_290_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["1077ui_story"].transform.localEulerAngles = arg_290_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_293_2 = GameObjectTools.GetOrAddComponent(arg_290_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_293_2 then
					var_293_2:EnableDynamicBone(true)
				end
			end

			local var_293_3 = arg_290_1.actors_["1077ui_story"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_3) and arg_290_1.var_.characterEffect1077ui_story == nil then
				arg_290_1.var_.characterEffect1077ui_story = var_293_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_4 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 and not isNil(var_293_3) then
				if arg_290_1.var_.characterEffect1077ui_story and not isNil(var_293_3) then
					arg_290_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_4)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 and not isNil(var_293_3) and arg_290_1.var_.characterEffect1077ui_story then
				arg_290_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0.3 < arg_290_1.time_ and arg_290_1.time_ <= 0.3 + arg_293_0 then
				arg_290_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword11", "")
			end

			local var_293_6 = 0
			local var_293_7 = 1.075

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_6 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_8 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(325011071).content)

				arg_290_1.text_.text = var_293_8

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_10 = 43 <= 0 and var_293_7 or var_293_7 * (utf8.len(var_293_8) / 43)

				if (43 <= 0 and var_293_7 or var_293_7 * (utf8.len(var_293_8) / 43)) > 0 and var_293_7 < var_293_10 then
					arg_290_1.talkMaxDuration = var_293_10

					if var_293_10 + var_293_6 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_6
					end
				end

				arg_290_1.text_.text = var_293_8
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_11 = math.max(var_293_7, arg_290_1.talkMaxDuration)

			if var_293_6 <= arg_290_1.time_ and arg_290_1.time_ < var_293_6 + var_293_11 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_6) / var_293_11

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_6 + var_293_11 and arg_290_1.time_ < var_293_6 + var_293_11 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play325011072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 325011072
		arg_294_1.duration_ = 3.63

		local var_294_0 = {
			zh = 2,
			ja = 3.633
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play325011073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos1077ui_story = arg_294_1.actors_["1077ui_story"].transform.localPosition

				local var_297_0 = GameObjectTools.GetOrAddComponent(arg_294_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_297_0 then
					var_297_0:EnableDynamicBone(false)
				end
			end

			local var_297_1 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_1 then
				arg_294_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_294_1.time_ - 0) / var_297_1)
				arg_294_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1077ui_story"].transform.position).z)
				arg_294_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1077ui_story"].transform.localEulerAngles = arg_294_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_1 and arg_294_1.time_ < 0 + var_297_1 + arg_297_0 then
				arg_294_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_294_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1077ui_story"].transform.position).z)
				arg_294_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1077ui_story"].transform.localEulerAngles = arg_294_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_297_2 = GameObjectTools.GetOrAddComponent(arg_294_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_297_2 then
					var_297_2:EnableDynamicBone(true)
				end
			end

			local var_297_3 = arg_294_1.actors_["1077ui_story"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_3) and arg_294_1.var_.characterEffect1077ui_story == nil then
				arg_294_1.var_.characterEffect1077ui_story = var_297_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_4 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_4 and not isNil(var_297_3) then
				if arg_294_1.var_.characterEffect1077ui_story and not isNil(var_297_3) then
					arg_294_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= 0 + var_297_4 and arg_294_1.time_ < 0 + var_297_4 + arg_297_0 and not isNil(var_297_3) and arg_294_1.var_.characterEffect1077ui_story then
				arg_294_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_297_6 = 0
			local var_297_7 = 0.2

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_8 = arg_294_1:GetWordFromCfg(325011072)
				local var_297_9 = arg_294_1:FormatText(var_297_8.content)

				arg_294_1.text_.text = var_297_9

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_11 = 8 <= 0 and var_297_7 or var_297_7 * (utf8.len(var_297_9) / 8)

				if (8 <= 0 and var_297_7 or var_297_7 * (utf8.len(var_297_9) / 8)) > 0 and var_297_7 < var_297_11 then
					arg_294_1.talkMaxDuration = var_297_11

					if var_297_11 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_11 + var_297_6
					end
				end

				arg_294_1.text_.text = var_297_9
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011072", "story_v_out_325011.awb") ~= 0 then
					local var_297_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011072", "story_v_out_325011.awb") / 1000

					if var_297_12 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_12 + var_297_6
					end

					if var_297_8.prefab_name ~= "" and arg_294_1.actors_[var_297_8.prefab_name] ~= nil then
						local var_297_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_8.prefab_name].transform, "story_v_out_325011", "325011072", "story_v_out_325011.awb")

						arg_294_1:RecordAudio("325011072", var_297_13)
						arg_294_1:RecordAudio("325011072", var_297_13)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_325011", "325011072", "story_v_out_325011.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_325011", "325011072", "story_v_out_325011.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_14 = math.max(var_297_7, arg_294_1.talkMaxDuration)

			if var_297_6 <= arg_294_1.time_ and arg_294_1.time_ < var_297_6 + var_297_14 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_6) / var_297_14

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_6 + var_297_14 and arg_294_1.time_ < var_297_6 + var_297_14 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play325011073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 325011073
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play325011074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1077ui_story = arg_298_1.actors_["1077ui_story"].transform.localPosition

				local var_301_0 = GameObjectTools.GetOrAddComponent(arg_298_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_301_0 then
					var_301_0:EnableDynamicBone(false)
				end
			end

			local var_301_1 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_1 then
				arg_298_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_298_1.time_ - 0) / var_301_1)
				arg_298_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1077ui_story"].transform.position).z)
				arg_298_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["1077ui_story"].transform.localEulerAngles = arg_298_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_1 and arg_298_1.time_ < 0 + var_301_1 + arg_301_0 then
				arg_298_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_298_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1077ui_story"].transform.position).z)
				arg_298_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["1077ui_story"].transform.localEulerAngles = arg_298_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_301_2 = GameObjectTools.GetOrAddComponent(arg_298_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_301_2 then
					var_301_2:EnableDynamicBone(true)
				end
			end

			local var_301_3 = arg_298_1.actors_["1077ui_story"]

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(var_301_3) and arg_298_1.var_.characterEffect1077ui_story == nil then
				arg_298_1.var_.characterEffect1077ui_story = var_301_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_4 = 0.200000002980232

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 and not isNil(var_301_3) then
				if arg_298_1.var_.characterEffect1077ui_story and not isNil(var_301_3) then
					arg_298_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_298_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_298_1.time_ - 0) / var_301_4)
				end
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 and not isNil(var_301_3) and arg_298_1.var_.characterEffect1077ui_story then
				arg_298_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_298_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_301_5 = 0
			local var_301_6 = 0.775

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_5 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_7 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(325011073).content)

				arg_298_1.text_.text = var_301_7

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_9 = 31 <= 0 and var_301_6 or var_301_6 * (utf8.len(var_301_7) / 31)

				if (31 <= 0 and var_301_6 or var_301_6 * (utf8.len(var_301_7) / 31)) > 0 and var_301_6 < var_301_9 then
					arg_298_1.talkMaxDuration = var_301_9

					if var_301_9 + var_301_5 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_9 + var_301_5
					end
				end

				arg_298_1.text_.text = var_301_7
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_10 = math.max(var_301_6, arg_298_1.talkMaxDuration)

			if var_301_5 <= arg_298_1.time_ and arg_298_1.time_ < var_301_5 + var_301_10 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_5) / var_301_10

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_5 + var_301_10 and arg_298_1.time_ < var_301_5 + var_301_10 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play325011074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 325011074
		arg_302_1.duration_ = 6

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play325011075(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPosST13 = arg_302_1.bgs_.ST13.transform.localPosition
			end

			local var_305_0 = 1.53333333333333

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 then
				arg_302_1.bgs_.ST13.transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPosST13, Vector3.New(0, 1, 8), (arg_302_1.time_ - 0) / var_305_0)
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 then
				arg_302_1.bgs_.ST13.transform.localPosition = Vector3.New(0, 1, 8)
			end

			local var_305_1 = 0

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.allBtn_.enabled = false
			end

			if arg_302_1.time_ >= var_305_1 + 1.93333333333333 and arg_302_1.time_ < var_305_1 + 1.93333333333333 + arg_305_0 then
				arg_302_1.allBtn_.enabled = true
			end

			if 0.3 < arg_302_1.time_ and arg_302_1.time_ <= 0.3 + arg_305_0 then
				arg_302_1:AudioAction("play", "effect", "se_story_16", "se_story_16_door03", "")
			end

			if arg_302_1.frameCnt_ <= 1 then
				arg_302_1.dialog_:SetActive(false)
			end

			local var_305_3 = 1
			local var_305_4 = 1.225

			if 1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_3 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0

				arg_302_1.dialog_:SetActive(true)

				arg_302_1.dialogCg_.alpha = 0

				local var_305_5 = LeanTween.value(arg_302_1.dialog_, 0, 1, 0.3)

				var_305_5:setOnUpdate(LuaHelper.FloatAction(function(arg_306_0)
					arg_302_1.dialogCg_.alpha = arg_306_0
				end))
				var_305_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_302_1.dialog_)
					var_305_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_302_1.duration_ = arg_302_1.duration_ + 0.3

				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_6 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(325011074).content)

				arg_302_1.text_.text = var_305_6

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_8 = 49 <= 0 and var_305_4 or var_305_4 * (utf8.len(var_305_6) / 49)

				if (49 <= 0 and var_305_4 or var_305_4 * (utf8.len(var_305_6) / 49)) > 0 and var_305_4 < var_305_8 then
					arg_302_1.talkMaxDuration = var_305_8
					var_305_3 = var_305_3 + 0.3

					if var_305_8 + var_305_3 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_8 + var_305_3
					end
				end

				arg_302_1.text_.text = var_305_6
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_9 = var_305_3 + 0.3
			local var_305_10 = math.max(var_305_4, arg_302_1.talkMaxDuration)

			if var_305_3 + 0.3 <= arg_302_1.time_ and arg_302_1.time_ < var_305_9 + var_305_10 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_9) / var_305_10

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_9 + var_305_10 and arg_302_1.time_ < var_305_9 + var_305_10 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST13",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.53333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 8),
					easeType = LeanTweenType.easeInOutSine
				}
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play325011075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 325011075
		arg_308_1.duration_ = 3.1

		local var_308_0 = {
			zh = 2.1,
			ja = 3.1
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play325011076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1077ui_story = arg_308_1.actors_["1077ui_story"].transform.localPosition

				local var_311_0 = GameObjectTools.GetOrAddComponent(arg_308_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_311_0 then
					var_311_0:EnableDynamicBone(false)
				end
			end

			local var_311_1 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_1 then
				arg_308_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_1)
				arg_308_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1077ui_story"].transform.position).z)
				arg_308_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1077ui_story"].transform.localEulerAngles = arg_308_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_1 and arg_308_1.time_ < 0 + var_311_1 + arg_311_0 then
				arg_308_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_308_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1077ui_story"].transform.position).z)
				arg_308_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1077ui_story"].transform.localEulerAngles = arg_308_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_311_2 = GameObjectTools.GetOrAddComponent(arg_308_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_311_2 then
					var_311_2:EnableDynamicBone(true)
				end
			end

			local var_311_3 = arg_308_1.actors_["1077ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_3) and arg_308_1.var_.characterEffect1077ui_story == nil then
				arg_308_1.var_.characterEffect1077ui_story = var_311_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_4 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 and not isNil(var_311_3) then
				if arg_308_1.var_.characterEffect1077ui_story and not isNil(var_311_3) then
					arg_308_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 and not isNil(var_311_3) and arg_308_1.var_.characterEffect1077ui_story then
				arg_308_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_311_6 = 0
			local var_311_7 = 0.125

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_6 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_8 = arg_308_1:GetWordFromCfg(325011075)
				local var_311_9 = arg_308_1:FormatText(var_311_8.content)

				arg_308_1.text_.text = var_311_9

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_11 = 5 <= 0 and var_311_7 or var_311_7 * (utf8.len(var_311_9) / 5)

				if (5 <= 0 and var_311_7 or var_311_7 * (utf8.len(var_311_9) / 5)) > 0 and var_311_7 < var_311_11 then
					arg_308_1.talkMaxDuration = var_311_11

					if var_311_11 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_11 + var_311_6
					end
				end

				arg_308_1.text_.text = var_311_9
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011075", "story_v_out_325011.awb") ~= 0 then
					local var_311_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011075", "story_v_out_325011.awb") / 1000

					if var_311_12 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_12 + var_311_6
					end

					if var_311_8.prefab_name ~= "" and arg_308_1.actors_[var_311_8.prefab_name] ~= nil then
						local var_311_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_8.prefab_name].transform, "story_v_out_325011", "325011075", "story_v_out_325011.awb")

						arg_308_1:RecordAudio("325011075", var_311_13)
						arg_308_1:RecordAudio("325011075", var_311_13)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_325011", "325011075", "story_v_out_325011.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_325011", "325011075", "story_v_out_325011.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_14 = math.max(var_311_7, arg_308_1.talkMaxDuration)

			if var_311_6 <= arg_308_1.time_ and arg_308_1.time_ < var_311_6 + var_311_14 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_6) / var_311_14

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_6 + var_311_14 and arg_308_1.time_ < var_311_6 + var_311_14 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play325011076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 325011076
		arg_312_1.duration_ = 8.03

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play325011077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 1.66666666666667 < arg_312_1.time_ and arg_312_1.time_ <= 1.66666666666667 + arg_315_0 then
				local var_315_0 = arg_312_1.bgs_.ST2015

				arg_312_1.bgs_.ST2015.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_315_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_315_1 = var_315_0:GetComponent("SpriteRenderer")

				if var_315_1 and var_315_1.sprite then
					local var_315_2 = 2 * (var_315_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_315_0.transform.localScale = Vector3.New(var_315_2 / var_315_1.sprite.bounds.size.y < var_315_2 * manager.ui.mainCameraCom_.aspect / var_315_1.sprite.bounds.size.x and var_315_2 * manager.ui.mainCameraCom_.aspect / var_315_1.sprite.bounds.size.x or var_315_2 / var_315_1.sprite.bounds.size.y, var_315_2 / var_315_1.sprite.bounds.size.y < var_315_2 * manager.ui.mainCameraCom_.aspect / var_315_1.sprite.bounds.size.x and var_315_2 * manager.ui.mainCameraCom_.aspect / var_315_1.sprite.bounds.size.x or var_315_2 / var_315_1.sprite.bounds.size.y, 0)
				end

				for iter_315_0, iter_315_1 in pairs(arg_312_1.bgs_) do
					if iter_315_0 ~= "ST2015" then
						iter_315_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_315_3 = 1.66666666666667

			if 1.66666666666667 < arg_312_1.time_ and arg_312_1.time_ <= var_315_3 + arg_315_0 then
				arg_312_1.allBtn_.enabled = false
			end

			if arg_312_1.time_ >= var_315_3 + 0.3 and arg_312_1.time_ < var_315_3 + 0.3 + arg_315_0 then
				arg_312_1.allBtn_.enabled = true
			end

			local var_315_4 = 0

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_5 = 1.66666666666667

			if var_315_4 <= arg_312_1.time_ and arg_312_1.time_ < var_315_4 + var_315_5 then
				local var_315_6 = Color.New(0, 0, 0)

				var_315_6.a = Mathf.Lerp(0, 1, (arg_312_1.time_ - var_315_4) / var_315_5)
				arg_312_1.mask_.color = var_315_6
			end

			if arg_312_1.time_ >= var_315_4 + var_315_5 and arg_312_1.time_ < var_315_4 + var_315_5 + arg_315_0 then
				local var_315_7 = Color.New(0, 0, 0)

				var_315_7.a = 1
				arg_312_1.mask_.color = var_315_7
			end

			local var_315_8 = 1.66666666666667

			if 1.66666666666667 < arg_312_1.time_ and arg_312_1.time_ <= var_315_8 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_9 = 2

			if var_315_8 <= arg_312_1.time_ and arg_312_1.time_ < var_315_8 + var_315_9 then
				local var_315_10 = Color.New(0, 0, 0)

				var_315_10.a = Mathf.Lerp(1, 0, (arg_312_1.time_ - var_315_8) / var_315_9)
				arg_312_1.mask_.color = var_315_10
			end

			if arg_312_1.time_ >= var_315_8 + var_315_9 and arg_312_1.time_ < var_315_8 + var_315_9 + arg_315_0 then
				local var_315_11 = Color.New(0, 0, 0)

				arg_312_1.mask_.enabled = false
				var_315_11.a = 0
				arg_312_1.mask_.color = var_315_11
			end

			local var_315_12 = arg_312_1.actors_["1077ui_story"].transform

			if 1.66666666666667 < arg_312_1.time_ and arg_312_1.time_ <= 1.66666666666667 + arg_315_0 then
				arg_312_1.var_.moveOldPos1077ui_story = var_315_12.localPosition

				local var_315_13 = GameObjectTools.GetOrAddComponent(var_315_12.gameObject, typeof(DynamicBoneHelper))

				if var_315_13 then
					var_315_13:EnableDynamicBone(false)
				end
			end

			local var_315_14 = 0.001

			if 1.66666666666667 <= arg_312_1.time_ and arg_312_1.time_ < 1.66666666666667 + var_315_14 then
				var_315_12.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_312_1.time_ - 1.66666666666667) / var_315_14)
				var_315_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_12.position).x, (manager.ui.mainCamera.transform.position - var_315_12.position).y, (manager.ui.mainCamera.transform.position - var_315_12.position).z)
				var_315_12.localEulerAngles.z = 0
				var_315_12.localEulerAngles.x = 0
				var_315_12.localEulerAngles = var_315_12.localEulerAngles
			end

			if arg_312_1.time_ >= 1.66666666666667 + var_315_14 and arg_312_1.time_ < 1.66666666666667 + var_315_14 + arg_315_0 then
				var_315_12.localPosition = Vector3.New(0, 100, 0)
				var_315_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_12.position).x, (manager.ui.mainCamera.transform.position - var_315_12.position).y, (manager.ui.mainCamera.transform.position - var_315_12.position).z)
				var_315_12.localEulerAngles.z = 0
				var_315_12.localEulerAngles.x = 0
				var_315_12.localEulerAngles = var_315_12.localEulerAngles

				local var_315_15 = GameObjectTools.GetOrAddComponent(var_315_12.gameObject, typeof(DynamicBoneHelper))

				if var_315_15 then
					var_315_15:EnableDynamicBone(true)
				end
			end

			local var_315_16 = arg_312_1.actors_["1077ui_story"]

			if 1.66666666666667 < arg_312_1.time_ and arg_312_1.time_ <= 1.66666666666667 + arg_315_0 and not isNil(var_315_16) and arg_312_1.var_.characterEffect1077ui_story == nil then
				arg_312_1.var_.characterEffect1077ui_story = var_315_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_17 = 0.200000002980232

			if 1.66666666666667 <= arg_312_1.time_ and arg_312_1.time_ < 1.66666666666667 + var_315_17 and not isNil(var_315_16) then
				if arg_312_1.var_.characterEffect1077ui_story and not isNil(var_315_16) then
					arg_312_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_312_1.time_ - 1.66666666666667) / var_315_17)
				end
			end

			if arg_312_1.time_ >= 1.66666666666667 + var_315_17 and arg_312_1.time_ < 1.66666666666667 + var_315_17 + arg_315_0 and not isNil(var_315_16) and arg_312_1.var_.characterEffect1077ui_story then
				arg_312_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_312_1.time_ and arg_312_1.time_ <= 1.2 + arg_315_0 then
				arg_312_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_town", "")
			end

			if arg_312_1.frameCnt_ <= 1 then
				arg_312_1.dialog_:SetActive(false)
			end

			local var_315_19 = 3.03333333333333
			local var_315_20 = 1.275

			if 3.03333333333333 < arg_312_1.time_ and arg_312_1.time_ <= var_315_19 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				arg_312_1.dialog_:SetActive(true)

				arg_312_1.dialogCg_.alpha = 0

				local var_315_21 = LeanTween.value(arg_312_1.dialog_, 0, 1, 0.3)

				var_315_21:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_312_1.dialogCg_.alpha = arg_316_0
				end))
				var_315_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_312_1.dialog_)
					var_315_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_312_1.duration_ = arg_312_1.duration_ + 0.3

				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_22 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(325011076).content)

				arg_312_1.text_.text = var_315_22

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_24 = 51 <= 0 and var_315_20 or var_315_20 * (utf8.len(var_315_22) / 51)

				if (51 <= 0 and var_315_20 or var_315_20 * (utf8.len(var_315_22) / 51)) > 0 and var_315_20 < var_315_24 then
					arg_312_1.talkMaxDuration = var_315_24
					var_315_19 = var_315_19 + 0.3

					if var_315_24 + var_315_19 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_24 + var_315_19
					end
				end

				arg_312_1.text_.text = var_315_22
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_25 = var_315_19 + 0.3
			local var_315_26 = math.max(var_315_20, arg_312_1.talkMaxDuration)

			if var_315_19 + 0.3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_25 + var_315_26 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_25) / var_315_26

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_25 + var_315_26 and arg_312_1.time_ < var_315_25 + var_315_26 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play325011077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 325011077
		arg_318_1.duration_ = 3.47

		local var_318_0 = {
			zh = 2.8,
			ja = 3.466
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play325011078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1077ui_story = arg_318_1.actors_["1077ui_story"].transform.localPosition

				local var_321_0 = GameObjectTools.GetOrAddComponent(arg_318_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_321_0 then
					var_321_0:EnableDynamicBone(false)
				end
			end

			local var_321_1 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_1 then
				arg_318_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_318_1.time_ - 0) / var_321_1)
				arg_318_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1077ui_story"].transform.position).z)
				arg_318_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1077ui_story"].transform.localEulerAngles = arg_318_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_1 and arg_318_1.time_ < 0 + var_321_1 + arg_321_0 then
				arg_318_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_318_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1077ui_story"].transform.position).z)
				arg_318_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1077ui_story"].transform.localEulerAngles = arg_318_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_321_2 = GameObjectTools.GetOrAddComponent(arg_318_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_321_2 then
					var_321_2:EnableDynamicBone(true)
				end
			end

			local var_321_3 = arg_318_1.actors_["1077ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_3) and arg_318_1.var_.characterEffect1077ui_story == nil then
				arg_318_1.var_.characterEffect1077ui_story = var_321_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_4 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 and not isNil(var_321_3) then
				if arg_318_1.var_.characterEffect1077ui_story and not isNil(var_321_3) then
					arg_318_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 and not isNil(var_321_3) and arg_318_1.var_.characterEffect1077ui_story then
				arg_318_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_1")
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_321_6 = 0
			local var_321_7 = 0.25

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_6 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_8 = arg_318_1:GetWordFromCfg(325011077)
				local var_321_9 = arg_318_1:FormatText(var_321_8.content)

				arg_318_1.text_.text = var_321_9

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_11 = 10 <= 0 and var_321_7 or var_321_7 * (utf8.len(var_321_9) / 10)

				if (10 <= 0 and var_321_7 or var_321_7 * (utf8.len(var_321_9) / 10)) > 0 and var_321_7 < var_321_11 then
					arg_318_1.talkMaxDuration = var_321_11

					if var_321_11 + var_321_6 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_11 + var_321_6
					end
				end

				arg_318_1.text_.text = var_321_9
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011077", "story_v_out_325011.awb") ~= 0 then
					local var_321_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011077", "story_v_out_325011.awb") / 1000

					if var_321_12 + var_321_6 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_12 + var_321_6
					end

					if var_321_8.prefab_name ~= "" and arg_318_1.actors_[var_321_8.prefab_name] ~= nil then
						local var_321_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_8.prefab_name].transform, "story_v_out_325011", "325011077", "story_v_out_325011.awb")

						arg_318_1:RecordAudio("325011077", var_321_13)
						arg_318_1:RecordAudio("325011077", var_321_13)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_325011", "325011077", "story_v_out_325011.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_325011", "325011077", "story_v_out_325011.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_14 = math.max(var_321_7, arg_318_1.talkMaxDuration)

			if var_321_6 <= arg_318_1.time_ and arg_318_1.time_ < var_321_6 + var_321_14 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_6) / var_321_14

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_6 + var_321_14 and arg_318_1.time_ < var_321_6 + var_321_14 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play325011078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 325011078
		arg_322_1.duration_ = 13.33

		local var_322_0 = {
			zh = 9.033,
			ja = 13.333
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play325011079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["1077ui_story"]) and arg_322_1.var_.characterEffect1077ui_story == nil then
				arg_322_1.var_.characterEffect1077ui_story = arg_322_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["1077ui_story"]) then
				if arg_322_1.var_.characterEffect1077ui_story and not isNil(arg_322_1.actors_["1077ui_story"]) then
					arg_322_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_0)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["1077ui_story"]) and arg_322_1.var_.characterEffect1077ui_story then
				arg_322_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_325_1 = 0
			local var_325_2 = 0.775

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_3 = arg_322_1:GetWordFromCfg(325011078)
				local var_325_4 = arg_322_1:FormatText(var_325_3.content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_6 = 31 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_4) / 31)

				if (31 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_4) / 31)) > 0 and var_325_2 < var_325_6 then
					arg_322_1.talkMaxDuration = var_325_6

					if var_325_6 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_6 + var_325_1
					end
				end

				arg_322_1.text_.text = var_325_4
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011078", "story_v_out_325011.awb") ~= 0 then
					local var_325_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011078", "story_v_out_325011.awb") / 1000

					if var_325_7 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_1
					end

					if var_325_3.prefab_name ~= "" and arg_322_1.actors_[var_325_3.prefab_name] ~= nil then
						local var_325_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_3.prefab_name].transform, "story_v_out_325011", "325011078", "story_v_out_325011.awb")

						arg_322_1:RecordAudio("325011078", var_325_8)
						arg_322_1:RecordAudio("325011078", var_325_8)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_325011", "325011078", "story_v_out_325011.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_325011", "325011078", "story_v_out_325011.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_9 = math.max(var_325_2, arg_322_1.talkMaxDuration)

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_9 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_1) / var_325_9

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_1 + var_325_9 and arg_322_1.time_ < var_325_1 + var_325_9 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play325011079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 325011079
		arg_326_1.duration_ = 16.07

		local var_326_0 = {
			zh = 13.6,
			ja = 16.066
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play325011080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 1.175

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_1 = arg_326_1:GetWordFromCfg(325011079)
				local var_329_2 = arg_326_1:FormatText(var_329_1.content)

				arg_326_1.text_.text = var_329_2

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 47 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 47)

				if (47 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 47)) > 0 and var_329_0 < var_329_4 then
					arg_326_1.talkMaxDuration = var_329_4

					if var_329_4 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_4 + 0
					end
				end

				arg_326_1.text_.text = var_329_2
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011079", "story_v_out_325011.awb") ~= 0 then
					local var_329_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011079", "story_v_out_325011.awb") / 1000

					if var_329_5 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + 0
					end

					if var_329_1.prefab_name ~= "" and arg_326_1.actors_[var_329_1.prefab_name] ~= nil then
						local var_329_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_1.prefab_name].transform, "story_v_out_325011", "325011079", "story_v_out_325011.awb")

						arg_326_1:RecordAudio("325011079", var_329_6)
						arg_326_1:RecordAudio("325011079", var_329_6)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_325011", "325011079", "story_v_out_325011.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_325011", "325011079", "story_v_out_325011.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_7 and arg_326_1.time_ < 0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play325011080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 325011080
		arg_330_1.duration_ = 7.6

		local var_330_0 = {
			zh = 6.8,
			ja = 7.6
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play325011081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["1077ui_story"]) and arg_330_1.var_.characterEffect1077ui_story == nil then
				arg_330_1.var_.characterEffect1077ui_story = arg_330_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["1077ui_story"]) then
				if arg_330_1.var_.characterEffect1077ui_story and not isNil(arg_330_1.actors_["1077ui_story"]) then
					arg_330_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["1077ui_story"]) and arg_330_1.var_.characterEffect1077ui_story then
				arg_330_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_333_2 = 0
			local var_333_3 = 0.575

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_2 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_4 = arg_330_1:GetWordFromCfg(325011080)
				local var_333_5 = arg_330_1:FormatText(var_333_4.content)

				arg_330_1.text_.text = var_333_5

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_7 = 23 <= 0 and var_333_3 or var_333_3 * (utf8.len(var_333_5) / 23)

				if (23 <= 0 and var_333_3 or var_333_3 * (utf8.len(var_333_5) / 23)) > 0 and var_333_3 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_2 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_2
					end
				end

				arg_330_1.text_.text = var_333_5
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011080", "story_v_out_325011.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011080", "story_v_out_325011.awb") / 1000

					if var_333_8 + var_333_2 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_2
					end

					if var_333_4.prefab_name ~= "" and arg_330_1.actors_[var_333_4.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_4.prefab_name].transform, "story_v_out_325011", "325011080", "story_v_out_325011.awb")

						arg_330_1:RecordAudio("325011080", var_333_9)
						arg_330_1:RecordAudio("325011080", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_325011", "325011080", "story_v_out_325011.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_325011", "325011080", "story_v_out_325011.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_3, arg_330_1.talkMaxDuration)

			if var_333_2 <= arg_330_1.time_ and arg_330_1.time_ < var_333_2 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_2) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_2 + var_333_10 and arg_330_1.time_ < var_333_2 + var_333_10 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play325011081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 325011081
		arg_334_1.duration_ = 13.2

		local var_334_0 = {
			zh = 11.466,
			ja = 13.2
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play325011082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["1077ui_story"]) and arg_334_1.var_.characterEffect1077ui_story == nil then
				arg_334_1.var_.characterEffect1077ui_story = arg_334_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_0 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["1077ui_story"]) then
				if arg_334_1.var_.characterEffect1077ui_story and not isNil(arg_334_1.actors_["1077ui_story"]) then
					arg_334_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_334_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_334_1.time_ - 0) / var_337_0)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["1077ui_story"]) and arg_334_1.var_.characterEffect1077ui_story then
				arg_334_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_334_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_337_1 = 0
			local var_337_2 = 1.075

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:GetWordFromCfg(325011081)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_6 = 43 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_4) / 43)

				if (43 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_4) / 43)) > 0 and var_337_2 < var_337_6 then
					arg_334_1.talkMaxDuration = var_337_6

					if var_337_6 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_6 + var_337_1
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011081", "story_v_out_325011.awb") ~= 0 then
					local var_337_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011081", "story_v_out_325011.awb") / 1000

					if var_337_7 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_1
					end

					if var_337_3.prefab_name ~= "" and arg_334_1.actors_[var_337_3.prefab_name] ~= nil then
						local var_337_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_3.prefab_name].transform, "story_v_out_325011", "325011081", "story_v_out_325011.awb")

						arg_334_1:RecordAudio("325011081", var_337_8)
						arg_334_1:RecordAudio("325011081", var_337_8)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_325011", "325011081", "story_v_out_325011.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_325011", "325011081", "story_v_out_325011.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_9 = math.max(var_337_2, arg_334_1.talkMaxDuration)

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_9 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_1) / var_337_9

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_1 + var_337_9 and arg_334_1.time_ < var_337_1 + var_337_9 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play325011082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 325011082
		arg_338_1.duration_ = 5.73

		local var_338_0 = {
			zh = 5.733,
			ja = 4.266
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play325011083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1077ui_story"]) and arg_338_1.var_.characterEffect1077ui_story == nil then
				arg_338_1.var_.characterEffect1077ui_story = arg_338_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1077ui_story"]) then
				if arg_338_1.var_.characterEffect1077ui_story and not isNil(arg_338_1.actors_["1077ui_story"]) then
					arg_338_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1077ui_story"]) and arg_338_1.var_.characterEffect1077ui_story then
				arg_338_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_341_2 = 0
			local var_341_3 = 0.6

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_4 = arg_338_1:GetWordFromCfg(325011082)
				local var_341_5 = arg_338_1:FormatText(var_341_4.content)

				arg_338_1.text_.text = var_341_5

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_7 = 24 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 24)

				if (24 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 24)) > 0 and var_341_3 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_2
					end
				end

				arg_338_1.text_.text = var_341_5
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011082", "story_v_out_325011.awb") ~= 0 then
					local var_341_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011082", "story_v_out_325011.awb") / 1000

					if var_341_8 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_2
					end

					if var_341_4.prefab_name ~= "" and arg_338_1.actors_[var_341_4.prefab_name] ~= nil then
						local var_341_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_4.prefab_name].transform, "story_v_out_325011", "325011082", "story_v_out_325011.awb")

						arg_338_1:RecordAudio("325011082", var_341_9)
						arg_338_1:RecordAudio("325011082", var_341_9)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_325011", "325011082", "story_v_out_325011.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_325011", "325011082", "story_v_out_325011.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_3, arg_338_1.talkMaxDuration)

			if var_341_2 <= arg_338_1.time_ and arg_338_1.time_ < var_341_2 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_2) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_2 + var_341_10 and arg_338_1.time_ < var_341_2 + var_341_10 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play325011083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 325011083
		arg_342_1.duration_ = 8.33

		local var_342_0 = {
			zh = 6.366,
			ja = 8.333
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play325011084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.6

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_1 = arg_342_1:GetWordFromCfg(325011083)
				local var_345_2 = arg_342_1:FormatText(var_345_1.content)

				arg_342_1.text_.text = var_345_2

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 24 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 24)

				if (24 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 24)) > 0 and var_345_0 < var_345_4 then
					arg_342_1.talkMaxDuration = var_345_4

					if var_345_4 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_4 + 0
					end
				end

				arg_342_1.text_.text = var_345_2
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011083", "story_v_out_325011.awb") ~= 0 then
					local var_345_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011083", "story_v_out_325011.awb") / 1000

					if var_345_5 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + 0
					end

					if var_345_1.prefab_name ~= "" and arg_342_1.actors_[var_345_1.prefab_name] ~= nil then
						local var_345_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_1.prefab_name].transform, "story_v_out_325011", "325011083", "story_v_out_325011.awb")

						arg_342_1:RecordAudio("325011083", var_345_6)
						arg_342_1:RecordAudio("325011083", var_345_6)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_325011", "325011083", "story_v_out_325011.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_325011", "325011083", "story_v_out_325011.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_7 and arg_342_1.time_ < 0 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play325011084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 325011084
		arg_346_1.duration_ = 14.8

		local var_346_0 = {
			zh = 13.3,
			ja = 14.8
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play325011085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1077ui_story"]) and arg_346_1.var_.characterEffect1077ui_story == nil then
				arg_346_1.var_.characterEffect1077ui_story = arg_346_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1077ui_story"]) then
				if arg_346_1.var_.characterEffect1077ui_story and not isNil(arg_346_1.actors_["1077ui_story"]) then
					arg_346_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_0)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1077ui_story"]) and arg_346_1.var_.characterEffect1077ui_story then
				arg_346_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_349_1 = 0
			local var_349_2 = 1.275

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_3 = arg_346_1:GetWordFromCfg(325011084)
				local var_349_4 = arg_346_1:FormatText(var_349_3.content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_6 = 51 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_4) / 51)

				if (51 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_4) / 51)) > 0 and var_349_2 < var_349_6 then
					arg_346_1.talkMaxDuration = var_349_6

					if var_349_6 + var_349_1 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_6 + var_349_1
					end
				end

				arg_346_1.text_.text = var_349_4
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011084", "story_v_out_325011.awb") ~= 0 then
					local var_349_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011084", "story_v_out_325011.awb") / 1000

					if var_349_7 + var_349_1 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_1
					end

					if var_349_3.prefab_name ~= "" and arg_346_1.actors_[var_349_3.prefab_name] ~= nil then
						local var_349_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_3.prefab_name].transform, "story_v_out_325011", "325011084", "story_v_out_325011.awb")

						arg_346_1:RecordAudio("325011084", var_349_8)
						arg_346_1:RecordAudio("325011084", var_349_8)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_325011", "325011084", "story_v_out_325011.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_325011", "325011084", "story_v_out_325011.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_9 = math.max(var_349_2, arg_346_1.talkMaxDuration)

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_9 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_1) / var_349_9

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_1 + var_349_9 and arg_346_1.time_ < var_349_1 + var_349_9 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play325011085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 325011085
		arg_350_1.duration_ = 2.17

		local var_350_0 = {
			zh = 2.166,
			ja = 1.999999999999
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play325011086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1077ui_story"]) and arg_350_1.var_.characterEffect1077ui_story == nil then
				arg_350_1.var_.characterEffect1077ui_story = arg_350_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_0 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1077ui_story"]) then
				if arg_350_1.var_.characterEffect1077ui_story and not isNil(arg_350_1.actors_["1077ui_story"]) then
					arg_350_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1077ui_story"]) and arg_350_1.var_.characterEffect1077ui_story then
				arg_350_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_353_2 = 0
			local var_353_3 = 0.175

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_2 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_4 = arg_350_1:GetWordFromCfg(325011085)
				local var_353_5 = arg_350_1:FormatText(var_353_4.content)

				arg_350_1.text_.text = var_353_5

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_7 = 7 <= 0 and var_353_3 or var_353_3 * (utf8.len(var_353_5) / 7)

				if (7 <= 0 and var_353_3 or var_353_3 * (utf8.len(var_353_5) / 7)) > 0 and var_353_3 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_2
					end
				end

				arg_350_1.text_.text = var_353_5
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011085", "story_v_out_325011.awb") ~= 0 then
					local var_353_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011085", "story_v_out_325011.awb") / 1000

					if var_353_8 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_8 + var_353_2
					end

					if var_353_4.prefab_name ~= "" and arg_350_1.actors_[var_353_4.prefab_name] ~= nil then
						local var_353_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_4.prefab_name].transform, "story_v_out_325011", "325011085", "story_v_out_325011.awb")

						arg_350_1:RecordAudio("325011085", var_353_9)
						arg_350_1:RecordAudio("325011085", var_353_9)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_325011", "325011085", "story_v_out_325011.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_325011", "325011085", "story_v_out_325011.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_10 = math.max(var_353_3, arg_350_1.talkMaxDuration)

			if var_353_2 <= arg_350_1.time_ and arg_350_1.time_ < var_353_2 + var_353_10 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_2) / var_353_10

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_2 + var_353_10 and arg_350_1.time_ < var_353_2 + var_353_10 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play325011086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 325011086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play325011087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["1077ui_story"]) and arg_354_1.var_.characterEffect1077ui_story == nil then
				arg_354_1.var_.characterEffect1077ui_story = arg_354_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_0 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["1077ui_story"]) then
				if arg_354_1.var_.characterEffect1077ui_story and not isNil(arg_354_1.actors_["1077ui_story"]) then
					arg_354_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_354_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_354_1.time_ - 0) / var_357_0)
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["1077ui_story"]) and arg_354_1.var_.characterEffect1077ui_story then
				arg_354_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_354_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_357_1 = 0
			local var_357_2 = 0.95

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_3 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(325011086).content)

				arg_354_1.text_.text = var_357_3

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 38 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 38)

				if (38 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 38)) > 0 and var_357_2 < var_357_5 then
					arg_354_1.talkMaxDuration = var_357_5

					if var_357_5 + var_357_1 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + var_357_1
					end
				end

				arg_354_1.text_.text = var_357_3
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_6 = math.max(var_357_2, arg_354_1.talkMaxDuration)

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_6 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_1) / var_357_6

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_1 + var_357_6 and arg_354_1.time_ < var_357_1 + var_357_6 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play325011087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 325011087
		arg_358_1.duration_ = 7.97

		local var_358_0 = {
			zh = 5.633,
			ja = 7.966
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play325011088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["1077ui_story"]) and arg_358_1.var_.characterEffect1077ui_story == nil then
				arg_358_1.var_.characterEffect1077ui_story = arg_358_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_0 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["1077ui_story"]) then
				if arg_358_1.var_.characterEffect1077ui_story and not isNil(arg_358_1.actors_["1077ui_story"]) then
					arg_358_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1077ui_story"]) and arg_358_1.var_.characterEffect1077ui_story then
				arg_358_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_361_2 = 0
			local var_361_3 = 0.6

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_2 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_4 = arg_358_1:GetWordFromCfg(325011087)
				local var_361_5 = arg_358_1:FormatText(var_361_4.content)

				arg_358_1.text_.text = var_361_5

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_7 = 24 <= 0 and var_361_3 or var_361_3 * (utf8.len(var_361_5) / 24)

				if (24 <= 0 and var_361_3 or var_361_3 * (utf8.len(var_361_5) / 24)) > 0 and var_361_3 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_2 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_2
					end
				end

				arg_358_1.text_.text = var_361_5
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011087", "story_v_out_325011.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011087", "story_v_out_325011.awb") / 1000

					if var_361_8 + var_361_2 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_2
					end

					if var_361_4.prefab_name ~= "" and arg_358_1.actors_[var_361_4.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_4.prefab_name].transform, "story_v_out_325011", "325011087", "story_v_out_325011.awb")

						arg_358_1:RecordAudio("325011087", var_361_9)
						arg_358_1:RecordAudio("325011087", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_325011", "325011087", "story_v_out_325011.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_325011", "325011087", "story_v_out_325011.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_3, arg_358_1.talkMaxDuration)

			if var_361_2 <= arg_358_1.time_ and arg_358_1.time_ < var_361_2 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_2) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_2 + var_361_10 and arg_358_1.time_ < var_361_2 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play325011088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 325011088
		arg_362_1.duration_ = 9.03

		local var_362_0 = {
			zh = 6.233,
			ja = 9.033
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play325011089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["1077ui_story"]) and arg_362_1.var_.characterEffect1077ui_story == nil then
				arg_362_1.var_.characterEffect1077ui_story = arg_362_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_0 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["1077ui_story"]) then
				if arg_362_1.var_.characterEffect1077ui_story and not isNil(arg_362_1.actors_["1077ui_story"]) then
					arg_362_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_362_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_362_1.time_ - 0) / var_365_0)
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["1077ui_story"]) and arg_362_1.var_.characterEffect1077ui_story then
				arg_362_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_362_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_365_1 = 0
			local var_365_2 = 0.525

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_3 = arg_362_1:GetWordFromCfg(325011088)
				local var_365_4 = arg_362_1:FormatText(var_365_3.content)

				arg_362_1.text_.text = var_365_4

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_6 = 21 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_4) / 21)

				if (21 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_4) / 21)) > 0 and var_365_2 < var_365_6 then
					arg_362_1.talkMaxDuration = var_365_6

					if var_365_6 + var_365_1 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_6 + var_365_1
					end
				end

				arg_362_1.text_.text = var_365_4
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011088", "story_v_out_325011.awb") ~= 0 then
					local var_365_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011088", "story_v_out_325011.awb") / 1000

					if var_365_7 + var_365_1 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_1
					end

					if var_365_3.prefab_name ~= "" and arg_362_1.actors_[var_365_3.prefab_name] ~= nil then
						local var_365_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_3.prefab_name].transform, "story_v_out_325011", "325011088", "story_v_out_325011.awb")

						arg_362_1:RecordAudio("325011088", var_365_8)
						arg_362_1:RecordAudio("325011088", var_365_8)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_325011", "325011088", "story_v_out_325011.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_325011", "325011088", "story_v_out_325011.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_9 = math.max(var_365_2, arg_362_1.talkMaxDuration)

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_9 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_1) / var_365_9

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_1 + var_365_9 and arg_362_1.time_ < var_365_1 + var_365_9 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play325011089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 325011089
		arg_366_1.duration_ = 2.73

		local var_366_0 = {
			zh = 2.733,
			ja = 1.999999999999
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play325011090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["1077ui_story"]) and arg_366_1.var_.characterEffect1077ui_story == nil then
				arg_366_1.var_.characterEffect1077ui_story = arg_366_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_0 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["1077ui_story"]) then
				if arg_366_1.var_.characterEffect1077ui_story and not isNil(arg_366_1.actors_["1077ui_story"]) then
					arg_366_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["1077ui_story"]) and arg_366_1.var_.characterEffect1077ui_story then
				arg_366_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_369_2 = 0
			local var_369_3 = 0.175

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_2 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_4 = arg_366_1:GetWordFromCfg(325011089)
				local var_369_5 = arg_366_1:FormatText(var_369_4.content)

				arg_366_1.text_.text = var_369_5

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_7 = 7 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_5) / 7)

				if (7 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_5) / 7)) > 0 and var_369_3 < var_369_7 then
					arg_366_1.talkMaxDuration = var_369_7

					if var_369_7 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_7 + var_369_2
					end
				end

				arg_366_1.text_.text = var_369_5
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011089", "story_v_out_325011.awb") ~= 0 then
					local var_369_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011089", "story_v_out_325011.awb") / 1000

					if var_369_8 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_8 + var_369_2
					end

					if var_369_4.prefab_name ~= "" and arg_366_1.actors_[var_369_4.prefab_name] ~= nil then
						local var_369_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_4.prefab_name].transform, "story_v_out_325011", "325011089", "story_v_out_325011.awb")

						arg_366_1:RecordAudio("325011089", var_369_9)
						arg_366_1:RecordAudio("325011089", var_369_9)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_325011", "325011089", "story_v_out_325011.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_325011", "325011089", "story_v_out_325011.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_10 = math.max(var_369_3, arg_366_1.talkMaxDuration)

			if var_369_2 <= arg_366_1.time_ and arg_366_1.time_ < var_369_2 + var_369_10 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_2) / var_369_10

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_2 + var_369_10 and arg_366_1.time_ < var_369_2 + var_369_10 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play325011090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 325011090
		arg_370_1.duration_ = 11.43

		local var_370_0 = {
			zh = 8.1,
			ja = 11.433
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play325011091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1077ui_story"]) and arg_370_1.var_.characterEffect1077ui_story == nil then
				arg_370_1.var_.characterEffect1077ui_story = arg_370_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1077ui_story"]) then
				if arg_370_1.var_.characterEffect1077ui_story and not isNil(arg_370_1.actors_["1077ui_story"]) then
					arg_370_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_0)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1077ui_story"]) and arg_370_1.var_.characterEffect1077ui_story then
				arg_370_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_373_1 = 0
			local var_373_2 = 0.725

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_3 = arg_370_1:GetWordFromCfg(325011090)
				local var_373_4 = arg_370_1:FormatText(var_373_3.content)

				arg_370_1.text_.text = var_373_4

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_6 = 29 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_4) / 29)

				if (29 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_4) / 29)) > 0 and var_373_2 < var_373_6 then
					arg_370_1.talkMaxDuration = var_373_6

					if var_373_6 + var_373_1 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_6 + var_373_1
					end
				end

				arg_370_1.text_.text = var_373_4
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011090", "story_v_out_325011.awb") ~= 0 then
					local var_373_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011090", "story_v_out_325011.awb") / 1000

					if var_373_7 + var_373_1 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_7 + var_373_1
					end

					if var_373_3.prefab_name ~= "" and arg_370_1.actors_[var_373_3.prefab_name] ~= nil then
						local var_373_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_3.prefab_name].transform, "story_v_out_325011", "325011090", "story_v_out_325011.awb")

						arg_370_1:RecordAudio("325011090", var_373_8)
						arg_370_1:RecordAudio("325011090", var_373_8)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_325011", "325011090", "story_v_out_325011.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_325011", "325011090", "story_v_out_325011.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_9 = math.max(var_373_2, arg_370_1.talkMaxDuration)

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_9 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_1) / var_373_9

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_1 + var_373_9 and arg_370_1.time_ < var_373_1 + var_373_9 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play325011091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 325011091
		arg_374_1.duration_ = 12

		local var_374_0 = {
			zh = 9.033,
			ja = 12
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play325011092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.725

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_1 = arg_374_1:GetWordFromCfg(325011091)
				local var_377_2 = arg_374_1:FormatText(var_377_1.content)

				arg_374_1.text_.text = var_377_2

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 29 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 29)

				if (29 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 29)) > 0 and var_377_0 < var_377_4 then
					arg_374_1.talkMaxDuration = var_377_4

					if var_377_4 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_4 + 0
					end
				end

				arg_374_1.text_.text = var_377_2
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011091", "story_v_out_325011.awb") ~= 0 then
					local var_377_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011091", "story_v_out_325011.awb") / 1000

					if var_377_5 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + 0
					end

					if var_377_1.prefab_name ~= "" and arg_374_1.actors_[var_377_1.prefab_name] ~= nil then
						local var_377_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_1.prefab_name].transform, "story_v_out_325011", "325011091", "story_v_out_325011.awb")

						arg_374_1:RecordAudio("325011091", var_377_6)
						arg_374_1:RecordAudio("325011091", var_377_6)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_325011", "325011091", "story_v_out_325011.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_325011", "325011091", "story_v_out_325011.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play325011092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 325011092
		arg_378_1.duration_ = 7.63

		local var_378_0 = {
			zh = 5.533,
			ja = 7.633
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play325011093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1077ui_story"]) and arg_378_1.var_.characterEffect1077ui_story == nil then
				arg_378_1.var_.characterEffect1077ui_story = arg_378_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1077ui_story"]) then
				if arg_378_1.var_.characterEffect1077ui_story and not isNil(arg_378_1.actors_["1077ui_story"]) then
					arg_378_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1077ui_story"]) and arg_378_1.var_.characterEffect1077ui_story then
				arg_378_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_381_2 = 0
			local var_381_3 = 0.675

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_2 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_4 = arg_378_1:GetWordFromCfg(325011092)
				local var_381_5 = arg_378_1:FormatText(var_381_4.content)

				arg_378_1.text_.text = var_381_5

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_7 = 27 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_5) / 27)

				if (27 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_5) / 27)) > 0 and var_381_3 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_2
					end
				end

				arg_378_1.text_.text = var_381_5
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011092", "story_v_out_325011.awb") ~= 0 then
					local var_381_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011092", "story_v_out_325011.awb") / 1000

					if var_381_8 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_8 + var_381_2
					end

					if var_381_4.prefab_name ~= "" and arg_378_1.actors_[var_381_4.prefab_name] ~= nil then
						local var_381_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_4.prefab_name].transform, "story_v_out_325011", "325011092", "story_v_out_325011.awb")

						arg_378_1:RecordAudio("325011092", var_381_9)
						arg_378_1:RecordAudio("325011092", var_381_9)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_325011", "325011092", "story_v_out_325011.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_325011", "325011092", "story_v_out_325011.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_10 = math.max(var_381_3, arg_378_1.talkMaxDuration)

			if var_381_2 <= arg_378_1.time_ and arg_378_1.time_ < var_381_2 + var_381_10 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_2) / var_381_10

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_2 + var_381_10 and arg_378_1.time_ < var_381_2 + var_381_10 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play325011093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 325011093
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play325011094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1077ui_story"]) and arg_382_1.var_.characterEffect1077ui_story == nil then
				arg_382_1.var_.characterEffect1077ui_story = arg_382_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_0 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1077ui_story"]) then
				if arg_382_1.var_.characterEffect1077ui_story and not isNil(arg_382_1.actors_["1077ui_story"]) then
					arg_382_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_0)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1077ui_story"]) and arg_382_1.var_.characterEffect1077ui_story then
				arg_382_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_385_1 = 0
			local var_385_2 = 1.025

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_3 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(325011093).content)

				arg_382_1.text_.text = var_385_3

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 41 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 41)

				if (41 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 41)) > 0 and var_385_2 < var_385_5 then
					arg_382_1.talkMaxDuration = var_385_5

					if var_385_5 + var_385_1 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + var_385_1
					end
				end

				arg_382_1.text_.text = var_385_3
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_6 = math.max(var_385_2, arg_382_1.talkMaxDuration)

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_6 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_1) / var_385_6

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_1 + var_385_6 and arg_382_1.time_ < var_385_1 + var_385_6 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play325011094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 325011094
		arg_386_1.duration_ = 17.23

		local var_386_0 = {
			zh = 17.233,
			ja = 16.933
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play325011095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 1.35

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_1 = arg_386_1:GetWordFromCfg(325011094)
				local var_389_2 = arg_386_1:FormatText(var_389_1.content)

				arg_386_1.text_.text = var_389_2

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_4 = 54 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 54)

				if (54 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 54)) > 0 and var_389_0 < var_389_4 then
					arg_386_1.talkMaxDuration = var_389_4

					if var_389_4 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_4 + 0
					end
				end

				arg_386_1.text_.text = var_389_2
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011094", "story_v_out_325011.awb") ~= 0 then
					local var_389_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011094", "story_v_out_325011.awb") / 1000

					if var_389_5 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + 0
					end

					if var_389_1.prefab_name ~= "" and arg_386_1.actors_[var_389_1.prefab_name] ~= nil then
						local var_389_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_1.prefab_name].transform, "story_v_out_325011", "325011094", "story_v_out_325011.awb")

						arg_386_1:RecordAudio("325011094", var_389_6)
						arg_386_1:RecordAudio("325011094", var_389_6)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_325011", "325011094", "story_v_out_325011.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_325011", "325011094", "story_v_out_325011.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_7 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_7 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_7

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_7 and arg_386_1.time_ < 0 + var_389_7 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play325011095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 325011095
		arg_390_1.duration_ = 7.43

		local var_390_0 = {
			zh = 6.9,
			ja = 7.433
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play325011096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.55

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_1 = arg_390_1:GetWordFromCfg(325011095)
				local var_393_2 = arg_390_1:FormatText(var_393_1.content)

				arg_390_1.text_.text = var_393_2

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 22 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 22)

				if (22 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 22)) > 0 and var_393_0 < var_393_4 then
					arg_390_1.talkMaxDuration = var_393_4

					if var_393_4 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_4 + 0
					end
				end

				arg_390_1.text_.text = var_393_2
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011095", "story_v_out_325011.awb") ~= 0 then
					local var_393_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011095", "story_v_out_325011.awb") / 1000

					if var_393_5 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + 0
					end

					if var_393_1.prefab_name ~= "" and arg_390_1.actors_[var_393_1.prefab_name] ~= nil then
						local var_393_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_1.prefab_name].transform, "story_v_out_325011", "325011095", "story_v_out_325011.awb")

						arg_390_1:RecordAudio("325011095", var_393_6)
						arg_390_1:RecordAudio("325011095", var_393_6)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_325011", "325011095", "story_v_out_325011.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_325011", "325011095", "story_v_out_325011.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_7 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_7 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_7

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_7 and arg_390_1.time_ < 0 + var_393_7 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play325011096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 325011096
		arg_394_1.duration_ = 2.97

		local var_394_0 = {
			zh = 2.533,
			ja = 2.966
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play325011097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1077ui_story"]) and arg_394_1.var_.characterEffect1077ui_story == nil then
				arg_394_1.var_.characterEffect1077ui_story = arg_394_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1077ui_story"]) then
				if arg_394_1.var_.characterEffect1077ui_story and not isNil(arg_394_1.actors_["1077ui_story"]) then
					arg_394_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1077ui_story"]) and arg_394_1.var_.characterEffect1077ui_story then
				arg_394_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_397_2 = 0
			local var_397_3 = 0.2

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_2 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_4 = arg_394_1:GetWordFromCfg(325011096)
				local var_397_5 = arg_394_1:FormatText(var_397_4.content)

				arg_394_1.text_.text = var_397_5

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_7 = 8 <= 0 and var_397_3 or var_397_3 * (utf8.len(var_397_5) / 8)

				if (8 <= 0 and var_397_3 or var_397_3 * (utf8.len(var_397_5) / 8)) > 0 and var_397_3 < var_397_7 then
					arg_394_1.talkMaxDuration = var_397_7

					if var_397_7 + var_397_2 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_2
					end
				end

				arg_394_1.text_.text = var_397_5
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011096", "story_v_out_325011.awb") ~= 0 then
					local var_397_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011096", "story_v_out_325011.awb") / 1000

					if var_397_8 + var_397_2 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_8 + var_397_2
					end

					if var_397_4.prefab_name ~= "" and arg_394_1.actors_[var_397_4.prefab_name] ~= nil then
						local var_397_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_4.prefab_name].transform, "story_v_out_325011", "325011096", "story_v_out_325011.awb")

						arg_394_1:RecordAudio("325011096", var_397_9)
						arg_394_1:RecordAudio("325011096", var_397_9)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_325011", "325011096", "story_v_out_325011.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_325011", "325011096", "story_v_out_325011.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_10 = math.max(var_397_3, arg_394_1.talkMaxDuration)

			if var_397_2 <= arg_394_1.time_ and arg_394_1.time_ < var_397_2 + var_397_10 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_2) / var_397_10

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_2 + var_397_10 and arg_394_1.time_ < var_397_2 + var_397_10 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play325011097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 325011097
		arg_398_1.duration_ = 20.2

		local var_398_0 = {
			zh = 13.266,
			ja = 20.2
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play325011098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["1077ui_story"]) and arg_398_1.var_.characterEffect1077ui_story == nil then
				arg_398_1.var_.characterEffect1077ui_story = arg_398_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_0 = 0.200000002980232

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["1077ui_story"]) then
				if arg_398_1.var_.characterEffect1077ui_story and not isNil(arg_398_1.actors_["1077ui_story"]) then
					arg_398_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_398_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_398_1.time_ - 0) / var_401_0)
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["1077ui_story"]) and arg_398_1.var_.characterEffect1077ui_story then
				arg_398_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_398_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_401_1 = 0
			local var_401_2 = 1.175

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_3 = arg_398_1:GetWordFromCfg(325011097)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_6 = 47 <= 0 and var_401_2 or var_401_2 * (utf8.len(var_401_4) / 47)

				if (47 <= 0 and var_401_2 or var_401_2 * (utf8.len(var_401_4) / 47)) > 0 and var_401_2 < var_401_6 then
					arg_398_1.talkMaxDuration = var_401_6

					if var_401_6 + var_401_1 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_6 + var_401_1
					end
				end

				arg_398_1.text_.text = var_401_4
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011097", "story_v_out_325011.awb") ~= 0 then
					local var_401_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011097", "story_v_out_325011.awb") / 1000

					if var_401_7 + var_401_1 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_1
					end

					if var_401_3.prefab_name ~= "" and arg_398_1.actors_[var_401_3.prefab_name] ~= nil then
						local var_401_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_3.prefab_name].transform, "story_v_out_325011", "325011097", "story_v_out_325011.awb")

						arg_398_1:RecordAudio("325011097", var_401_8)
						arg_398_1:RecordAudio("325011097", var_401_8)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_325011", "325011097", "story_v_out_325011.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_325011", "325011097", "story_v_out_325011.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_9 = math.max(var_401_2, arg_398_1.talkMaxDuration)

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_9 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_1) / var_401_9

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_1 + var_401_9 and arg_398_1.time_ < var_401_1 + var_401_9 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play325011098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 325011098
		arg_402_1.duration_ = 10.47

		local var_402_0 = {
			zh = 10.466,
			ja = 9.933
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play325011099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.95

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_1 = arg_402_1:GetWordFromCfg(325011098)
				local var_405_2 = arg_402_1:FormatText(var_405_1.content)

				arg_402_1.text_.text = var_405_2

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_4 = 38 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 38)

				if (38 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 38)) > 0 and var_405_0 < var_405_4 then
					arg_402_1.talkMaxDuration = var_405_4

					if var_405_4 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_4 + 0
					end
				end

				arg_402_1.text_.text = var_405_2
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011098", "story_v_out_325011.awb") ~= 0 then
					local var_405_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011098", "story_v_out_325011.awb") / 1000

					if var_405_5 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + 0
					end

					if var_405_1.prefab_name ~= "" and arg_402_1.actors_[var_405_1.prefab_name] ~= nil then
						local var_405_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_1.prefab_name].transform, "story_v_out_325011", "325011098", "story_v_out_325011.awb")

						arg_402_1:RecordAudio("325011098", var_405_6)
						arg_402_1:RecordAudio("325011098", var_405_6)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_325011", "325011098", "story_v_out_325011.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_325011", "325011098", "story_v_out_325011.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_7 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_7 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_7

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_7 and arg_402_1.time_ < 0 + var_405_7 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play325011099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 325011099
		arg_406_1.duration_ = 7.67

		local var_406_0 = {
			zh = 7.666,
			ja = 6.933
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play325011100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.625

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_1 = arg_406_1:GetWordFromCfg(325011099)
				local var_409_2 = arg_406_1:FormatText(var_409_1.content)

				arg_406_1.text_.text = var_409_2

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 25 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 25)

				if (25 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 25)) > 0 and var_409_0 < var_409_4 then
					arg_406_1.talkMaxDuration = var_409_4

					if var_409_4 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_4 + 0
					end
				end

				arg_406_1.text_.text = var_409_2
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011099", "story_v_out_325011.awb") ~= 0 then
					local var_409_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011099", "story_v_out_325011.awb") / 1000

					if var_409_5 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + 0
					end

					if var_409_1.prefab_name ~= "" and arg_406_1.actors_[var_409_1.prefab_name] ~= nil then
						local var_409_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_1.prefab_name].transform, "story_v_out_325011", "325011099", "story_v_out_325011.awb")

						arg_406_1:RecordAudio("325011099", var_409_6)
						arg_406_1:RecordAudio("325011099", var_409_6)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_325011", "325011099", "story_v_out_325011.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_325011", "325011099", "story_v_out_325011.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_7 = math.max(var_409_0, arg_406_1.talkMaxDuration)

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_7 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - 0) / var_409_7

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= 0 + var_409_7 and arg_406_1.time_ < 0 + var_409_7 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play325011100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 325011100
		arg_410_1.duration_ = 2.9

		local var_410_0 = {
			zh = 1.999999999999,
			ja = 2.9
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play325011101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["1077ui_story"]) and arg_410_1.var_.characterEffect1077ui_story == nil then
				arg_410_1.var_.characterEffect1077ui_story = arg_410_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_0 = 0.200000002980232

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["1077ui_story"]) then
				if arg_410_1.var_.characterEffect1077ui_story and not isNil(arg_410_1.actors_["1077ui_story"]) then
					arg_410_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["1077ui_story"]) and arg_410_1.var_.characterEffect1077ui_story then
				arg_410_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			local var_413_2 = 0
			local var_413_3 = 0.225

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_2 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_4 = arg_410_1:GetWordFromCfg(325011100)
				local var_413_5 = arg_410_1:FormatText(var_413_4.content)

				arg_410_1.text_.text = var_413_5

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_7 = 9 <= 0 and var_413_3 or var_413_3 * (utf8.len(var_413_5) / 9)

				if (9 <= 0 and var_413_3 or var_413_3 * (utf8.len(var_413_5) / 9)) > 0 and var_413_3 < var_413_7 then
					arg_410_1.talkMaxDuration = var_413_7

					if var_413_7 + var_413_2 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_7 + var_413_2
					end
				end

				arg_410_1.text_.text = var_413_5
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011100", "story_v_out_325011.awb") ~= 0 then
					local var_413_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011100", "story_v_out_325011.awb") / 1000

					if var_413_8 + var_413_2 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_8 + var_413_2
					end

					if var_413_4.prefab_name ~= "" and arg_410_1.actors_[var_413_4.prefab_name] ~= nil then
						local var_413_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_4.prefab_name].transform, "story_v_out_325011", "325011100", "story_v_out_325011.awb")

						arg_410_1:RecordAudio("325011100", var_413_9)
						arg_410_1:RecordAudio("325011100", var_413_9)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_325011", "325011100", "story_v_out_325011.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_325011", "325011100", "story_v_out_325011.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_10 = math.max(var_413_3, arg_410_1.talkMaxDuration)

			if var_413_2 <= arg_410_1.time_ and arg_410_1.time_ < var_413_2 + var_413_10 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_2) / var_413_10

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_2 + var_413_10 and arg_410_1.time_ < var_413_2 + var_413_10 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play325011101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 325011101
		arg_414_1.duration_ = 8.67

		local var_414_0 = {
			zh = 6.566,
			ja = 8.666
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play325011102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(arg_414_1.actors_["1077ui_story"]) and arg_414_1.var_.characterEffect1077ui_story == nil then
				arg_414_1.var_.characterEffect1077ui_story = arg_414_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_0 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 and not isNil(arg_414_1.actors_["1077ui_story"]) then
				if arg_414_1.var_.characterEffect1077ui_story and not isNil(arg_414_1.actors_["1077ui_story"]) then
					arg_414_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_414_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_414_1.time_ - 0) / var_417_0)
				end
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 and not isNil(arg_414_1.actors_["1077ui_story"]) and arg_414_1.var_.characterEffect1077ui_story then
				arg_414_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_414_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_417_1 = 0
			local var_417_2 = 0.525

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_3 = arg_414_1:GetWordFromCfg(325011101)
				local var_417_4 = arg_414_1:FormatText(var_417_3.content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_6 = 21 <= 0 and var_417_2 or var_417_2 * (utf8.len(var_417_4) / 21)

				if (21 <= 0 and var_417_2 or var_417_2 * (utf8.len(var_417_4) / 21)) > 0 and var_417_2 < var_417_6 then
					arg_414_1.talkMaxDuration = var_417_6

					if var_417_6 + var_417_1 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_6 + var_417_1
					end
				end

				arg_414_1.text_.text = var_417_4
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011101", "story_v_out_325011.awb") ~= 0 then
					local var_417_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011101", "story_v_out_325011.awb") / 1000

					if var_417_7 + var_417_1 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_1
					end

					if var_417_3.prefab_name ~= "" and arg_414_1.actors_[var_417_3.prefab_name] ~= nil then
						local var_417_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_3.prefab_name].transform, "story_v_out_325011", "325011101", "story_v_out_325011.awb")

						arg_414_1:RecordAudio("325011101", var_417_8)
						arg_414_1:RecordAudio("325011101", var_417_8)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_325011", "325011101", "story_v_out_325011.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_325011", "325011101", "story_v_out_325011.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_9 = math.max(var_417_2, arg_414_1.talkMaxDuration)

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_9 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_1) / var_417_9

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_1 + var_417_9 and arg_414_1.time_ < var_417_1 + var_417_9 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play325011102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 325011102
		arg_418_1.duration_ = 9.3

		local var_418_0 = {
			zh = 8.233,
			ja = 9.3
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play325011103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["1077ui_story"]) and arg_418_1.var_.characterEffect1077ui_story == nil then
				arg_418_1.var_.characterEffect1077ui_story = arg_418_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_0 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["1077ui_story"]) then
				if arg_418_1.var_.characterEffect1077ui_story and not isNil(arg_418_1.actors_["1077ui_story"]) then
					arg_418_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["1077ui_story"]) and arg_418_1.var_.characterEffect1077ui_story then
				arg_418_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action4_1")
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_421_2 = 0
			local var_421_3 = 0.7

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_2 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_4 = arg_418_1:GetWordFromCfg(325011102)
				local var_421_5 = arg_418_1:FormatText(var_421_4.content)

				arg_418_1.text_.text = var_421_5

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_7 = 28 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 28)

				if (28 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 28)) > 0 and var_421_3 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_2
					end
				end

				arg_418_1.text_.text = var_421_5
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011102", "story_v_out_325011.awb") ~= 0 then
					local var_421_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011102", "story_v_out_325011.awb") / 1000

					if var_421_8 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_8 + var_421_2
					end

					if var_421_4.prefab_name ~= "" and arg_418_1.actors_[var_421_4.prefab_name] ~= nil then
						local var_421_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_4.prefab_name].transform, "story_v_out_325011", "325011102", "story_v_out_325011.awb")

						arg_418_1:RecordAudio("325011102", var_421_9)
						arg_418_1:RecordAudio("325011102", var_421_9)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_325011", "325011102", "story_v_out_325011.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_325011", "325011102", "story_v_out_325011.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_10 = math.max(var_421_3, arg_418_1.talkMaxDuration)

			if var_421_2 <= arg_418_1.time_ and arg_418_1.time_ < var_421_2 + var_421_10 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_2) / var_421_10

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_2 + var_421_10 and arg_418_1.time_ < var_421_2 + var_421_10 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play325011103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 325011103
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play325011104(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.var_.moveOldPos1077ui_story = arg_422_1.actors_["1077ui_story"].transform.localPosition

				local var_425_0 = GameObjectTools.GetOrAddComponent(arg_422_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_425_0 then
					var_425_0:EnableDynamicBone(false)
				end
			end

			local var_425_1 = 0.001

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_1 then
				arg_422_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_422_1.time_ - 0) / var_425_1)
				arg_422_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_422_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1077ui_story"].transform.position).z)
				arg_422_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_422_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_422_1.actors_["1077ui_story"].transform.localEulerAngles = arg_422_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_422_1.time_ >= 0 + var_425_1 and arg_422_1.time_ < 0 + var_425_1 + arg_425_0 then
				arg_422_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_422_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_422_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1077ui_story"].transform.position).z)
				arg_422_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_422_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_422_1.actors_["1077ui_story"].transform.localEulerAngles = arg_422_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_425_2 = GameObjectTools.GetOrAddComponent(arg_422_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_425_2 then
					var_425_2:EnableDynamicBone(true)
				end
			end

			local var_425_3 = arg_422_1.actors_["1077ui_story"]

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(var_425_3) and arg_422_1.var_.characterEffect1077ui_story == nil then
				arg_422_1.var_.characterEffect1077ui_story = var_425_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_4 = 0.200000002980232

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_4 and not isNil(var_425_3) then
				if arg_422_1.var_.characterEffect1077ui_story and not isNil(var_425_3) then
					arg_422_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_422_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_422_1.time_ - 0) / var_425_4)
				end
			end

			if arg_422_1.time_ >= 0 + var_425_4 and arg_422_1.time_ < 0 + var_425_4 + arg_425_0 and not isNil(var_425_3) and arg_422_1.var_.characterEffect1077ui_story then
				arg_422_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_422_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_425_5 = 0
			local var_425_6 = 0.975

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_5 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_7 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(325011103).content)

				arg_422_1.text_.text = var_425_7

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_9 = 39 <= 0 and var_425_6 or var_425_6 * (utf8.len(var_425_7) / 39)

				if (39 <= 0 and var_425_6 or var_425_6 * (utf8.len(var_425_7) / 39)) > 0 and var_425_6 < var_425_9 then
					arg_422_1.talkMaxDuration = var_425_9

					if var_425_9 + var_425_5 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_9 + var_425_5
					end
				end

				arg_422_1.text_.text = var_425_7
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_10 = math.max(var_425_6, arg_422_1.talkMaxDuration)

			if var_425_5 <= arg_422_1.time_ and arg_422_1.time_ < var_425_5 + var_425_10 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_5) / var_425_10

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_5 + var_425_10 and arg_422_1.time_ < var_425_5 + var_425_10 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play325011104 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 325011104
		arg_426_1.duration_ = 2.5

		local var_426_0 = {
			zh = 2.5,
			ja = 2.266
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play325011105(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0.175

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_1 = arg_426_1:GetWordFromCfg(325011104)
				local var_429_2 = arg_426_1:FormatText(var_429_1.content)

				arg_426_1.text_.text = var_429_2

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_4 = 7 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_2) / 7)

				if (7 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_2) / 7)) > 0 and var_429_0 < var_429_4 then
					arg_426_1.talkMaxDuration = var_429_4

					if var_429_4 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_4 + 0
					end
				end

				arg_426_1.text_.text = var_429_2
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011104", "story_v_out_325011.awb") ~= 0 then
					local var_429_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011104", "story_v_out_325011.awb") / 1000

					if var_429_5 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_5 + 0
					end

					if var_429_1.prefab_name ~= "" and arg_426_1.actors_[var_429_1.prefab_name] ~= nil then
						local var_429_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_1.prefab_name].transform, "story_v_out_325011", "325011104", "story_v_out_325011.awb")

						arg_426_1:RecordAudio("325011104", var_429_6)
						arg_426_1:RecordAudio("325011104", var_429_6)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_325011", "325011104", "story_v_out_325011.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_325011", "325011104", "story_v_out_325011.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_7 = math.max(var_429_0, arg_426_1.talkMaxDuration)

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_7 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - 0) / var_429_7

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= 0 + var_429_7 and arg_426_1.time_ < 0 + var_429_7 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play325011105 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 325011105
		arg_430_1.duration_ = 2.13

		local var_430_0 = {
			zh = 1.999999999999,
			ja = 2.133
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play325011106(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(arg_430_1.actors_["1077ui_story"]) and arg_430_1.var_.characterEffect1077ui_story == nil then
				arg_430_1.var_.characterEffect1077ui_story = arg_430_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_0 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 and not isNil(arg_430_1.actors_["1077ui_story"]) then
				if arg_430_1.var_.characterEffect1077ui_story and not isNil(arg_430_1.actors_["1077ui_story"]) then
					arg_430_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 and not isNil(arg_430_1.actors_["1077ui_story"]) and arg_430_1.var_.characterEffect1077ui_story then
				arg_430_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_433_2 = arg_430_1.actors_["1077ui_story"].transform

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1077ui_story = var_433_2.localPosition

				local var_433_3 = GameObjectTools.GetOrAddComponent(var_433_2.gameObject, typeof(DynamicBoneHelper))

				if var_433_3 then
					var_433_3:EnableDynamicBone(false)
				end
			end

			local var_433_4 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_4 then
				var_433_2.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_430_1.time_ - 0) / var_433_4)
				var_433_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_433_2.position).x, (manager.ui.mainCamera.transform.position - var_433_2.position).y, (manager.ui.mainCamera.transform.position - var_433_2.position).z)
				var_433_2.localEulerAngles.z = 0
				var_433_2.localEulerAngles.x = 0
				var_433_2.localEulerAngles = var_433_2.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_4 and arg_430_1.time_ < 0 + var_433_4 + arg_433_0 then
				var_433_2.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_433_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_433_2.position).x, (manager.ui.mainCamera.transform.position - var_433_2.position).y, (manager.ui.mainCamera.transform.position - var_433_2.position).z)
				var_433_2.localEulerAngles.z = 0
				var_433_2.localEulerAngles.x = 0
				var_433_2.localEulerAngles = var_433_2.localEulerAngles

				local var_433_5 = GameObjectTools.GetOrAddComponent(var_433_2.gameObject, typeof(DynamicBoneHelper))

				if var_433_5 then
					var_433_5:EnableDynamicBone(true)
				end
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action4_2")
			end

			local var_433_6 = 0
			local var_433_7 = 0.15

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_6 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_8 = arg_430_1:GetWordFromCfg(325011105)
				local var_433_9 = arg_430_1:FormatText(var_433_8.content)

				arg_430_1.text_.text = var_433_9

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_11 = 6 <= 0 and var_433_7 or var_433_7 * (utf8.len(var_433_9) / 6)

				if (6 <= 0 and var_433_7 or var_433_7 * (utf8.len(var_433_9) / 6)) > 0 and var_433_7 < var_433_11 then
					arg_430_1.talkMaxDuration = var_433_11

					if var_433_11 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_11 + var_433_6
					end
				end

				arg_430_1.text_.text = var_433_9
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011105", "story_v_out_325011.awb") ~= 0 then
					local var_433_12 = manager.audio:GetVoiceLength("story_v_out_325011", "325011105", "story_v_out_325011.awb") / 1000

					if var_433_12 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_12 + var_433_6
					end

					if var_433_8.prefab_name ~= "" and arg_430_1.actors_[var_433_8.prefab_name] ~= nil then
						local var_433_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_8.prefab_name].transform, "story_v_out_325011", "325011105", "story_v_out_325011.awb")

						arg_430_1:RecordAudio("325011105", var_433_13)
						arg_430_1:RecordAudio("325011105", var_433_13)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_325011", "325011105", "story_v_out_325011.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_325011", "325011105", "story_v_out_325011.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_14 = math.max(var_433_7, arg_430_1.talkMaxDuration)

			if var_433_6 <= arg_430_1.time_ and arg_430_1.time_ < var_433_6 + var_433_14 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_6) / var_433_14

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_6 + var_433_14 and arg_430_1.time_ < var_433_6 + var_433_14 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play325011106 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 325011106
		arg_434_1.duration_ = 15.1

		local var_434_0 = {
			zh = 10.8,
			ja = 15.1
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play325011107(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(arg_434_1.actors_["1077ui_story"]) and arg_434_1.var_.characterEffect1077ui_story == nil then
				arg_434_1.var_.characterEffect1077ui_story = arg_434_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_0 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 and not isNil(arg_434_1.actors_["1077ui_story"]) then
				if arg_434_1.var_.characterEffect1077ui_story and not isNil(arg_434_1.actors_["1077ui_story"]) then
					arg_434_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_434_1.time_ - 0) / var_437_0)
				end
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 and not isNil(arg_434_1.actors_["1077ui_story"]) and arg_434_1.var_.characterEffect1077ui_story then
				arg_434_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_437_1 = 0
			local var_437_2 = 1

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_3 = arg_434_1:GetWordFromCfg(325011106)
				local var_437_4 = arg_434_1:FormatText(var_437_3.content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_6 = 40 <= 0 and var_437_2 or var_437_2 * (utf8.len(var_437_4) / 40)

				if (40 <= 0 and var_437_2 or var_437_2 * (utf8.len(var_437_4) / 40)) > 0 and var_437_2 < var_437_6 then
					arg_434_1.talkMaxDuration = var_437_6

					if var_437_6 + var_437_1 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_6 + var_437_1
					end
				end

				arg_434_1.text_.text = var_437_4
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011106", "story_v_out_325011.awb") ~= 0 then
					local var_437_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011106", "story_v_out_325011.awb") / 1000

					if var_437_7 + var_437_1 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_7 + var_437_1
					end

					if var_437_3.prefab_name ~= "" and arg_434_1.actors_[var_437_3.prefab_name] ~= nil then
						local var_437_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_3.prefab_name].transform, "story_v_out_325011", "325011106", "story_v_out_325011.awb")

						arg_434_1:RecordAudio("325011106", var_437_8)
						arg_434_1:RecordAudio("325011106", var_437_8)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_325011", "325011106", "story_v_out_325011.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_325011", "325011106", "story_v_out_325011.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_9 = math.max(var_437_2, arg_434_1.talkMaxDuration)

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_9 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_1) / var_437_9

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_1 + var_437_9 and arg_434_1.time_ < var_437_1 + var_437_9 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play325011107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 325011107
		arg_438_1.duration_ = 9.3

		local var_438_0 = {
			zh = 7.9,
			ja = 9.3
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play325011108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0.775

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_1 = arg_438_1:GetWordFromCfg(325011107)
				local var_441_2 = arg_438_1:FormatText(var_441_1.content)

				arg_438_1.text_.text = var_441_2

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_4 = 31 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 31)

				if (31 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 31)) > 0 and var_441_0 < var_441_4 then
					arg_438_1.talkMaxDuration = var_441_4

					if var_441_4 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_4 + 0
					end
				end

				arg_438_1.text_.text = var_441_2
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011107", "story_v_out_325011.awb") ~= 0 then
					local var_441_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011107", "story_v_out_325011.awb") / 1000

					if var_441_5 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_5 + 0
					end

					if var_441_1.prefab_name ~= "" and arg_438_1.actors_[var_441_1.prefab_name] ~= nil then
						local var_441_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_1.prefab_name].transform, "story_v_out_325011", "325011107", "story_v_out_325011.awb")

						arg_438_1:RecordAudio("325011107", var_441_6)
						arg_438_1:RecordAudio("325011107", var_441_6)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_325011", "325011107", "story_v_out_325011.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_325011", "325011107", "story_v_out_325011.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_7 = math.max(var_441_0, arg_438_1.talkMaxDuration)

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_7 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - 0) / var_441_7

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= 0 + var_441_7 and arg_438_1.time_ < 0 + var_441_7 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play325011108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 325011108
		arg_442_1.duration_ = 5.93

		local var_442_0 = {
			zh = 5.833,
			ja = 5.933
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play325011109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(arg_442_1.actors_["1077ui_story"]) and arg_442_1.var_.characterEffect1077ui_story == nil then
				arg_442_1.var_.characterEffect1077ui_story = arg_442_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_0 = 0.200000002980232

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 and not isNil(arg_442_1.actors_["1077ui_story"]) then
				if arg_442_1.var_.characterEffect1077ui_story and not isNil(arg_442_1.actors_["1077ui_story"]) then
					arg_442_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 and not isNil(arg_442_1.actors_["1077ui_story"]) and arg_442_1.var_.characterEffect1077ui_story then
				arg_442_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_445_2 = 0
			local var_445_3 = 0.65

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_2 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_4 = arg_442_1:GetWordFromCfg(325011108)
				local var_445_5 = arg_442_1:FormatText(var_445_4.content)

				arg_442_1.text_.text = var_445_5

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_7 = 26 <= 0 and var_445_3 or var_445_3 * (utf8.len(var_445_5) / 26)

				if (26 <= 0 and var_445_3 or var_445_3 * (utf8.len(var_445_5) / 26)) > 0 and var_445_3 < var_445_7 then
					arg_442_1.talkMaxDuration = var_445_7

					if var_445_7 + var_445_2 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_7 + var_445_2
					end
				end

				arg_442_1.text_.text = var_445_5
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011108", "story_v_out_325011.awb") ~= 0 then
					local var_445_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011108", "story_v_out_325011.awb") / 1000

					if var_445_8 + var_445_2 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_8 + var_445_2
					end

					if var_445_4.prefab_name ~= "" and arg_442_1.actors_[var_445_4.prefab_name] ~= nil then
						local var_445_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_4.prefab_name].transform, "story_v_out_325011", "325011108", "story_v_out_325011.awb")

						arg_442_1:RecordAudio("325011108", var_445_9)
						arg_442_1:RecordAudio("325011108", var_445_9)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_325011", "325011108", "story_v_out_325011.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_325011", "325011108", "story_v_out_325011.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_10 = math.max(var_445_3, arg_442_1.talkMaxDuration)

			if var_445_2 <= arg_442_1.time_ and arg_442_1.time_ < var_445_2 + var_445_10 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_2) / var_445_10

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_2 + var_445_10 and arg_442_1.time_ < var_445_2 + var_445_10 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play325011109 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 325011109
		arg_446_1.duration_ = 7.43

		local var_446_0 = {
			zh = 7,
			ja = 7.433
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play325011110(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(arg_446_1.actors_["1077ui_story"]) and arg_446_1.var_.characterEffect1077ui_story == nil then
				arg_446_1.var_.characterEffect1077ui_story = arg_446_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_0 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 and not isNil(arg_446_1.actors_["1077ui_story"]) then
				if arg_446_1.var_.characterEffect1077ui_story and not isNil(arg_446_1.actors_["1077ui_story"]) then
					arg_446_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_446_1.time_ - 0) / var_449_0)
				end
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 and not isNil(arg_446_1.actors_["1077ui_story"]) and arg_446_1.var_.characterEffect1077ui_story then
				arg_446_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_449_1 = 0
			local var_449_2 = 0.55

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_3 = arg_446_1:GetWordFromCfg(325011109)
				local var_449_4 = arg_446_1:FormatText(var_449_3.content)

				arg_446_1.text_.text = var_449_4

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_6 = 22 <= 0 and var_449_2 or var_449_2 * (utf8.len(var_449_4) / 22)

				if (22 <= 0 and var_449_2 or var_449_2 * (utf8.len(var_449_4) / 22)) > 0 and var_449_2 < var_449_6 then
					arg_446_1.talkMaxDuration = var_449_6

					if var_449_6 + var_449_1 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_6 + var_449_1
					end
				end

				arg_446_1.text_.text = var_449_4
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011109", "story_v_out_325011.awb") ~= 0 then
					local var_449_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011109", "story_v_out_325011.awb") / 1000

					if var_449_7 + var_449_1 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_7 + var_449_1
					end

					if var_449_3.prefab_name ~= "" and arg_446_1.actors_[var_449_3.prefab_name] ~= nil then
						local var_449_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_3.prefab_name].transform, "story_v_out_325011", "325011109", "story_v_out_325011.awb")

						arg_446_1:RecordAudio("325011109", var_449_8)
						arg_446_1:RecordAudio("325011109", var_449_8)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_325011", "325011109", "story_v_out_325011.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_325011", "325011109", "story_v_out_325011.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_9 = math.max(var_449_2, arg_446_1.talkMaxDuration)

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_9 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_1) / var_449_9

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_1 + var_449_9 and arg_446_1.time_ < var_449_1 + var_449_9 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play325011110 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 325011110
		arg_450_1.duration_ = 9

		local var_450_0 = {
			zh = 9,
			ja = 5.3
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play325011111(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0.6

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_1 = arg_450_1:GetWordFromCfg(325011110)
				local var_453_2 = arg_450_1:FormatText(var_453_1.content)

				arg_450_1.text_.text = var_453_2

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_4 = 24 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 24)

				if (24 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 24)) > 0 and var_453_0 < var_453_4 then
					arg_450_1.talkMaxDuration = var_453_4

					if var_453_4 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_4 + 0
					end
				end

				arg_450_1.text_.text = var_453_2
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011110", "story_v_out_325011.awb") ~= 0 then
					local var_453_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011110", "story_v_out_325011.awb") / 1000

					if var_453_5 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + 0
					end

					if var_453_1.prefab_name ~= "" and arg_450_1.actors_[var_453_1.prefab_name] ~= nil then
						local var_453_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_1.prefab_name].transform, "story_v_out_325011", "325011110", "story_v_out_325011.awb")

						arg_450_1:RecordAudio("325011110", var_453_6)
						arg_450_1:RecordAudio("325011110", var_453_6)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_325011", "325011110", "story_v_out_325011.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_325011", "325011110", "story_v_out_325011.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_7 = math.max(var_453_0, arg_450_1.talkMaxDuration)

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_7 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - 0) / var_453_7

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= 0 + var_453_7 and arg_450_1.time_ < 0 + var_453_7 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play325011111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 325011111
		arg_454_1.duration_ = 3.43

		local var_454_0 = {
			zh = 3.433,
			ja = 2.033
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play325011112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(arg_454_1.actors_["1077ui_story"]) and arg_454_1.var_.characterEffect1077ui_story == nil then
				arg_454_1.var_.characterEffect1077ui_story = arg_454_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_0 = 0.200000002980232

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 and not isNil(arg_454_1.actors_["1077ui_story"]) then
				if arg_454_1.var_.characterEffect1077ui_story and not isNil(arg_454_1.actors_["1077ui_story"]) then
					arg_454_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 and not isNil(arg_454_1.actors_["1077ui_story"]) and arg_454_1.var_.characterEffect1077ui_story then
				arg_454_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_1")
			end

			local var_457_2 = 0
			local var_457_3 = 0.375

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_2 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_4 = arg_454_1:GetWordFromCfg(325011111)
				local var_457_5 = arg_454_1:FormatText(var_457_4.content)

				arg_454_1.text_.text = var_457_5

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_7 = 15 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 15)

				if (15 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 15)) > 0 and var_457_3 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_2
					end
				end

				arg_454_1.text_.text = var_457_5
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011111", "story_v_out_325011.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011111", "story_v_out_325011.awb") / 1000

					if var_457_8 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_2
					end

					if var_457_4.prefab_name ~= "" and arg_454_1.actors_[var_457_4.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_4.prefab_name].transform, "story_v_out_325011", "325011111", "story_v_out_325011.awb")

						arg_454_1:RecordAudio("325011111", var_457_9)
						arg_454_1:RecordAudio("325011111", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_325011", "325011111", "story_v_out_325011.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_325011", "325011111", "story_v_out_325011.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_10 = math.max(var_457_3, arg_454_1.talkMaxDuration)

			if var_457_2 <= arg_454_1.time_ and arg_454_1.time_ < var_457_2 + var_457_10 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_2) / var_457_10

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_2 + var_457_10 and arg_454_1.time_ < var_457_2 + var_457_10 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play325011112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 325011112
		arg_458_1.duration_ = 7.7

		local var_458_0 = {
			zh = 6.733,
			ja = 7.7
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play325011113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["1077ui_story"]) and arg_458_1.var_.characterEffect1077ui_story == nil then
				arg_458_1.var_.characterEffect1077ui_story = arg_458_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["1077ui_story"]) then
				if arg_458_1.var_.characterEffect1077ui_story and not isNil(arg_458_1.actors_["1077ui_story"]) then
					arg_458_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_0)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["1077ui_story"]) and arg_458_1.var_.characterEffect1077ui_story then
				arg_458_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_461_1 = 0
			local var_461_2 = 0.6

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_3 = arg_458_1:GetWordFromCfg(325011112)
				local var_461_4 = arg_458_1:FormatText(var_461_3.content)

				arg_458_1.text_.text = var_461_4

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_6 = 24 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_4) / 24)

				if (24 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_4) / 24)) > 0 and var_461_2 < var_461_6 then
					arg_458_1.talkMaxDuration = var_461_6

					if var_461_6 + var_461_1 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_6 + var_461_1
					end
				end

				arg_458_1.text_.text = var_461_4
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011112", "story_v_out_325011.awb") ~= 0 then
					local var_461_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011112", "story_v_out_325011.awb") / 1000

					if var_461_7 + var_461_1 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_7 + var_461_1
					end

					if var_461_3.prefab_name ~= "" and arg_458_1.actors_[var_461_3.prefab_name] ~= nil then
						local var_461_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_3.prefab_name].transform, "story_v_out_325011", "325011112", "story_v_out_325011.awb")

						arg_458_1:RecordAudio("325011112", var_461_8)
						arg_458_1:RecordAudio("325011112", var_461_8)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_325011", "325011112", "story_v_out_325011.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_325011", "325011112", "story_v_out_325011.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_9 = math.max(var_461_2, arg_458_1.talkMaxDuration)

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_9 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_1) / var_461_9

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_1 + var_461_9 and arg_458_1.time_ < var_461_1 + var_461_9 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play325011113 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 325011113
		arg_462_1.duration_ = 12.33

		local var_462_0 = {
			zh = 8.1,
			ja = 12.333
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play325011114(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(arg_462_1.actors_["1077ui_story"]) and arg_462_1.var_.characterEffect1077ui_story == nil then
				arg_462_1.var_.characterEffect1077ui_story = arg_462_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_0 = 0.200000002980232

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 and not isNil(arg_462_1.actors_["1077ui_story"]) then
				if arg_462_1.var_.characterEffect1077ui_story and not isNil(arg_462_1.actors_["1077ui_story"]) then
					arg_462_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 and not isNil(arg_462_1.actors_["1077ui_story"]) and arg_462_1.var_.characterEffect1077ui_story then
				arg_462_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_2")
			end

			local var_465_2 = 0
			local var_465_3 = 1.025

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_2 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_4 = arg_462_1:GetWordFromCfg(325011113)
				local var_465_5 = arg_462_1:FormatText(var_465_4.content)

				arg_462_1.text_.text = var_465_5

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_7 = 41 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_5) / 41)

				if (41 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_5) / 41)) > 0 and var_465_3 < var_465_7 then
					arg_462_1.talkMaxDuration = var_465_7

					if var_465_7 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_7 + var_465_2
					end
				end

				arg_462_1.text_.text = var_465_5
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011113", "story_v_out_325011.awb") ~= 0 then
					local var_465_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011113", "story_v_out_325011.awb") / 1000

					if var_465_8 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_8 + var_465_2
					end

					if var_465_4.prefab_name ~= "" and arg_462_1.actors_[var_465_4.prefab_name] ~= nil then
						local var_465_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_4.prefab_name].transform, "story_v_out_325011", "325011113", "story_v_out_325011.awb")

						arg_462_1:RecordAudio("325011113", var_465_9)
						arg_462_1:RecordAudio("325011113", var_465_9)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_325011", "325011113", "story_v_out_325011.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_325011", "325011113", "story_v_out_325011.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_10 = math.max(var_465_3, arg_462_1.talkMaxDuration)

			if var_465_2 <= arg_462_1.time_ and arg_462_1.time_ < var_465_2 + var_465_10 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_2) / var_465_10

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_2 + var_465_10 and arg_462_1.time_ < var_465_2 + var_465_10 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play325011114 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 325011114
		arg_466_1.duration_ = 9.83

		local var_466_0 = {
			zh = 9.633,
			ja = 9.833
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play325011115(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["1077ui_story"]) and arg_466_1.var_.characterEffect1077ui_story == nil then
				arg_466_1.var_.characterEffect1077ui_story = arg_466_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_0 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["1077ui_story"]) then
				if arg_466_1.var_.characterEffect1077ui_story and not isNil(arg_466_1.actors_["1077ui_story"]) then
					arg_466_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_466_1.time_ - 0) / var_469_0)
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["1077ui_story"]) and arg_466_1.var_.characterEffect1077ui_story then
				arg_466_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_469_1 = 0
			local var_469_2 = 0.875

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_3 = arg_466_1:GetWordFromCfg(325011114)
				local var_469_4 = arg_466_1:FormatText(var_469_3.content)

				arg_466_1.text_.text = var_469_4

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_6 = 35 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_4) / 35)

				if (35 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_4) / 35)) > 0 and var_469_2 < var_469_6 then
					arg_466_1.talkMaxDuration = var_469_6

					if var_469_6 + var_469_1 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_6 + var_469_1
					end
				end

				arg_466_1.text_.text = var_469_4
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011114", "story_v_out_325011.awb") ~= 0 then
					local var_469_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011114", "story_v_out_325011.awb") / 1000

					if var_469_7 + var_469_1 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_7 + var_469_1
					end

					if var_469_3.prefab_name ~= "" and arg_466_1.actors_[var_469_3.prefab_name] ~= nil then
						local var_469_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_3.prefab_name].transform, "story_v_out_325011", "325011114", "story_v_out_325011.awb")

						arg_466_1:RecordAudio("325011114", var_469_8)
						arg_466_1:RecordAudio("325011114", var_469_8)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_325011", "325011114", "story_v_out_325011.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_325011", "325011114", "story_v_out_325011.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_9 = math.max(var_469_2, arg_466_1.talkMaxDuration)

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_9 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_1) / var_469_9

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_1 + var_469_9 and arg_466_1.time_ < var_469_1 + var_469_9 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play325011115 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 325011115
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play325011116(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos1077ui_story = arg_470_1.actors_["1077ui_story"].transform.localPosition

				local var_473_0 = GameObjectTools.GetOrAddComponent(arg_470_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_473_0 then
					var_473_0:EnableDynamicBone(false)
				end
			end

			local var_473_1 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_1 then
				arg_470_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_470_1.time_ - 0) / var_473_1)
				arg_470_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1077ui_story"].transform.position).z)
				arg_470_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1077ui_story"].transform.localEulerAngles = arg_470_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_1 and arg_470_1.time_ < 0 + var_473_1 + arg_473_0 then
				arg_470_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_470_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1077ui_story"].transform.position).z)
				arg_470_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1077ui_story"].transform.localEulerAngles = arg_470_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_473_2 = GameObjectTools.GetOrAddComponent(arg_470_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_473_2 then
					var_473_2:EnableDynamicBone(true)
				end
			end

			local var_473_3 = 0
			local var_473_4 = 1.275

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_3 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_5 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(325011115).content)

				arg_470_1.text_.text = var_473_5

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_7 = 51 <= 0 and var_473_4 or var_473_4 * (utf8.len(var_473_5) / 51)

				if (51 <= 0 and var_473_4 or var_473_4 * (utf8.len(var_473_5) / 51)) > 0 and var_473_4 < var_473_7 then
					arg_470_1.talkMaxDuration = var_473_7

					if var_473_7 + var_473_3 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_7 + var_473_3
					end
				end

				arg_470_1.text_.text = var_473_5
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_8 = math.max(var_473_4, arg_470_1.talkMaxDuration)

			if var_473_3 <= arg_470_1.time_ and arg_470_1.time_ < var_473_3 + var_473_8 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_3) / var_473_8

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_3 + var_473_8 and arg_470_1.time_ < var_473_3 + var_473_8 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play325011116 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 325011116
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play325011117(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0.85

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_1 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(325011116).content)

				arg_474_1.text_.text = var_477_1

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_3 = 34 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_1) / 34)

				if (34 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_1) / 34)) > 0 and var_477_0 < var_477_3 then
					arg_474_1.talkMaxDuration = var_477_3

					if var_477_3 + 0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_3 + 0
					end
				end

				arg_474_1.text_.text = var_477_1
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_4 = math.max(var_477_0, arg_474_1.talkMaxDuration)

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_4 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - 0) / var_477_4

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= 0 + var_477_4 and arg_474_1.time_ < 0 + var_477_4 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play325011117 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 325011117
		arg_478_1.duration_ = 2

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play325011118(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if arg_478_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_481_0 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_478_1.stage_.transform)

				var_481_0.name = "1069ui_story"
				var_481_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_478_1.actors_["1069ui_story"] = var_481_0

				local var_481_1 = var_481_0:GetComponentInChildren(typeof(CharacterEffect))

				var_481_1.enabled = true

				local var_481_2 = GameObjectTools.GetOrAddComponent(var_481_0, typeof(DynamicBoneHelper))

				if var_481_2 then
					var_481_2:EnableDynamicBone(false)
				end

				arg_478_1:ShowWeapon(var_481_1.transform, false)

				arg_478_1.var_["1069ui_story" .. "Animator"] = var_481_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_478_1.var_["1069ui_story" .. "Animator"].applyRootMotion = true
				arg_478_1.var_["1069ui_story" .. "LipSync"] = var_481_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_481_3 = arg_478_1.actors_["1069ui_story"].transform

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.var_.moveOldPos1069ui_story = var_481_3.localPosition
			end

			local var_481_4 = 0.001

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_4 then
				var_481_3.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_478_1.time_ - 0) / var_481_4)
				var_481_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_481_3.position).x, (manager.ui.mainCamera.transform.position - var_481_3.position).y, (manager.ui.mainCamera.transform.position - var_481_3.position).z)
				var_481_3.localEulerAngles.z = 0
				var_481_3.localEulerAngles.x = 0
				var_481_3.localEulerAngles = var_481_3.localEulerAngles
			end

			if arg_478_1.time_ >= 0 + var_481_4 and arg_478_1.time_ < 0 + var_481_4 + arg_481_0 then
				var_481_3.localPosition = Vector3.New(0, -1, -6)
				var_481_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_481_3.position).x, (manager.ui.mainCamera.transform.position - var_481_3.position).y, (manager.ui.mainCamera.transform.position - var_481_3.position).z)
				var_481_3.localEulerAngles.z = 0
				var_481_3.localEulerAngles.x = 0
				var_481_3.localEulerAngles = var_481_3.localEulerAngles
			end

			local var_481_5 = arg_478_1.actors_["1069ui_story"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_5) and arg_478_1.var_.characterEffect1069ui_story == nil then
				arg_478_1.var_.characterEffect1069ui_story = var_481_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_6 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_6 and not isNil(var_481_5) then
				if arg_478_1.var_.characterEffect1069ui_story and not isNil(var_481_5) then
					arg_478_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= 0 + var_481_6 and arg_478_1.time_ < 0 + var_481_6 + arg_481_0 and not isNil(var_481_5) and arg_478_1.var_.characterEffect1069ui_story then
				arg_478_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_481_8 = 0
			local var_481_9 = 0.075

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_8 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_10 = arg_478_1:GetWordFromCfg(325011117)
				local var_481_11 = arg_478_1:FormatText(var_481_10.content)

				arg_478_1.text_.text = var_481_11

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_13 = 3 <= 0 and var_481_9 or var_481_9 * (utf8.len(var_481_11) / 3)

				if (3 <= 0 and var_481_9 or var_481_9 * (utf8.len(var_481_11) / 3)) > 0 and var_481_9 < var_481_13 then
					arg_478_1.talkMaxDuration = var_481_13

					if var_481_13 + var_481_8 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_13 + var_481_8
					end
				end

				arg_478_1.text_.text = var_481_11
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011117", "story_v_out_325011.awb") ~= 0 then
					local var_481_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011117", "story_v_out_325011.awb") / 1000

					if var_481_14 + var_481_8 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_14 + var_481_8
					end

					if var_481_10.prefab_name ~= "" and arg_478_1.actors_[var_481_10.prefab_name] ~= nil then
						local var_481_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_10.prefab_name].transform, "story_v_out_325011", "325011117", "story_v_out_325011.awb")

						arg_478_1:RecordAudio("325011117", var_481_15)
						arg_478_1:RecordAudio("325011117", var_481_15)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_325011", "325011117", "story_v_out_325011.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_325011", "325011117", "story_v_out_325011.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_16 = math.max(var_481_9, arg_478_1.talkMaxDuration)

			if var_481_8 <= arg_478_1.time_ and arg_478_1.time_ < var_481_8 + var_481_16 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_8) / var_481_16

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_8 + var_481_16 and arg_478_1.time_ < var_481_8 + var_481_16 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_478_1:InitPlayNodeList()
	end,
	Play325011118 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 325011118
		arg_482_1.duration_ = 4.43

		local var_482_0 = {
			zh = 2.766,
			ja = 4.433
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play325011119(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(arg_482_1.actors_["1069ui_story"]) and arg_482_1.var_.characterEffect1069ui_story == nil then
				arg_482_1.var_.characterEffect1069ui_story = arg_482_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_0 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 and not isNil(arg_482_1.actors_["1069ui_story"]) then
				if arg_482_1.var_.characterEffect1069ui_story and not isNil(arg_482_1.actors_["1069ui_story"]) then
					arg_482_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_482_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_482_1.time_ - 0) / var_485_0)
				end
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 and not isNil(arg_482_1.actors_["1069ui_story"]) and arg_482_1.var_.characterEffect1069ui_story then
				arg_482_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_482_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_485_1 = 0
			local var_485_2 = 0.2

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_3 = arg_482_1:GetWordFromCfg(325011118)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_6 = 8 <= 0 and var_485_2 or var_485_2 * (utf8.len(var_485_4) / 8)

				if (8 <= 0 and var_485_2 or var_485_2 * (utf8.len(var_485_4) / 8)) > 0 and var_485_2 < var_485_6 then
					arg_482_1.talkMaxDuration = var_485_6

					if var_485_6 + var_485_1 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_6 + var_485_1
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011118", "story_v_out_325011.awb") ~= 0 then
					local var_485_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011118", "story_v_out_325011.awb") / 1000

					if var_485_7 + var_485_1 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_1
					end

					if var_485_3.prefab_name ~= "" and arg_482_1.actors_[var_485_3.prefab_name] ~= nil then
						local var_485_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_3.prefab_name].transform, "story_v_out_325011", "325011118", "story_v_out_325011.awb")

						arg_482_1:RecordAudio("325011118", var_485_8)
						arg_482_1:RecordAudio("325011118", var_485_8)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_325011", "325011118", "story_v_out_325011.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_325011", "325011118", "story_v_out_325011.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_9 = math.max(var_485_2, arg_482_1.talkMaxDuration)

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_9 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_1) / var_485_9

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_1 + var_485_9 and arg_482_1.time_ < var_485_1 + var_485_9 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play325011119 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 325011119
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play325011120(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.var_.moveOldPos1069ui_story = arg_486_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_489_0 = 0.001

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 then
				arg_486_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_486_1.time_ - 0) / var_489_0)
				arg_486_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_486_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1069ui_story"].transform.position).z)
				arg_486_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_486_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_486_1.actors_["1069ui_story"].transform.localEulerAngles = arg_486_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 then
				arg_486_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_486_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_486_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1069ui_story"].transform.position).z)
				arg_486_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_486_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_486_1.actors_["1069ui_story"].transform.localEulerAngles = arg_486_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_489_1 = arg_486_1.actors_["1069ui_story"]

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(var_489_1) and arg_486_1.var_.characterEffect1069ui_story == nil then
				arg_486_1.var_.characterEffect1069ui_story = var_489_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_2 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_2 and not isNil(var_489_1) then
				if arg_486_1.var_.characterEffect1069ui_story and not isNil(var_489_1) then
					arg_486_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= 0 + var_489_2 and arg_486_1.time_ < 0 + var_489_2 + arg_489_0 and not isNil(var_489_1) and arg_486_1.var_.characterEffect1069ui_story then
				arg_486_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0.3 < arg_486_1.time_ and arg_486_1.time_ <= 0.3 + arg_489_0 then
				arg_486_1:AudioAction("play", "effect", "se_story_148", "se_story_148_footstep_crowd", "")
			end

			local var_489_5 = 0
			local var_489_6 = 1.175

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_5 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_7 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(325011119).content)

				arg_486_1.text_.text = var_489_7

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_9 = 47 <= 0 and var_489_6 or var_489_6 * (utf8.len(var_489_7) / 47)

				if (47 <= 0 and var_489_6 or var_489_6 * (utf8.len(var_489_7) / 47)) > 0 and var_489_6 < var_489_9 then
					arg_486_1.talkMaxDuration = var_489_9

					if var_489_9 + var_489_5 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_9 + var_489_5
					end
				end

				arg_486_1.text_.text = var_489_7
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_10 = math.max(var_489_6, arg_486_1.talkMaxDuration)

			if var_489_5 <= arg_486_1.time_ and arg_486_1.time_ < var_489_5 + var_489_10 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_5) / var_489_10

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_5 + var_489_10 and arg_486_1.time_ < var_489_5 + var_489_10 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_486_1:InitPlayNodeList()
	end,
	Play325011120 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 325011120
		arg_490_1.duration_ = 6.7

		local var_490_0 = {
			zh = 3.7,
			ja = 6.7
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play325011121(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(arg_490_1.actors_["1069ui_story"]) and arg_490_1.var_.characterEffect1069ui_story == nil then
				arg_490_1.var_.characterEffect1069ui_story = arg_490_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_0 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 and not isNil(arg_490_1.actors_["1069ui_story"]) then
				if arg_490_1.var_.characterEffect1069ui_story and not isNil(arg_490_1.actors_["1069ui_story"]) then
					arg_490_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 and not isNil(arg_490_1.actors_["1069ui_story"]) and arg_490_1.var_.characterEffect1069ui_story then
				arg_490_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_493_2 = arg_490_1.actors_["1069ui_story"].transform

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.var_.moveOldPos1069ui_story = var_493_2.localPosition
			end

			local var_493_3 = 0.001

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_3 then
				var_493_2.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_490_1.time_ - 0) / var_493_3)
				var_493_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_493_2.position).x, (manager.ui.mainCamera.transform.position - var_493_2.position).y, (manager.ui.mainCamera.transform.position - var_493_2.position).z)
				var_493_2.localEulerAngles.z = 0
				var_493_2.localEulerAngles.x = 0
				var_493_2.localEulerAngles = var_493_2.localEulerAngles
			end

			if arg_490_1.time_ >= 0 + var_493_3 and arg_490_1.time_ < 0 + var_493_3 + arg_493_0 then
				var_493_2.localPosition = Vector3.New(0, -1, -6)
				var_493_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_493_2.position).x, (manager.ui.mainCamera.transform.position - var_493_2.position).y, (manager.ui.mainCamera.transform.position - var_493_2.position).z)
				var_493_2.localEulerAngles.z = 0
				var_493_2.localEulerAngles.x = 0
				var_493_2.localEulerAngles = var_493_2.localEulerAngles
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_2")
			end

			local var_493_4 = 0
			local var_493_5 = 0.5

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_4 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_6 = arg_490_1:GetWordFromCfg(325011120)
				local var_493_7 = arg_490_1:FormatText(var_493_6.content)

				arg_490_1.text_.text = var_493_7

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_9 = 20 <= 0 and var_493_5 or var_493_5 * (utf8.len(var_493_7) / 20)

				if (20 <= 0 and var_493_5 or var_493_5 * (utf8.len(var_493_7) / 20)) > 0 and var_493_5 < var_493_9 then
					arg_490_1.talkMaxDuration = var_493_9

					if var_493_9 + var_493_4 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_9 + var_493_4
					end
				end

				arg_490_1.text_.text = var_493_7
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011120", "story_v_out_325011.awb") ~= 0 then
					local var_493_10 = manager.audio:GetVoiceLength("story_v_out_325011", "325011120", "story_v_out_325011.awb") / 1000

					if var_493_10 + var_493_4 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_10 + var_493_4
					end

					if var_493_6.prefab_name ~= "" and arg_490_1.actors_[var_493_6.prefab_name] ~= nil then
						local var_493_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_6.prefab_name].transform, "story_v_out_325011", "325011120", "story_v_out_325011.awb")

						arg_490_1:RecordAudio("325011120", var_493_11)
						arg_490_1:RecordAudio("325011120", var_493_11)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_325011", "325011120", "story_v_out_325011.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_325011", "325011120", "story_v_out_325011.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_12 = math.max(var_493_5, arg_490_1.talkMaxDuration)

			if var_493_4 <= arg_490_1.time_ and arg_490_1.time_ < var_493_4 + var_493_12 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_4) / var_493_12

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_4 + var_493_12 and arg_490_1.time_ < var_493_4 + var_493_12 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play325011121 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 325011121
		arg_494_1.duration_ = 4.4

		local var_494_0 = {
			zh = 4.4,
			ja = 3.433
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play325011122(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(arg_494_1.actors_["1069ui_story"]) and arg_494_1.var_.characterEffect1069ui_story == nil then
				arg_494_1.var_.characterEffect1069ui_story = arg_494_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_0 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 and not isNil(arg_494_1.actors_["1069ui_story"]) then
				if arg_494_1.var_.characterEffect1069ui_story and not isNil(arg_494_1.actors_["1069ui_story"]) then
					arg_494_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_494_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_494_1.time_ - 0) / var_497_0)
				end
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 and not isNil(arg_494_1.actors_["1069ui_story"]) and arg_494_1.var_.characterEffect1069ui_story then
				arg_494_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_494_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_497_1 = 0
			local var_497_2 = 0.375

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_3 = arg_494_1:GetWordFromCfg(325011121)
				local var_497_4 = arg_494_1:FormatText(var_497_3.content)

				arg_494_1.text_.text = var_497_4

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_6 = 15 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_4) / 15)

				if (15 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_4) / 15)) > 0 and var_497_2 < var_497_6 then
					arg_494_1.talkMaxDuration = var_497_6

					if var_497_6 + var_497_1 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_6 + var_497_1
					end
				end

				arg_494_1.text_.text = var_497_4
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011121", "story_v_out_325011.awb") ~= 0 then
					local var_497_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011121", "story_v_out_325011.awb") / 1000

					if var_497_7 + var_497_1 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_7 + var_497_1
					end

					if var_497_3.prefab_name ~= "" and arg_494_1.actors_[var_497_3.prefab_name] ~= nil then
						local var_497_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_3.prefab_name].transform, "story_v_out_325011", "325011121", "story_v_out_325011.awb")

						arg_494_1:RecordAudio("325011121", var_497_8)
						arg_494_1:RecordAudio("325011121", var_497_8)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_325011", "325011121", "story_v_out_325011.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_325011", "325011121", "story_v_out_325011.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_9 = math.max(var_497_2, arg_494_1.talkMaxDuration)

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_9 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_1) / var_497_9

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_1 + var_497_9 and arg_494_1.time_ < var_497_1 + var_497_9 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play325011122 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 325011122
		arg_498_1.duration_ = 4.2

		local var_498_0 = {
			zh = 2.766,
			ja = 4.2
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play325011123(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(arg_498_1.actors_["1069ui_story"]) and arg_498_1.var_.characterEffect1069ui_story == nil then
				arg_498_1.var_.characterEffect1069ui_story = arg_498_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_0 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 and not isNil(arg_498_1.actors_["1069ui_story"]) then
				if arg_498_1.var_.characterEffect1069ui_story and not isNil(arg_498_1.actors_["1069ui_story"]) then
					arg_498_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 and not isNil(arg_498_1.actors_["1069ui_story"]) and arg_498_1.var_.characterEffect1069ui_story then
				arg_498_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_501_2 = 0
			local var_501_3 = 0.325

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_2 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_4 = arg_498_1:GetWordFromCfg(325011122)
				local var_501_5 = arg_498_1:FormatText(var_501_4.content)

				arg_498_1.text_.text = var_501_5

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_7 = 13 <= 0 and var_501_3 or var_501_3 * (utf8.len(var_501_5) / 13)

				if (13 <= 0 and var_501_3 or var_501_3 * (utf8.len(var_501_5) / 13)) > 0 and var_501_3 < var_501_7 then
					arg_498_1.talkMaxDuration = var_501_7

					if var_501_7 + var_501_2 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_7 + var_501_2
					end
				end

				arg_498_1.text_.text = var_501_5
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011122", "story_v_out_325011.awb") ~= 0 then
					local var_501_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011122", "story_v_out_325011.awb") / 1000

					if var_501_8 + var_501_2 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_8 + var_501_2
					end

					if var_501_4.prefab_name ~= "" and arg_498_1.actors_[var_501_4.prefab_name] ~= nil then
						local var_501_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_4.prefab_name].transform, "story_v_out_325011", "325011122", "story_v_out_325011.awb")

						arg_498_1:RecordAudio("325011122", var_501_9)
						arg_498_1:RecordAudio("325011122", var_501_9)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_325011", "325011122", "story_v_out_325011.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_325011", "325011122", "story_v_out_325011.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_10 = math.max(var_501_3, arg_498_1.talkMaxDuration)

			if var_501_2 <= arg_498_1.time_ and arg_498_1.time_ < var_501_2 + var_501_10 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_2) / var_501_10

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_2 + var_501_10 and arg_498_1.time_ < var_501_2 + var_501_10 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play325011123 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 325011123
		arg_502_1.duration_ = 15.67

		local var_502_0 = {
			zh = 8.133,
			ja = 15.666
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play325011124(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(arg_502_1.actors_["1069ui_story"]) and arg_502_1.var_.characterEffect1069ui_story == nil then
				arg_502_1.var_.characterEffect1069ui_story = arg_502_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_0 = 0.200000002980232

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 and not isNil(arg_502_1.actors_["1069ui_story"]) then
				if arg_502_1.var_.characterEffect1069ui_story and not isNil(arg_502_1.actors_["1069ui_story"]) then
					arg_502_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_502_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_502_1.time_ - 0) / var_505_0)
				end
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 and not isNil(arg_502_1.actors_["1069ui_story"]) and arg_502_1.var_.characterEffect1069ui_story then
				arg_502_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_502_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_505_1 = 0
			local var_505_2 = 0.825

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_3 = arg_502_1:GetWordFromCfg(325011123)
				local var_505_4 = arg_502_1:FormatText(var_505_3.content)

				arg_502_1.text_.text = var_505_4

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_6 = 33 <= 0 and var_505_2 or var_505_2 * (utf8.len(var_505_4) / 33)

				if (33 <= 0 and var_505_2 or var_505_2 * (utf8.len(var_505_4) / 33)) > 0 and var_505_2 < var_505_6 then
					arg_502_1.talkMaxDuration = var_505_6

					if var_505_6 + var_505_1 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_6 + var_505_1
					end
				end

				arg_502_1.text_.text = var_505_4
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011123", "story_v_out_325011.awb") ~= 0 then
					local var_505_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011123", "story_v_out_325011.awb") / 1000

					if var_505_7 + var_505_1 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_7 + var_505_1
					end

					if var_505_3.prefab_name ~= "" and arg_502_1.actors_[var_505_3.prefab_name] ~= nil then
						local var_505_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_3.prefab_name].transform, "story_v_out_325011", "325011123", "story_v_out_325011.awb")

						arg_502_1:RecordAudio("325011123", var_505_8)
						arg_502_1:RecordAudio("325011123", var_505_8)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_325011", "325011123", "story_v_out_325011.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_325011", "325011123", "story_v_out_325011.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_9 = math.max(var_505_2, arg_502_1.talkMaxDuration)

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_9 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_1) / var_505_9

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_1 + var_505_9 and arg_502_1.time_ < var_505_1 + var_505_9 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play325011124 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 325011124
		arg_506_1.duration_ = 5.13

		local var_506_0 = {
			zh = 4.766,
			ja = 5.133
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play325011125(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.var_.moveOldPos1069ui_story = arg_506_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_509_0 = 0.001

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_0 then
				arg_506_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1069ui_story, Vector3.New(-0.7, -1, -6), (arg_506_1.time_ - 0) / var_509_0)
				arg_506_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_506_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["1069ui_story"].transform.position).z)
				arg_506_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_506_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_506_1.actors_["1069ui_story"].transform.localEulerAngles = arg_506_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_506_1.time_ >= 0 + var_509_0 and arg_506_1.time_ < 0 + var_509_0 + arg_509_0 then
				arg_506_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6)
				arg_506_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_506_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["1069ui_story"].transform.position).z)
				arg_506_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_506_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_506_1.actors_["1069ui_story"].transform.localEulerAngles = arg_506_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_509_1 = arg_506_1.actors_["1077ui_story"].transform

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.var_.moveOldPos1077ui_story = var_509_1.localPosition

				local var_509_2 = GameObjectTools.GetOrAddComponent(var_509_1.gameObject, typeof(DynamicBoneHelper))

				if var_509_2 then
					var_509_2:EnableDynamicBone(false)
				end
			end

			local var_509_3 = 0.001

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_3 then
				var_509_1.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_506_1.time_ - 0) / var_509_3)
				var_509_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_509_1.position).x, (manager.ui.mainCamera.transform.position - var_509_1.position).y, (manager.ui.mainCamera.transform.position - var_509_1.position).z)
				var_509_1.localEulerAngles.z = 0
				var_509_1.localEulerAngles.x = 0
				var_509_1.localEulerAngles = var_509_1.localEulerAngles
			end

			if arg_506_1.time_ >= 0 + var_509_3 and arg_506_1.time_ < 0 + var_509_3 + arg_509_0 then
				var_509_1.localPosition = Vector3.New(0.8, -1.02, -5.92)
				var_509_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_509_1.position).x, (manager.ui.mainCamera.transform.position - var_509_1.position).y, (manager.ui.mainCamera.transform.position - var_509_1.position).z)
				var_509_1.localEulerAngles.z = 0
				var_509_1.localEulerAngles.x = 0
				var_509_1.localEulerAngles = var_509_1.localEulerAngles

				local var_509_4 = GameObjectTools.GetOrAddComponent(var_509_1.gameObject, typeof(DynamicBoneHelper))

				if var_509_4 then
					var_509_4:EnableDynamicBone(true)
				end
			end

			local var_509_5 = arg_506_1.actors_["1077ui_story"]

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(var_509_5) and arg_506_1.var_.characterEffect1077ui_story == nil then
				arg_506_1.var_.characterEffect1077ui_story = var_509_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_6 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_6 and not isNil(var_509_5) then
				if arg_506_1.var_.characterEffect1077ui_story and not isNil(var_509_5) then
					arg_506_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= 0 + var_509_6 and arg_506_1.time_ < 0 + var_509_6 + arg_509_0 and not isNil(var_509_5) and arg_506_1.var_.characterEffect1077ui_story then
				arg_506_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			local var_509_8 = 0
			local var_509_9 = 0.65

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_8 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_10 = arg_506_1:GetWordFromCfg(325011124)
				local var_509_11 = arg_506_1:FormatText(var_509_10.content)

				arg_506_1.text_.text = var_509_11

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_13 = 26 <= 0 and var_509_9 or var_509_9 * (utf8.len(var_509_11) / 26)

				if (26 <= 0 and var_509_9 or var_509_9 * (utf8.len(var_509_11) / 26)) > 0 and var_509_9 < var_509_13 then
					arg_506_1.talkMaxDuration = var_509_13

					if var_509_13 + var_509_8 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_13 + var_509_8
					end
				end

				arg_506_1.text_.text = var_509_11
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011124", "story_v_out_325011.awb") ~= 0 then
					local var_509_14 = manager.audio:GetVoiceLength("story_v_out_325011", "325011124", "story_v_out_325011.awb") / 1000

					if var_509_14 + var_509_8 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_14 + var_509_8
					end

					if var_509_10.prefab_name ~= "" and arg_506_1.actors_[var_509_10.prefab_name] ~= nil then
						local var_509_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_10.prefab_name].transform, "story_v_out_325011", "325011124", "story_v_out_325011.awb")

						arg_506_1:RecordAudio("325011124", var_509_15)
						arg_506_1:RecordAudio("325011124", var_509_15)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_325011", "325011124", "story_v_out_325011.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_325011", "325011124", "story_v_out_325011.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_16 = math.max(var_509_9, arg_506_1.talkMaxDuration)

			if var_509_8 <= arg_506_1.time_ and arg_506_1.time_ < var_509_8 + var_509_16 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_8) / var_509_16

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_8 + var_509_16 and arg_506_1.time_ < var_509_8 + var_509_16 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_506_1:InitPlayNodeList()
	end,
	Play325011125 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 325011125
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play325011126(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(arg_510_1.actors_["1077ui_story"]) and arg_510_1.var_.characterEffect1077ui_story == nil then
				arg_510_1.var_.characterEffect1077ui_story = arg_510_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_0 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 and not isNil(arg_510_1.actors_["1077ui_story"]) then
				if arg_510_1.var_.characterEffect1077ui_story and not isNil(arg_510_1.actors_["1077ui_story"]) then
					arg_510_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_510_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_510_1.time_ - 0) / var_513_0)
				end
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 and not isNil(arg_510_1.actors_["1077ui_story"]) and arg_510_1.var_.characterEffect1077ui_story then
				arg_510_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_510_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_513_1 = 0
			local var_513_2 = 0.9

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_3 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(325011125).content)

				arg_510_1.text_.text = var_513_3

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_5 = 36 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 36)

				if (36 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 36)) > 0 and var_513_2 < var_513_5 then
					arg_510_1.talkMaxDuration = var_513_5

					if var_513_5 + var_513_1 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_5 + var_513_1
					end
				end

				arg_510_1.text_.text = var_513_3
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_6 = math.max(var_513_2, arg_510_1.talkMaxDuration)

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_6 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_1) / var_513_6

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_1 + var_513_6 and arg_510_1.time_ < var_513_1 + var_513_6 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play325011126 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 325011126
		arg_514_1.duration_ = 4.9

		local var_514_0 = {
			zh = 4.766,
			ja = 4.9
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play325011127(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(arg_514_1.actors_["1069ui_story"]) and arg_514_1.var_.characterEffect1069ui_story == nil then
				arg_514_1.var_.characterEffect1069ui_story = arg_514_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_0 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 and not isNil(arg_514_1.actors_["1069ui_story"]) then
				if arg_514_1.var_.characterEffect1069ui_story and not isNil(arg_514_1.actors_["1069ui_story"]) then
					arg_514_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 and not isNil(arg_514_1.actors_["1069ui_story"]) and arg_514_1.var_.characterEffect1069ui_story then
				arg_514_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_517_2 = 0
			local var_517_3 = 0.625

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_2 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_4 = arg_514_1:GetWordFromCfg(325011126)
				local var_517_5 = arg_514_1:FormatText(var_517_4.content)

				arg_514_1.text_.text = var_517_5

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_7 = 25 <= 0 and var_517_3 or var_517_3 * (utf8.len(var_517_5) / 25)

				if (25 <= 0 and var_517_3 or var_517_3 * (utf8.len(var_517_5) / 25)) > 0 and var_517_3 < var_517_7 then
					arg_514_1.talkMaxDuration = var_517_7

					if var_517_7 + var_517_2 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_7 + var_517_2
					end
				end

				arg_514_1.text_.text = var_517_5
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011126", "story_v_out_325011.awb") ~= 0 then
					local var_517_8 = manager.audio:GetVoiceLength("story_v_out_325011", "325011126", "story_v_out_325011.awb") / 1000

					if var_517_8 + var_517_2 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_8 + var_517_2
					end

					if var_517_4.prefab_name ~= "" and arg_514_1.actors_[var_517_4.prefab_name] ~= nil then
						local var_517_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_4.prefab_name].transform, "story_v_out_325011", "325011126", "story_v_out_325011.awb")

						arg_514_1:RecordAudio("325011126", var_517_9)
						arg_514_1:RecordAudio("325011126", var_517_9)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_325011", "325011126", "story_v_out_325011.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_325011", "325011126", "story_v_out_325011.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_10 = math.max(var_517_3, arg_514_1.talkMaxDuration)

			if var_517_2 <= arg_514_1.time_ and arg_514_1.time_ < var_517_2 + var_517_10 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_2) / var_517_10

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_2 + var_517_10 and arg_514_1.time_ < var_517_2 + var_517_10 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play325011127 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 325011127
		arg_518_1.duration_ = 2

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play325011128(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(arg_518_1.actors_["1077ui_story"]) and arg_518_1.var_.characterEffect1077ui_story == nil then
				arg_518_1.var_.characterEffect1077ui_story = arg_518_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_0 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 and not isNil(arg_518_1.actors_["1077ui_story"]) then
				if arg_518_1.var_.characterEffect1077ui_story and not isNil(arg_518_1.actors_["1077ui_story"]) then
					arg_518_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 and not isNil(arg_518_1.actors_["1077ui_story"]) and arg_518_1.var_.characterEffect1077ui_story then
				arg_518_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_521_2 = arg_518_1.actors_["1069ui_story"]

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(var_521_2) and arg_518_1.var_.characterEffect1069ui_story == nil then
				arg_518_1.var_.characterEffect1069ui_story = var_521_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_3 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_3 and not isNil(var_521_2) then
				if arg_518_1.var_.characterEffect1069ui_story and not isNil(var_521_2) then
					arg_518_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_518_1.time_ - 0) / var_521_3)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_3 and arg_518_1.time_ < 0 + var_521_3 + arg_521_0 and not isNil(var_521_2) and arg_518_1.var_.characterEffect1069ui_story then
				arg_518_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_521_4 = 0
			local var_521_5 = 0.15

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_4 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_6 = arg_518_1:GetWordFromCfg(325011127)
				local var_521_7 = arg_518_1:FormatText(var_521_6.content)

				arg_518_1.text_.text = var_521_7

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_9 = 6 <= 0 and var_521_5 or var_521_5 * (utf8.len(var_521_7) / 6)

				if (6 <= 0 and var_521_5 or var_521_5 * (utf8.len(var_521_7) / 6)) > 0 and var_521_5 < var_521_9 then
					arg_518_1.talkMaxDuration = var_521_9

					if var_521_9 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_9 + var_521_4
					end
				end

				arg_518_1.text_.text = var_521_7
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011127", "story_v_out_325011.awb") ~= 0 then
					local var_521_10 = manager.audio:GetVoiceLength("story_v_out_325011", "325011127", "story_v_out_325011.awb") / 1000

					if var_521_10 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_10 + var_521_4
					end

					if var_521_6.prefab_name ~= "" and arg_518_1.actors_[var_521_6.prefab_name] ~= nil then
						local var_521_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_6.prefab_name].transform, "story_v_out_325011", "325011127", "story_v_out_325011.awb")

						arg_518_1:RecordAudio("325011127", var_521_11)
						arg_518_1:RecordAudio("325011127", var_521_11)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_325011", "325011127", "story_v_out_325011.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_325011", "325011127", "story_v_out_325011.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_12 = math.max(var_521_5, arg_518_1.talkMaxDuration)

			if var_521_4 <= arg_518_1.time_ and arg_518_1.time_ < var_521_4 + var_521_12 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_4) / var_521_12

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_4 + var_521_12 and arg_518_1.time_ < var_521_4 + var_521_12 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play325011128 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 325011128
		arg_522_1.duration_ = 3.1

		local var_522_0 = {
			zh = 2.4,
			ja = 3.1
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play325011129(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(arg_522_1.actors_["1069ui_story"]) and arg_522_1.var_.characterEffect1069ui_story == nil then
				arg_522_1.var_.characterEffect1069ui_story = arg_522_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_0 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 and not isNil(arg_522_1.actors_["1069ui_story"]) then
				if arg_522_1.var_.characterEffect1069ui_story and not isNil(arg_522_1.actors_["1069ui_story"]) then
					arg_522_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 and not isNil(arg_522_1.actors_["1069ui_story"]) and arg_522_1.var_.characterEffect1069ui_story then
				arg_522_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_525_2 = arg_522_1.actors_["1077ui_story"]

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(var_525_2) and arg_522_1.var_.characterEffect1077ui_story == nil then
				arg_522_1.var_.characterEffect1077ui_story = var_525_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_3 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_3 and not isNil(var_525_2) then
				if arg_522_1.var_.characterEffect1077ui_story and not isNil(var_525_2) then
					arg_522_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_522_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_522_1.time_ - 0) / var_525_3)
				end
			end

			if arg_522_1.time_ >= 0 + var_525_3 and arg_522_1.time_ < 0 + var_525_3 + arg_525_0 and not isNil(var_525_2) and arg_522_1.var_.characterEffect1077ui_story then
				arg_522_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_522_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action3_1")
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_525_4 = 0
			local var_525_5 = 0.225

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_4 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_6 = arg_522_1:GetWordFromCfg(325011128)
				local var_525_7 = arg_522_1:FormatText(var_525_6.content)

				arg_522_1.text_.text = var_525_7

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_9 = 9 <= 0 and var_525_5 or var_525_5 * (utf8.len(var_525_7) / 9)

				if (9 <= 0 and var_525_5 or var_525_5 * (utf8.len(var_525_7) / 9)) > 0 and var_525_5 < var_525_9 then
					arg_522_1.talkMaxDuration = var_525_9

					if var_525_9 + var_525_4 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_9 + var_525_4
					end
				end

				arg_522_1.text_.text = var_525_7
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011128", "story_v_out_325011.awb") ~= 0 then
					local var_525_10 = manager.audio:GetVoiceLength("story_v_out_325011", "325011128", "story_v_out_325011.awb") / 1000

					if var_525_10 + var_525_4 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_10 + var_525_4
					end

					if var_525_6.prefab_name ~= "" and arg_522_1.actors_[var_525_6.prefab_name] ~= nil then
						local var_525_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_6.prefab_name].transform, "story_v_out_325011", "325011128", "story_v_out_325011.awb")

						arg_522_1:RecordAudio("325011128", var_525_11)
						arg_522_1:RecordAudio("325011128", var_525_11)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_325011", "325011128", "story_v_out_325011.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_325011", "325011128", "story_v_out_325011.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_12 = math.max(var_525_5, arg_522_1.talkMaxDuration)

			if var_525_4 <= arg_522_1.time_ and arg_522_1.time_ < var_525_4 + var_525_12 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_4) / var_525_12

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_4 + var_525_12 and arg_522_1.time_ < var_525_4 + var_525_12 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play325011129 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 325011129
		arg_526_1.duration_ = 2.77

		local var_526_0 = {
			zh = 1.833,
			ja = 2.766
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play325011130(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(arg_526_1.actors_["1077ui_story"]) and arg_526_1.var_.characterEffect1077ui_story == nil then
				arg_526_1.var_.characterEffect1077ui_story = arg_526_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_0 = 0.200000002980232

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_0 and not isNil(arg_526_1.actors_["1077ui_story"]) then
				if arg_526_1.var_.characterEffect1077ui_story and not isNil(arg_526_1.actors_["1077ui_story"]) then
					arg_526_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= 0 + var_529_0 and arg_526_1.time_ < 0 + var_529_0 + arg_529_0 and not isNil(arg_526_1.actors_["1077ui_story"]) and arg_526_1.var_.characterEffect1077ui_story then
				arg_526_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_529_2 = arg_526_1.actors_["1069ui_story"]

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(var_529_2) and arg_526_1.var_.characterEffect1069ui_story == nil then
				arg_526_1.var_.characterEffect1069ui_story = var_529_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_3 = 0.200000002980232

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_3 and not isNil(var_529_2) then
				if arg_526_1.var_.characterEffect1069ui_story and not isNil(var_529_2) then
					arg_526_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_526_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_526_1.time_ - 0) / var_529_3)
				end
			end

			if arg_526_1.time_ >= 0 + var_529_3 and arg_526_1.time_ < 0 + var_529_3 + arg_529_0 and not isNil(var_529_2) and arg_526_1.var_.characterEffect1069ui_story then
				arg_526_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_526_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_529_4 = 0
			local var_529_5 = 0.125

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_4 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_6 = arg_526_1:GetWordFromCfg(325011129)
				local var_529_7 = arg_526_1:FormatText(var_529_6.content)

				arg_526_1.text_.text = var_529_7

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_9 = 5 <= 0 and var_529_5 or var_529_5 * (utf8.len(var_529_7) / 5)

				if (5 <= 0 and var_529_5 or var_529_5 * (utf8.len(var_529_7) / 5)) > 0 and var_529_5 < var_529_9 then
					arg_526_1.talkMaxDuration = var_529_9

					if var_529_9 + var_529_4 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_9 + var_529_4
					end
				end

				arg_526_1.text_.text = var_529_7
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011129", "story_v_out_325011.awb") ~= 0 then
					local var_529_10 = manager.audio:GetVoiceLength("story_v_out_325011", "325011129", "story_v_out_325011.awb") / 1000

					if var_529_10 + var_529_4 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_10 + var_529_4
					end

					if var_529_6.prefab_name ~= "" and arg_526_1.actors_[var_529_6.prefab_name] ~= nil then
						local var_529_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_6.prefab_name].transform, "story_v_out_325011", "325011129", "story_v_out_325011.awb")

						arg_526_1:RecordAudio("325011129", var_529_11)
						arg_526_1:RecordAudio("325011129", var_529_11)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_out_325011", "325011129", "story_v_out_325011.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_out_325011", "325011129", "story_v_out_325011.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_12 = math.max(var_529_5, arg_526_1.talkMaxDuration)

			if var_529_4 <= arg_526_1.time_ and arg_526_1.time_ < var_529_4 + var_529_12 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_4) / var_529_12

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_4 + var_529_12 and arg_526_1.time_ < var_529_4 + var_529_12 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play325011130 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 325011130
		arg_530_1.duration_ = 7.97

		local var_530_0 = {
			zh = 4.633,
			ja = 7.966
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play325011131(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 and not isNil(arg_530_1.actors_["1069ui_story"]) and arg_530_1.var_.characterEffect1069ui_story == nil then
				arg_530_1.var_.characterEffect1069ui_story = arg_530_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_0 = 0.200000002980232

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_0 and not isNil(arg_530_1.actors_["1069ui_story"]) then
				if arg_530_1.var_.characterEffect1069ui_story and not isNil(arg_530_1.actors_["1069ui_story"]) then
					arg_530_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_530_1.time_ >= 0 + var_533_0 and arg_530_1.time_ < 0 + var_533_0 + arg_533_0 and not isNil(arg_530_1.actors_["1069ui_story"]) and arg_530_1.var_.characterEffect1069ui_story then
				arg_530_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_533_2 = arg_530_1.actors_["1077ui_story"]

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 and not isNil(var_533_2) and arg_530_1.var_.characterEffect1077ui_story == nil then
				arg_530_1.var_.characterEffect1077ui_story = var_533_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_3 = 0.200000002980232

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_3 and not isNil(var_533_2) then
				if arg_530_1.var_.characterEffect1077ui_story and not isNil(var_533_2) then
					arg_530_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_530_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_530_1.time_ - 0) / var_533_3)
				end
			end

			if arg_530_1.time_ >= 0 + var_533_3 and arg_530_1.time_ < 0 + var_533_3 + arg_533_0 and not isNil(var_533_2) and arg_530_1.var_.characterEffect1077ui_story then
				arg_530_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_530_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_533_4 = 0
			local var_533_5 = 0.7

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_4 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_6 = arg_530_1:GetWordFromCfg(325011130)
				local var_533_7 = arg_530_1:FormatText(var_533_6.content)

				arg_530_1.text_.text = var_533_7

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_9 = 28 <= 0 and var_533_5 or var_533_5 * (utf8.len(var_533_7) / 28)

				if (28 <= 0 and var_533_5 or var_533_5 * (utf8.len(var_533_7) / 28)) > 0 and var_533_5 < var_533_9 then
					arg_530_1.talkMaxDuration = var_533_9

					if var_533_9 + var_533_4 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_9 + var_533_4
					end
				end

				arg_530_1.text_.text = var_533_7
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011130", "story_v_out_325011.awb") ~= 0 then
					local var_533_10 = manager.audio:GetVoiceLength("story_v_out_325011", "325011130", "story_v_out_325011.awb") / 1000

					if var_533_10 + var_533_4 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_10 + var_533_4
					end

					if var_533_6.prefab_name ~= "" and arg_530_1.actors_[var_533_6.prefab_name] ~= nil then
						local var_533_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_6.prefab_name].transform, "story_v_out_325011", "325011130", "story_v_out_325011.awb")

						arg_530_1:RecordAudio("325011130", var_533_11)
						arg_530_1:RecordAudio("325011130", var_533_11)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_325011", "325011130", "story_v_out_325011.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_325011", "325011130", "story_v_out_325011.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_12 = math.max(var_533_5, arg_530_1.talkMaxDuration)

			if var_533_4 <= arg_530_1.time_ and arg_530_1.time_ < var_533_4 + var_533_12 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_4) / var_533_12

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_4 + var_533_12 and arg_530_1.time_ < var_533_4 + var_533_12 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play325011131 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 325011131
		arg_534_1.duration_ = 5

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play325011132(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(arg_534_1.actors_["1069ui_story"]) and arg_534_1.var_.characterEffect1069ui_story == nil then
				arg_534_1.var_.characterEffect1069ui_story = arg_534_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_0 = 0.200000002980232

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_0 and not isNil(arg_534_1.actors_["1069ui_story"]) then
				if arg_534_1.var_.characterEffect1069ui_story and not isNil(arg_534_1.actors_["1069ui_story"]) then
					arg_534_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_534_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_534_1.time_ - 0) / var_537_0)
				end
			end

			if arg_534_1.time_ >= 0 + var_537_0 and arg_534_1.time_ < 0 + var_537_0 + arg_537_0 and not isNil(arg_534_1.actors_["1069ui_story"]) and arg_534_1.var_.characterEffect1069ui_story then
				arg_534_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_534_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_537_1 = 0
			local var_537_2 = 0.875

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, false)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_3 = arg_534_1:FormatText(arg_534_1:GetWordFromCfg(325011131).content)

				arg_534_1.text_.text = var_537_3

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_5 = 35 <= 0 and var_537_2 or var_537_2 * (utf8.len(var_537_3) / 35)

				if (35 <= 0 and var_537_2 or var_537_2 * (utf8.len(var_537_3) / 35)) > 0 and var_537_2 < var_537_5 then
					arg_534_1.talkMaxDuration = var_537_5

					if var_537_5 + var_537_1 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_5 + var_537_1
					end
				end

				arg_534_1.text_.text = var_537_3
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_6 = math.max(var_537_2, arg_534_1.talkMaxDuration)

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_6 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_1) / var_537_6

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_1 + var_537_6 and arg_534_1.time_ < var_537_1 + var_537_6 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play325011132 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 325011132
		arg_538_1.duration_ = 6.9

		local var_538_0 = {
			zh = 4.633,
			ja = 6.9
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play325011133(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = 0.4

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, true)
				arg_538_1.iconController_:SetSelectedState("hero")

				arg_538_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_538_1.callingController_:SetSelectedState("normal")

				arg_538_1.keyicon_.color = Color.New(1, 1, 1)
				arg_538_1.icon_.color = Color.New(1, 1, 1)

				local var_541_1 = arg_538_1:GetWordFromCfg(325011132)
				local var_541_2 = arg_538_1:FormatText(var_541_1.content)

				arg_538_1.text_.text = var_541_2

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_4 = 16 <= 0 and var_541_0 or var_541_0 * (utf8.len(var_541_2) / 16)

				if (16 <= 0 and var_541_0 or var_541_0 * (utf8.len(var_541_2) / 16)) > 0 and var_541_0 < var_541_4 then
					arg_538_1.talkMaxDuration = var_541_4

					if var_541_4 + 0 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_4 + 0
					end
				end

				arg_538_1.text_.text = var_541_2
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011132", "story_v_out_325011.awb") ~= 0 then
					local var_541_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011132", "story_v_out_325011.awb") / 1000

					if var_541_5 + 0 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_5 + 0
					end

					if var_541_1.prefab_name ~= "" and arg_538_1.actors_[var_541_1.prefab_name] ~= nil then
						local var_541_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_1.prefab_name].transform, "story_v_out_325011", "325011132", "story_v_out_325011.awb")

						arg_538_1:RecordAudio("325011132", var_541_6)
						arg_538_1:RecordAudio("325011132", var_541_6)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_out_325011", "325011132", "story_v_out_325011.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_out_325011", "325011132", "story_v_out_325011.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_7 = math.max(var_541_0, arg_538_1.talkMaxDuration)

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_7 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - 0) / var_541_7

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= 0 + var_541_7 and arg_538_1.time_ < 0 + var_541_7 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play325011133 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 325011133
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play325011134(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.var_.moveOldPos1077ui_story = arg_542_1.actors_["1077ui_story"].transform.localPosition

				local var_545_0 = GameObjectTools.GetOrAddComponent(arg_542_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_545_0 then
					var_545_0:EnableDynamicBone(false)
				end
			end

			local var_545_1 = 0.001

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_1 then
				arg_542_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_542_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_542_1.time_ - 0) / var_545_1)
				arg_542_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_542_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1077ui_story"].transform.position).z)
				arg_542_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_542_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_542_1.actors_["1077ui_story"].transform.localEulerAngles = arg_542_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_542_1.time_ >= 0 + var_545_1 and arg_542_1.time_ < 0 + var_545_1 + arg_545_0 then
				arg_542_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_542_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_542_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1077ui_story"].transform.position).z)
				arg_542_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_542_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_542_1.actors_["1077ui_story"].transform.localEulerAngles = arg_542_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_545_2 = GameObjectTools.GetOrAddComponent(arg_542_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_545_2 then
					var_545_2:EnableDynamicBone(true)
				end
			end

			local var_545_3 = arg_542_1.actors_["1069ui_story"].transform

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.var_.moveOldPos1069ui_story = var_545_3.localPosition
			end

			local var_545_4 = 0.001

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_4 then
				var_545_3.localPosition = Vector3.Lerp(arg_542_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_542_1.time_ - 0) / var_545_4)
				var_545_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_545_3.position).x, (manager.ui.mainCamera.transform.position - var_545_3.position).y, (manager.ui.mainCamera.transform.position - var_545_3.position).z)
				var_545_3.localEulerAngles.z = 0
				var_545_3.localEulerAngles.x = 0
				var_545_3.localEulerAngles = var_545_3.localEulerAngles
			end

			if arg_542_1.time_ >= 0 + var_545_4 and arg_542_1.time_ < 0 + var_545_4 + arg_545_0 then
				var_545_3.localPosition = Vector3.New(0, 100, 0)
				var_545_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_545_3.position).x, (manager.ui.mainCamera.transform.position - var_545_3.position).y, (manager.ui.mainCamera.transform.position - var_545_3.position).z)
				var_545_3.localEulerAngles.z = 0
				var_545_3.localEulerAngles.x = 0
				var_545_3.localEulerAngles = var_545_3.localEulerAngles
			end

			local var_545_5 = 0
			local var_545_6 = 0.825

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_5 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, false)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_7 = arg_542_1:FormatText(arg_542_1:GetWordFromCfg(325011133).content)

				arg_542_1.text_.text = var_545_7

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_9 = 33 <= 0 and var_545_6 or var_545_6 * (utf8.len(var_545_7) / 33)

				if (33 <= 0 and var_545_6 or var_545_6 * (utf8.len(var_545_7) / 33)) > 0 and var_545_6 < var_545_9 then
					arg_542_1.talkMaxDuration = var_545_9

					if var_545_9 + var_545_5 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_9 + var_545_5
					end
				end

				arg_542_1.text_.text = var_545_7
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_10 = math.max(var_545_6, arg_542_1.talkMaxDuration)

			if var_545_5 <= arg_542_1.time_ and arg_542_1.time_ < var_545_5 + var_545_10 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_5) / var_545_10

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_5 + var_545_10 and arg_542_1.time_ < var_545_5 + var_545_10 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_542_1:InitPlayNodeList()
	end,
	Play325011134 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 325011134
		arg_546_1.duration_ = 4.37

		local var_546_0 = {
			zh = 4.2,
			ja = 4.366
		}
		local var_546_1 = manager.audio:GetLocalizationFlag()

		if var_546_0[var_546_1] ~= nil then
			arg_546_1.duration_ = var_546_0[var_546_1]
		end

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play325011135(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0.475

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[1523].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, true)
				arg_546_1.iconController_:SetSelectedState("hero")

				arg_546_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_546_1.callingController_:SetSelectedState("normal")

				arg_546_1.keyicon_.color = Color.New(1, 1, 1)
				arg_546_1.icon_.color = Color.New(1, 1, 1)

				local var_549_1 = arg_546_1:GetWordFromCfg(325011134)
				local var_549_2 = arg_546_1:FormatText(var_549_1.content)

				arg_546_1.text_.text = var_549_2

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_4 = 19 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_2) / 19)

				if (19 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_2) / 19)) > 0 and var_549_0 < var_549_4 then
					arg_546_1.talkMaxDuration = var_549_4

					if var_549_4 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_4 + 0
					end
				end

				arg_546_1.text_.text = var_549_2
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011134", "story_v_out_325011.awb") ~= 0 then
					local var_549_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011134", "story_v_out_325011.awb") / 1000

					if var_549_5 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_5 + 0
					end

					if var_549_1.prefab_name ~= "" and arg_546_1.actors_[var_549_1.prefab_name] ~= nil then
						local var_549_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_1.prefab_name].transform, "story_v_out_325011", "325011134", "story_v_out_325011.awb")

						arg_546_1:RecordAudio("325011134", var_549_6)
						arg_546_1:RecordAudio("325011134", var_549_6)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_out_325011", "325011134", "story_v_out_325011.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_out_325011", "325011134", "story_v_out_325011.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_7 = math.max(var_549_0, arg_546_1.talkMaxDuration)

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_7 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - 0) / var_549_7

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= 0 + var_549_7 and arg_546_1.time_ < 0 + var_549_7 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play325011135 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 325011135
		arg_550_1.duration_ = 3.83

		local var_550_0 = {
			zh = 3.833,
			ja = 3.533
		}
		local var_550_1 = manager.audio:GetLocalizationFlag()

		if var_550_0[var_550_1] ~= nil then
			arg_550_1.duration_ = var_550_0[var_550_1]
		end

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play325011136(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0.375

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				arg_550_1.leftNameTxt_.text = arg_550_1:FormatText(StoryNameCfg[1524].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, true)
				arg_550_1.iconController_:SetSelectedState("hero")

				arg_550_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_550_1.callingController_:SetSelectedState("normal")

				arg_550_1.keyicon_.color = Color.New(1, 1, 1)
				arg_550_1.icon_.color = Color.New(1, 1, 1)

				local var_553_1 = arg_550_1:GetWordFromCfg(325011135)
				local var_553_2 = arg_550_1:FormatText(var_553_1.content)

				arg_550_1.text_.text = var_553_2

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_4 = 15 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_2) / 15)

				if (15 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_2) / 15)) > 0 and var_553_0 < var_553_4 then
					arg_550_1.talkMaxDuration = var_553_4

					if var_553_4 + 0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_4 + 0
					end
				end

				arg_550_1.text_.text = var_553_2
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011135", "story_v_out_325011.awb") ~= 0 then
					local var_553_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011135", "story_v_out_325011.awb") / 1000

					if var_553_5 + 0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_5 + 0
					end

					if var_553_1.prefab_name ~= "" and arg_550_1.actors_[var_553_1.prefab_name] ~= nil then
						local var_553_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_550_1.actors_[var_553_1.prefab_name].transform, "story_v_out_325011", "325011135", "story_v_out_325011.awb")

						arg_550_1:RecordAudio("325011135", var_553_6)
						arg_550_1:RecordAudio("325011135", var_553_6)
					else
						arg_550_1:AudioAction("play", "voice", "story_v_out_325011", "325011135", "story_v_out_325011.awb")
					end

					arg_550_1:RecordHistoryTalkVoice("story_v_out_325011", "325011135", "story_v_out_325011.awb")
				end

				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_7 = math.max(var_553_0, arg_550_1.talkMaxDuration)

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_7 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - 0) / var_553_7

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= 0 + var_553_7 and arg_550_1.time_ < 0 + var_553_7 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play325011136 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 325011136
		arg_554_1.duration_ = 9.73

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play325011137(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 1.175

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[1524].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, true)
				arg_554_1.iconController_:SetSelectedState("hero")

				arg_554_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_554_1.callingController_:SetSelectedState("normal")

				arg_554_1.keyicon_.color = Color.New(1, 1, 1)
				arg_554_1.icon_.color = Color.New(1, 1, 1)

				local var_557_1 = arg_554_1:GetWordFromCfg(325011136)
				local var_557_2 = arg_554_1:FormatText(var_557_1.content)

				arg_554_1.text_.text = var_557_2

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_4 = 47 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_2) / 47)

				if (47 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_2) / 47)) > 0 and var_557_0 < var_557_4 then
					arg_554_1.talkMaxDuration = var_557_4

					if var_557_4 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_4 + 0
					end
				end

				arg_554_1.text_.text = var_557_2
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011136", "story_v_out_325011.awb") ~= 0 then
					local var_557_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011136", "story_v_out_325011.awb") / 1000

					if var_557_5 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_5 + 0
					end

					if var_557_1.prefab_name ~= "" and arg_554_1.actors_[var_557_1.prefab_name] ~= nil then
						local var_557_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_1.prefab_name].transform, "story_v_out_325011", "325011136", "story_v_out_325011.awb")

						arg_554_1:RecordAudio("325011136", var_557_6)
						arg_554_1:RecordAudio("325011136", var_557_6)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_325011", "325011136", "story_v_out_325011.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_325011", "325011136", "story_v_out_325011.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_7 = math.max(var_557_0, arg_554_1.talkMaxDuration)

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_7 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - 0) / var_557_7

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= 0 + var_557_7 and arg_554_1.time_ < 0 + var_557_7 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play325011137 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 325011137
		arg_558_1.duration_ = 5.23

		local var_558_0 = {
			zh = 4.666,
			ja = 5.233
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play325011138(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0.425

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[1522].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_1 = arg_558_1:GetWordFromCfg(325011137)
				local var_561_2 = arg_558_1:FormatText(var_561_1.content)

				arg_558_1.text_.text = var_561_2

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_4 = 17 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_2) / 17)

				if (17 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_2) / 17)) > 0 and var_561_0 < var_561_4 then
					arg_558_1.talkMaxDuration = var_561_4

					if var_561_4 + 0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_4 + 0
					end
				end

				arg_558_1.text_.text = var_561_2
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011137", "story_v_out_325011.awb") ~= 0 then
					local var_561_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011137", "story_v_out_325011.awb") / 1000

					if var_561_5 + 0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_5 + 0
					end

					if var_561_1.prefab_name ~= "" and arg_558_1.actors_[var_561_1.prefab_name] ~= nil then
						local var_561_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_1.prefab_name].transform, "story_v_out_325011", "325011137", "story_v_out_325011.awb")

						arg_558_1:RecordAudio("325011137", var_561_6)
						arg_558_1:RecordAudio("325011137", var_561_6)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_325011", "325011137", "story_v_out_325011.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_325011", "325011137", "story_v_out_325011.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_7 = math.max(var_561_0, arg_558_1.talkMaxDuration)

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_7 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - 0) / var_561_7

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= 0 + var_561_7 and arg_558_1.time_ < 0 + var_561_7 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play325011138 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 325011138
		arg_562_1.duration_ = 3.6

		local var_562_0 = {
			zh = 2.933,
			ja = 3.6
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play325011139(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0.3

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[1523].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, true)
				arg_562_1.iconController_:SetSelectedState("hero")

				arg_562_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_562_1.callingController_:SetSelectedState("normal")

				arg_562_1.keyicon_.color = Color.New(1, 1, 1)
				arg_562_1.icon_.color = Color.New(1, 1, 1)

				local var_565_1 = arg_562_1:GetWordFromCfg(325011138)
				local var_565_2 = arg_562_1:FormatText(var_565_1.content)

				arg_562_1.text_.text = var_565_2

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_4 = 12 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_2) / 12)

				if (12 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_2) / 12)) > 0 and var_565_0 < var_565_4 then
					arg_562_1.talkMaxDuration = var_565_4

					if var_565_4 + 0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_4 + 0
					end
				end

				arg_562_1.text_.text = var_565_2
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011138", "story_v_out_325011.awb") ~= 0 then
					local var_565_5 = manager.audio:GetVoiceLength("story_v_out_325011", "325011138", "story_v_out_325011.awb") / 1000

					if var_565_5 + 0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_5 + 0
					end

					if var_565_1.prefab_name ~= "" and arg_562_1.actors_[var_565_1.prefab_name] ~= nil then
						local var_565_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_1.prefab_name].transform, "story_v_out_325011", "325011138", "story_v_out_325011.awb")

						arg_562_1:RecordAudio("325011138", var_565_6)
						arg_562_1:RecordAudio("325011138", var_565_6)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_325011", "325011138", "story_v_out_325011.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_325011", "325011138", "story_v_out_325011.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_7 = math.max(var_565_0, arg_562_1.talkMaxDuration)

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_7 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - 0) / var_565_7

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= 0 + var_565_7 and arg_562_1.time_ < 0 + var_565_7 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play325011139 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 325011139
		arg_566_1.duration_ = 5

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play325011140(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 1.375

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, false)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_1 = arg_566_1:FormatText(arg_566_1:GetWordFromCfg(325011139).content)

				arg_566_1.text_.text = var_569_1

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_3 = 55 <= 0 and var_569_0 or var_569_0 * (utf8.len(var_569_1) / 55)

				if (55 <= 0 and var_569_0 or var_569_0 * (utf8.len(var_569_1) / 55)) > 0 and var_569_0 < var_569_3 then
					arg_566_1.talkMaxDuration = var_569_3

					if var_569_3 + 0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_3 + 0
					end
				end

				arg_566_1.text_.text = var_569_1
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)
				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_4 = math.max(var_569_0, arg_566_1.talkMaxDuration)

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_4 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - 0) / var_569_4

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= 0 + var_569_4 and arg_566_1.time_ < 0 + var_569_4 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play325011140 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 325011140
		arg_570_1.duration_ = 6.87

		local var_570_0 = {
			zh = 6.866,
			ja = 6.633
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
			arg_570_1.auto_ = false
		end

		function arg_570_1.playNext_(arg_572_0)
			arg_570_1.onStoryFinished_()
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_573_1 = 0
			local var_573_2 = 0.725

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[1445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, true)
				arg_570_1.iconController_:SetSelectedState("hero")

				arg_570_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_570_1.callingController_:SetSelectedState("normal")

				arg_570_1.keyicon_.color = Color.New(1, 1, 1)
				arg_570_1.icon_.color = Color.New(1, 1, 1)

				local var_573_3 = arg_570_1:GetWordFromCfg(325011140)
				local var_573_4 = arg_570_1:FormatText(var_573_3.content)

				arg_570_1.text_.text = var_573_4

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_6 = 29 <= 0 and var_573_2 or var_573_2 * (utf8.len(var_573_4) / 29)

				if (29 <= 0 and var_573_2 or var_573_2 * (utf8.len(var_573_4) / 29)) > 0 and var_573_2 < var_573_6 then
					arg_570_1.talkMaxDuration = var_573_6

					if var_573_6 + var_573_1 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_6 + var_573_1
					end
				end

				arg_570_1.text_.text = var_573_4
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325011", "325011140", "story_v_out_325011.awb") ~= 0 then
					local var_573_7 = manager.audio:GetVoiceLength("story_v_out_325011", "325011140", "story_v_out_325011.awb") / 1000

					if var_573_7 + var_573_1 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_7 + var_573_1
					end

					if var_573_3.prefab_name ~= "" and arg_570_1.actors_[var_573_3.prefab_name] ~= nil then
						local var_573_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_3.prefab_name].transform, "story_v_out_325011", "325011140", "story_v_out_325011.awb")

						arg_570_1:RecordAudio("325011140", var_573_8)
						arg_570_1:RecordAudio("325011140", var_573_8)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_325011", "325011140", "story_v_out_325011.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_325011", "325011140", "story_v_out_325011.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_9 = math.max(var_573_2, arg_570_1.talkMaxDuration)

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_9 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_1) / var_573_9

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_1 + var_573_9 and arg_570_1.time_ < var_573_1 + var_573_9 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2015",
		"TextureConfig/Background/ST13"
	},
	voices = {
		"story_v_out_325011.awb"
	}
}
