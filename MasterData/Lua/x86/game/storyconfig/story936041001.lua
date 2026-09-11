return {
	Play936041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 936041001
		arg_1_1.duration_ = 6.3

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play936041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.X206_i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X206_i")
				var_4_0.name = "X206_i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.X206_i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.X206_i

				arg_1_1.bgs_.X206_i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "X206_i" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "104402ui_story"

			if arg_1_1.actors_["104402ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104402ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "104402ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["104402ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos104402ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_1_1.time_ - 1.8) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1, -5.93)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles

				local var_4_16 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_16 then
					var_4_16:EnableDynamicBone(true)
				end
			end

			local var_4_17 = arg_1_1.actors_["104402ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect104402ui_story == nil then
				arg_1_1.var_.characterEffect104402ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect104402ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_18 and arg_1_1.time_ < 1.8 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect104402ui_story then
				arg_1_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(936041001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 11 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 11)

				if (11 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 11)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041001", "story_v_side_old_936041.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041001", "story_v_side_old_936041.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_side_old_936041", "936041001", "story_v_side_old_936041.awb")

						arg_1_1:RecordAudio("936041001", var_4_32)
						arg_1_1:RecordAudio("936041001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041001", "story_v_side_old_936041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041001", "story_v_side_old_936041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play936041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 936041002
		arg_8_1.duration_ = 10.3

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play936041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			local var_11_0 = 0
			local var_11_1 = 1.175

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(936041002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 47 <= 0 and var_11_1 or var_11_1 * (utf8.len(var_11_3) / 47)

				if (47 <= 0 and var_11_1 or var_11_1 * (utf8.len(var_11_3) / 47)) > 0 and var_11_1 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041002", "story_v_side_old_936041.awb") ~= 0 then
					local var_11_6 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041002", "story_v_side_old_936041.awb") / 1000

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end

					if var_11_2.prefab_name ~= "" and arg_8_1.actors_[var_11_2.prefab_name] ~= nil then
						local var_11_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_2.prefab_name].transform, "story_v_side_old_936041", "936041002", "story_v_side_old_936041.awb")

						arg_8_1:RecordAudio("936041002", var_11_7)
						arg_8_1:RecordAudio("936041002", var_11_7)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041002", "story_v_side_old_936041.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041002", "story_v_side_old_936041.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_8 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_8 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_8

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_8 and arg_8_1.time_ < var_11_0 + var_11_8 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play936041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 936041003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play936041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos104402ui_story = arg_12_1.actors_["104402ui_story"].transform.localPosition

				local var_15_0 = GameObjectTools.GetOrAddComponent(arg_12_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_15_0 then
					var_15_0:EnableDynamicBone(false)
				end
			end

			local var_15_1 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_1 then
				arg_12_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_1)
				arg_12_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["104402ui_story"].transform.position).z)
				arg_12_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["104402ui_story"].transform.localEulerAngles = arg_12_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_1 and arg_12_1.time_ < 0 + var_15_1 + arg_15_0 then
				arg_12_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["104402ui_story"].transform.position).z)
				arg_12_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["104402ui_story"].transform.localEulerAngles = arg_12_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_15_2 = GameObjectTools.GetOrAddComponent(arg_12_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(true)
				end
			end

			local var_15_3 = arg_12_1.actors_["104402ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect104402ui_story == nil then
				arg_12_1.var_.characterEffect104402ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect104402ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_12_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_4)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect104402ui_story then
				arg_12_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_12_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_15_5 = 0
			local var_15_6 = 1.15

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_7 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(936041003).content)

				arg_12_1.text_.text = var_15_7

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_9 = 46 <= 0 and var_15_6 or var_15_6 * (utf8.len(var_15_7) / 46)

				if (46 <= 0 and var_15_6 or var_15_6 * (utf8.len(var_15_7) / 46)) > 0 and var_15_6 < var_15_9 then
					arg_12_1.talkMaxDuration = var_15_9

					if var_15_9 + var_15_5 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_9 + var_15_5
					end
				end

				arg_12_1.text_.text = var_15_7
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_6, arg_12_1.talkMaxDuration)

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_5) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_5 + var_15_10 and arg_12_1.time_ < var_15_5 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
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
	Play936041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 936041004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play936041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.05

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(936041004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 42 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 42)

				if (42 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 42)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play936041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 936041005
		arg_20_1.duration_ = 5.1

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play936041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos104402ui_story = arg_20_1.actors_["104402ui_story"].transform.localPosition

				local var_23_0 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_0 then
					var_23_0:EnableDynamicBone(false)
				end
			end

			local var_23_1 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_1 then
				arg_20_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_20_1.time_ - 0) / var_23_1)
				arg_20_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["104402ui_story"].transform.position).z)
				arg_20_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["104402ui_story"].transform.localEulerAngles = arg_20_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_1 and arg_20_1.time_ < 0 + var_23_1 + arg_23_0 then
				arg_20_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_20_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["104402ui_story"].transform.position).z)
				arg_20_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["104402ui_story"].transform.localEulerAngles = arg_20_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_23_2 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(true)
				end
			end

			local var_23_3 = arg_20_1.actors_["104402ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect104402ui_story == nil then
				arg_20_1.var_.characterEffect104402ui_story = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect104402ui_story and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect104402ui_story then
				arg_20_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action6_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_23_6 = 0
			local var_23_7 = 0.425

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_8 = arg_20_1:GetWordFromCfg(936041005)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 17 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 17)

				if (17 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 17)) > 0 and var_23_7 < var_23_11 then
					arg_20_1.talkMaxDuration = var_23_11

					if var_23_11 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041005", "story_v_side_old_936041.awb") ~= 0 then
					local var_23_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041005", "story_v_side_old_936041.awb") / 1000

					if var_23_12 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_6
					end

					if var_23_8.prefab_name ~= "" and arg_20_1.actors_[var_23_8.prefab_name] ~= nil then
						local var_23_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_8.prefab_name].transform, "story_v_side_old_936041", "936041005", "story_v_side_old_936041.awb")

						arg_20_1:RecordAudio("936041005", var_23_13)
						arg_20_1:RecordAudio("936041005", var_23_13)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041005", "story_v_side_old_936041.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041005", "story_v_side_old_936041.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play936041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 936041006
		arg_24_1.duration_ = 93

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play936041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos104402ui_story = arg_24_1.actors_["104402ui_story"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["104402ui_story"].transform.position).z)
				arg_24_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["104402ui_story"].transform.localEulerAngles = arg_24_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["104402ui_story"].transform.position).z)
				arg_24_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["104402ui_story"].transform.localEulerAngles = arg_24_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = "105401ui_story"

			if arg_24_1.actors_["105401ui_story"] == nil and not isNil((Asset.Load("Char/" .. "105401ui_story"))) then
				local var_27_4 = Object.Instantiate(Asset.Load("Char/" .. "105401ui_story"), arg_24_1.stage_.transform)

				var_27_4.name = var_27_3
				var_27_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_[var_27_3] = var_27_4

				local var_27_5 = var_27_4:GetComponentInChildren(typeof(CharacterEffect))

				var_27_5.enabled = true

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_4, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_5.transform, false)

				arg_24_1.var_[var_27_3 .. "Animator"] = var_27_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_[var_27_3 .. "Animator"].applyRootMotion = true
				arg_24_1.var_[var_27_3 .. "LipSync"] = var_27_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_7 = arg_24_1.actors_["105401ui_story"].transform

			if 90.1333333333343 < arg_24_1.time_ and arg_24_1.time_ <= 90.1333333333343 + arg_27_0 then
				arg_24_1.var_.moveOldPos105401ui_story = var_27_7.localPosition

				local var_27_8 = GameObjectTools.GetOrAddComponent(var_27_7.gameObject, typeof(DynamicBoneHelper))

				if var_27_8 then
					var_27_8:EnableDynamicBone(false)
				end
			end

			local var_27_9 = 0.001

			if 90.1333333333343 <= arg_24_1.time_ and arg_24_1.time_ < 90.1333333333343 + var_27_9 then
				var_27_7.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos105401ui_story, Vector3.New(0, -0.985, -6), (arg_24_1.time_ - 90.1333333333343) / var_27_9)
				var_27_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_7.position).x, (manager.ui.mainCamera.transform.position - var_27_7.position).y, (manager.ui.mainCamera.transform.position - var_27_7.position).z)
				var_27_7.localEulerAngles.z = 0
				var_27_7.localEulerAngles.x = 0
				var_27_7.localEulerAngles = var_27_7.localEulerAngles
			end

			if arg_24_1.time_ >= 90.1333333333343 + var_27_9 and arg_24_1.time_ < 90.1333333333343 + var_27_9 + arg_27_0 then
				var_27_7.localPosition = Vector3.New(0, -0.985, -6)
				var_27_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_7.position).x, (manager.ui.mainCamera.transform.position - var_27_7.position).y, (manager.ui.mainCamera.transform.position - var_27_7.position).z)
				var_27_7.localEulerAngles.z = 0
				var_27_7.localEulerAngles.x = 0
				var_27_7.localEulerAngles = var_27_7.localEulerAngles

				local var_27_10 = GameObjectTools.GetOrAddComponent(var_27_7.gameObject, typeof(DynamicBoneHelper))

				if var_27_10 then
					var_27_10:EnableDynamicBone(true)
				end
			end

			local var_27_11 = arg_24_1.actors_["105401ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos105401ui_story = var_27_11.localPosition

				local var_27_12 = GameObjectTools.GetOrAddComponent(var_27_11.gameObject, typeof(DynamicBoneHelper))

				if var_27_12 then
					var_27_12:EnableDynamicBone(false)
				end
			end

			local var_27_13 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_13 then
				var_27_11.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos105401ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_13)
				var_27_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_11.position).x, (manager.ui.mainCamera.transform.position - var_27_11.position).y, (manager.ui.mainCamera.transform.position - var_27_11.position).z)
				var_27_11.localEulerAngles.z = 0
				var_27_11.localEulerAngles.x = 0
				var_27_11.localEulerAngles = var_27_11.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_13 and arg_24_1.time_ < 0 + var_27_13 + arg_27_0 then
				var_27_11.localPosition = Vector3.New(0, 100, 0)
				var_27_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_11.position).x, (manager.ui.mainCamera.transform.position - var_27_11.position).y, (manager.ui.mainCamera.transform.position - var_27_11.position).z)
				var_27_11.localEulerAngles.z = 0
				var_27_11.localEulerAngles.x = 0
				var_27_11.localEulerAngles = var_27_11.localEulerAngles

				local var_27_14 = GameObjectTools.GetOrAddComponent(var_27_11.gameObject, typeof(DynamicBoneHelper))

				if var_27_14 then
					var_27_14:EnableDynamicBone(true)
				end
			end

			local var_27_15 = arg_24_1.actors_["105401ui_story"]

			if 90.1333333333343 < arg_24_1.time_ and arg_24_1.time_ <= 90.1333333333343 + arg_27_0 and not isNil(var_27_15) and arg_24_1.var_.characterEffect105401ui_story == nil then
				arg_24_1.var_.characterEffect105401ui_story = var_27_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_16 = 0.200000002980232

			if 90.1333333333343 <= arg_24_1.time_ and arg_24_1.time_ < 90.1333333333343 + var_27_16 and not isNil(var_27_15) then
				if arg_24_1.var_.characterEffect105401ui_story and not isNil(var_27_15) then
					arg_24_1.var_.characterEffect105401ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 90.1333333333343 + var_27_16 and arg_24_1.time_ < 90.1333333333343 + var_27_16 + arg_27_0 and not isNil(var_27_15) and arg_24_1.var_.characterEffect105401ui_story then
				arg_24_1.var_.characterEffect105401ui_story.fillFlat = false
			end

			if 90.1333333333343 < arg_24_1.time_ and arg_24_1.time_ <= 90.1333333333343 + arg_27_0 then
				arg_24_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_27_18 = 90

			if 90 < arg_24_1.time_ and arg_24_1.time_ <= var_27_18 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_19 = 2

			if var_27_18 <= arg_24_1.time_ and arg_24_1.time_ < var_27_18 + var_27_19 then
				local var_27_20 = Color.New(0, 0, 0)

				var_27_20.a = Mathf.Lerp(1, 0, (arg_24_1.time_ - var_27_18) / var_27_19)
				arg_24_1.mask_.color = var_27_20
			end

			if arg_24_1.time_ >= var_27_18 + var_27_19 and arg_24_1.time_ < var_27_18 + var_27_19 + arg_27_0 then
				local var_27_21 = Color.New(0, 0, 0)

				arg_24_1.mask_.enabled = false
				var_27_21.a = 0
				arg_24_1.mask_.color = var_27_21
			end

			if 90.1333333333333 < arg_24_1.time_ and arg_24_1.time_ <= 90.1333333333333 + arg_27_0 then
				arg_24_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_27_22 = 0

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_22 + arg_27_0 then
				SetActive(arg_24_1.dialog_, false)
				SetActive(arg_24_1.allBtn_.gameObject, false)
				arg_24_1.hideBtnsController_:SetSelectedIndex(1)
				arg_24_1:StopAllVoice()
				arg_24_1:PlayOnlyBgm()

				arg_24_1.marker = "tingliuyixia1"

				manager.video:Play("SofdecAsset/story/story_936041001.usm", function(arg_28_0)
					arg_24_1.time_ = var_27_22 + 89.9900000002235

					if arg_24_1.state_ == "pause" then
						arg_24_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_29_0)
					arg_24_1.state_ = arg_29_0 and "pause" or "playing"
				end, 93604101)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_27_23 = 90

			if var_27_22 <= arg_24_1.time_ and arg_24_1.time_ < var_27_22 + var_27_23 then
				-- block empty
			end

			if arg_24_1.time_ >= var_27_22 + var_27_23 and arg_24_1.time_ < var_27_22 + var_27_23 + arg_27_0 then
				arg_24_1.marker = ""
			end

			local var_27_24 = 90

			if 90 < arg_24_1.time_ and arg_24_1.time_ <= var_27_24 + arg_27_0 then
				SetActive(arg_24_1.dialog_, true)
				SetActive(arg_24_1.allBtn_.gameObject, true)
				arg_24_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_24_1.isInLoopVideo = false
			end

			local var_27_25 = 2.26666666666667

			if var_27_24 <= arg_24_1.time_ and arg_24_1.time_ < var_27_24 + var_27_25 then
				-- block empty
			end

			if arg_24_1.time_ >= var_27_24 + var_27_25 and arg_24_1.time_ < var_27_24 + var_27_25 + arg_27_0 then
				-- block empty
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_26 = 90
			local var_27_27 = 0.275

			if 90 < arg_24_1.time_ and arg_24_1.time_ <= var_27_26 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_28 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_28:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_24_1.dialogCg_.alpha = arg_30_0
				end))
				var_27_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_29 = arg_24_1:GetWordFromCfg(936041006)
				local var_27_30 = arg_24_1:FormatText(var_27_29.content)

				arg_24_1.text_.text = var_27_30

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_32 = 11 <= 0 and var_27_27 or var_27_27 * (utf8.len(var_27_30) / 11)

				if (11 <= 0 and var_27_27 or var_27_27 * (utf8.len(var_27_30) / 11)) > 0 and var_27_27 < var_27_32 then
					arg_24_1.talkMaxDuration = var_27_32
					var_27_26 = var_27_26 + 0.3

					if var_27_32 + var_27_26 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_32 + var_27_26
					end
				end

				arg_24_1.text_.text = var_27_30
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041006", "story_v_side_old_936041.awb") ~= 0 then
					local var_27_33 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041006", "story_v_side_old_936041.awb") / 1000

					if var_27_33 + var_27_26 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_33 + var_27_26
					end

					if var_27_29.prefab_name ~= "" and arg_24_1.actors_[var_27_29.prefab_name] ~= nil then
						local var_27_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_29.prefab_name].transform, "story_v_side_old_936041", "936041006", "story_v_side_old_936041.awb")

						arg_24_1:RecordAudio("936041006", var_27_34)
						arg_24_1:RecordAudio("936041006", var_27_34)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041006", "story_v_side_old_936041.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041006", "story_v_side_old_936041.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_35 = var_27_26 + 0.3
			local var_27_36 = math.max(var_27_27, arg_24_1.talkMaxDuration)

			if var_27_26 + 0.3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_35 + var_27_36 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_35) / var_27_36

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_35 + var_27_36 and arg_24_1.time_ < var_27_35 + var_27_36 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 90.1333333333343,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play936041007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 936041007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play936041008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos105401ui_story = arg_32_1.actors_["105401ui_story"].transform.localPosition

				local var_35_0 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["105401ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_0 then
					var_35_0:EnableDynamicBone(false)
				end
			end

			local var_35_1 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_1 then
				arg_32_1.actors_["105401ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos105401ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_1)
				arg_32_1.actors_["105401ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["105401ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["105401ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["105401ui_story"].transform.position).z)
				arg_32_1.actors_["105401ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["105401ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["105401ui_story"].transform.localEulerAngles = arg_32_1.actors_["105401ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 then
				arg_32_1.actors_["105401ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["105401ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["105401ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["105401ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["105401ui_story"].transform.position).z)
				arg_32_1.actors_["105401ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["105401ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["105401ui_story"].transform.localEulerAngles = arg_32_1.actors_["105401ui_story"].transform.localEulerAngles

				local var_35_2 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["105401ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(true)
				end
			end

			local var_35_3 = "614801ui_story"

			if arg_32_1.actors_["614801ui_story"] == nil and not isNil((Asset.Load("Char/" .. "614801ui_story"))) then
				local var_35_4 = Object.Instantiate(Asset.Load("Char/" .. "614801ui_story"), arg_32_1.stage_.transform)

				var_35_4.name = var_35_3
				var_35_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_[var_35_3] = var_35_4

				local var_35_5 = var_35_4:GetComponentInChildren(typeof(CharacterEffect))

				var_35_5.enabled = true

				local var_35_6 = GameObjectTools.GetOrAddComponent(var_35_4, typeof(DynamicBoneHelper))

				if var_35_6 then
					var_35_6:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_5.transform, false)

				arg_32_1.var_[var_35_3 .. "Animator"] = var_35_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_[var_35_3 .. "Animator"].applyRootMotion = true
				arg_32_1.var_[var_35_3 .. "LipSync"] = var_35_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_7 = arg_32_1.actors_["614801ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_7) and arg_32_1.var_.characterEffect614801ui_story == nil then
				arg_32_1.var_.characterEffect614801ui_story = var_35_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_8 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_8 and not isNil(var_35_7) then
				if arg_32_1.var_.characterEffect614801ui_story and not isNil(var_35_7) then
					arg_32_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_32_1.var_.characterEffect614801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_8)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_8 and arg_32_1.time_ < 0 + var_35_8 + arg_35_0 and not isNil(var_35_7) and arg_32_1.var_.characterEffect614801ui_story then
				arg_32_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_32_1.var_.characterEffect614801ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_35_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_11 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_11

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_11
						arg_32_1.bgmTxt2_.text = var_35_11
					end

					if arg_32_1.bgmTimer then
						arg_32_1.bgmTimer:Stop()

						arg_32_1.bgmTimer = nil
					end

					if arg_32_1.settingData.show_music_name == 1 then
						arg_32_1.musicController:SetSelectedState("show")
						arg_32_1.musicAnimator_:Play("open", 0, 0)

						if arg_32_1.settingData.music_time ~= 0 then
							arg_32_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_32_1.settingData.music_time), function()
								if arg_32_1 == nil or isNil(arg_32_1.bgmTxt_) then
									return
								end

								arg_32_1.musicController:SetSelectedState("hide")
								arg_32_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_32_1.time_ and arg_32_1.time_ <= 0.433333333333333 + arg_35_0 then
				arg_32_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_35_14 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_14 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_14

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_14
						arg_32_1.bgmTxt2_.text = var_35_14
					end

					if arg_32_1.bgmTimer then
						arg_32_1.bgmTimer:Stop()

						arg_32_1.bgmTimer = nil
					end

					if arg_32_1.settingData.show_music_name == 1 then
						arg_32_1.musicController:SetSelectedState("show")
						arg_32_1.musicAnimator_:Play("open", 0, 0)

						if arg_32_1.settingData.music_time ~= 0 then
							arg_32_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_32_1.settingData.music_time), function()
								if arg_32_1 == nil or isNil(arg_32_1.bgmTxt_) then
									return
								end

								arg_32_1.musicController:SetSelectedState("hide")
								arg_32_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_35_15 = 0
			local var_35_16 = 1.375

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_17 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(936041007).content)

				arg_32_1.text_.text = var_35_17

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_19 = 55 <= 0 and var_35_16 or var_35_16 * (utf8.len(var_35_17) / 55)

				if (55 <= 0 and var_35_16 or var_35_16 * (utf8.len(var_35_17) / 55)) > 0 and var_35_16 < var_35_19 then
					arg_32_1.talkMaxDuration = var_35_19

					if var_35_19 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_15
					end
				end

				arg_32_1.text_.text = var_35_17
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_16, arg_32_1.talkMaxDuration)

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_15) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_15 + var_35_20 and arg_32_1.time_ < var_35_15 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play936041008 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 936041008
		arg_38_1.duration_ = 6.37

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play936041009(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if arg_38_1.actors_["121102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "121102ui_story"))) then
				local var_41_0 = Object.Instantiate(Asset.Load("Char/" .. "121102ui_story"), arg_38_1.stage_.transform)

				var_41_0.name = "121102ui_story"
				var_41_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_38_1.actors_["121102ui_story"] = var_41_0

				local var_41_1 = var_41_0:GetComponentInChildren(typeof(CharacterEffect))

				var_41_1.enabled = true

				local var_41_2 = GameObjectTools.GetOrAddComponent(var_41_0, typeof(DynamicBoneHelper))

				if var_41_2 then
					var_41_2:EnableDynamicBone(false)
				end

				arg_38_1:ShowWeapon(var_41_1.transform, false)

				arg_38_1.var_["121102ui_story" .. "Animator"] = var_41_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_38_1.var_["121102ui_story" .. "Animator"].applyRootMotion = true
				arg_38_1.var_["121102ui_story" .. "LipSync"] = var_41_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_41_3 = arg_38_1.actors_["121102ui_story"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos121102ui_story = var_41_3.localPosition

				local var_41_4 = GameObjectTools.GetOrAddComponent(var_41_3.gameObject, typeof(DynamicBoneHelper))

				if var_41_4 then
					var_41_4:EnableDynamicBone(false)
				end
			end

			local var_41_5 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_5 then
				var_41_3.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos121102ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_38_1.time_ - 0) / var_41_5)
				var_41_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_3.position).x, (manager.ui.mainCamera.transform.position - var_41_3.position).y, (manager.ui.mainCamera.transform.position - var_41_3.position).z)
				var_41_3.localEulerAngles.z = 0
				var_41_3.localEulerAngles.x = 0
				var_41_3.localEulerAngles = var_41_3.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_5 and arg_38_1.time_ < 0 + var_41_5 + arg_41_0 then
				var_41_3.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				var_41_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_3.position).x, (manager.ui.mainCamera.transform.position - var_41_3.position).y, (manager.ui.mainCamera.transform.position - var_41_3.position).z)
				var_41_3.localEulerAngles.z = 0
				var_41_3.localEulerAngles.x = 0
				var_41_3.localEulerAngles = var_41_3.localEulerAngles

				local var_41_6 = GameObjectTools.GetOrAddComponent(var_41_3.gameObject, typeof(DynamicBoneHelper))

				if var_41_6 then
					var_41_6:EnableDynamicBone(true)
				end
			end

			local var_41_7 = arg_38_1.actors_["121102ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_7) and arg_38_1.var_.characterEffect121102ui_story == nil then
				arg_38_1.var_.characterEffect121102ui_story = var_41_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_8 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_8 and not isNil(var_41_7) then
				if arg_38_1.var_.characterEffect121102ui_story and not isNil(var_41_7) then
					arg_38_1.var_.characterEffect121102ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_8 and arg_38_1.time_ < 0 + var_41_8 + arg_41_0 and not isNil(var_41_7) and arg_38_1.var_.characterEffect121102ui_story then
				arg_38_1.var_.characterEffect121102ui_story.fillFlat = false
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_41_10 = 0
			local var_41_11 = 0.725

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_10 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_12 = arg_38_1:GetWordFromCfg(936041008)
				local var_41_13 = arg_38_1:FormatText(var_41_12.content)

				arg_38_1.text_.text = var_41_13

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_15 = 29 <= 0 and var_41_11 or var_41_11 * (utf8.len(var_41_13) / 29)

				if (29 <= 0 and var_41_11 or var_41_11 * (utf8.len(var_41_13) / 29)) > 0 and var_41_11 < var_41_15 then
					arg_38_1.talkMaxDuration = var_41_15

					if var_41_15 + var_41_10 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_15 + var_41_10
					end
				end

				arg_38_1.text_.text = var_41_13
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041008", "story_v_side_old_936041.awb") ~= 0 then
					local var_41_16 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041008", "story_v_side_old_936041.awb") / 1000

					if var_41_16 + var_41_10 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_16 + var_41_10
					end

					if var_41_12.prefab_name ~= "" and arg_38_1.actors_[var_41_12.prefab_name] ~= nil then
						local var_41_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_12.prefab_name].transform, "story_v_side_old_936041", "936041008", "story_v_side_old_936041.awb")

						arg_38_1:RecordAudio("936041008", var_41_17)
						arg_38_1:RecordAudio("936041008", var_41_17)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041008", "story_v_side_old_936041.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041008", "story_v_side_old_936041.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_18 = math.max(var_41_11, arg_38_1.talkMaxDuration)

			if var_41_10 <= arg_38_1.time_ and arg_38_1.time_ < var_41_10 + var_41_18 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_10) / var_41_18

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_10 + var_41_18 and arg_38_1.time_ < var_41_10 + var_41_18 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play936041009 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 936041009
		arg_42_1.duration_ = 4.8

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play936041010(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos614801ui_story = arg_42_1.actors_["614801ui_story"].transform.localPosition

				local var_45_0 = GameObjectTools.GetOrAddComponent(arg_42_1.actors_["614801ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_45_0 then
					var_45_0:EnableDynamicBone(false)
				end
			end

			local var_45_1 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_1 then
				arg_42_1.actors_["614801ui_story"].transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos614801ui_story, Vector3.New(0.7, -0.985, -6), (arg_42_1.time_ - 0) / var_45_1)
				arg_42_1.actors_["614801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["614801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["614801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["614801ui_story"].transform.position).z)
				arg_42_1.actors_["614801ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["614801ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["614801ui_story"].transform.localEulerAngles = arg_42_1.actors_["614801ui_story"].transform.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_1 and arg_42_1.time_ < 0 + var_45_1 + arg_45_0 then
				arg_42_1.actors_["614801ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_42_1.actors_["614801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["614801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["614801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["614801ui_story"].transform.position).z)
				arg_42_1.actors_["614801ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["614801ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["614801ui_story"].transform.localEulerAngles = arg_42_1.actors_["614801ui_story"].transform.localEulerAngles

				local var_45_2 = GameObjectTools.GetOrAddComponent(arg_42_1.actors_["614801ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_45_2 then
					var_45_2:EnableDynamicBone(true)
				end
			end

			local var_45_3 = arg_42_1.actors_["614801ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect614801ui_story == nil then
				arg_42_1.var_.characterEffect614801ui_story = var_45_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_4 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 and not isNil(var_45_3) then
				if arg_42_1.var_.characterEffect614801ui_story and not isNil(var_45_3) then
					arg_42_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect614801ui_story then
				arg_42_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			local var_45_6 = arg_42_1.actors_["121102ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_6) and arg_42_1.var_.characterEffect121102ui_story == nil then
				arg_42_1.var_.characterEffect121102ui_story = var_45_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_7 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 and not isNil(var_45_6) then
				if arg_42_1.var_.characterEffect121102ui_story and not isNil(var_45_6) then
					arg_42_1.var_.characterEffect121102ui_story.fillFlat = true
					arg_42_1.var_.characterEffect121102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_7)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 and not isNil(var_45_6) and arg_42_1.var_.characterEffect121102ui_story then
				arg_42_1.var_.characterEffect121102ui_story.fillFlat = true
				arg_42_1.var_.characterEffect121102ui_story.fillRatio = 0.5
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_45_8 = 0
			local var_45_9 = 0.6

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_10 = arg_42_1:GetWordFromCfg(936041009)
				local var_45_11 = arg_42_1:FormatText(var_45_10.content)

				arg_42_1.text_.text = var_45_11

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_13 = 24 <= 0 and var_45_9 or var_45_9 * (utf8.len(var_45_11) / 24)

				if (24 <= 0 and var_45_9 or var_45_9 * (utf8.len(var_45_11) / 24)) > 0 and var_45_9 < var_45_13 then
					arg_42_1.talkMaxDuration = var_45_13

					if var_45_13 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_13 + var_45_8
					end
				end

				arg_42_1.text_.text = var_45_11
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041009", "story_v_side_old_936041.awb") ~= 0 then
					local var_45_14 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041009", "story_v_side_old_936041.awb") / 1000

					if var_45_14 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_14 + var_45_8
					end

					if var_45_10.prefab_name ~= "" and arg_42_1.actors_[var_45_10.prefab_name] ~= nil then
						local var_45_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_10.prefab_name].transform, "story_v_side_old_936041", "936041009", "story_v_side_old_936041.awb")

						arg_42_1:RecordAudio("936041009", var_45_15)
						arg_42_1:RecordAudio("936041009", var_45_15)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041009", "story_v_side_old_936041.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041009", "story_v_side_old_936041.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_16 = math.max(var_45_9, arg_42_1.talkMaxDuration)

			if var_45_8 <= arg_42_1.time_ and arg_42_1.time_ < var_45_8 + var_45_16 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_8) / var_45_16

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_8 + var_45_16 and arg_42_1.time_ < var_45_8 + var_45_16 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play936041010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 936041010
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play936041011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos614801ui_story = arg_46_1.actors_["614801ui_story"].transform.localPosition

				local var_49_0 = GameObjectTools.GetOrAddComponent(arg_46_1.actors_["614801ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_49_0 then
					var_49_0:EnableDynamicBone(false)
				end
			end

			local var_49_1 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_1 then
				arg_46_1.actors_["614801ui_story"].transform.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos614801ui_story, Vector3.New(0, 100, 0), (arg_46_1.time_ - 0) / var_49_1)
				arg_46_1.actors_["614801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["614801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["614801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["614801ui_story"].transform.position).z)
				arg_46_1.actors_["614801ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["614801ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["614801ui_story"].transform.localEulerAngles = arg_46_1.actors_["614801ui_story"].transform.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_1 and arg_46_1.time_ < 0 + var_49_1 + arg_49_0 then
				arg_46_1.actors_["614801ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.actors_["614801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["614801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["614801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["614801ui_story"].transform.position).z)
				arg_46_1.actors_["614801ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["614801ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["614801ui_story"].transform.localEulerAngles = arg_46_1.actors_["614801ui_story"].transform.localEulerAngles

				local var_49_2 = GameObjectTools.GetOrAddComponent(arg_46_1.actors_["614801ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_49_2 then
					var_49_2:EnableDynamicBone(true)
				end
			end

			local var_49_3 = arg_46_1.actors_["121102ui_story"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos121102ui_story = var_49_3.localPosition

				local var_49_4 = GameObjectTools.GetOrAddComponent(var_49_3.gameObject, typeof(DynamicBoneHelper))

				if var_49_4 then
					var_49_4:EnableDynamicBone(false)
				end
			end

			local var_49_5 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_5 then
				var_49_3.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos121102ui_story, Vector3.New(0, 100, 0), (arg_46_1.time_ - 0) / var_49_5)
				var_49_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_3.position).x, (manager.ui.mainCamera.transform.position - var_49_3.position).y, (manager.ui.mainCamera.transform.position - var_49_3.position).z)
				var_49_3.localEulerAngles.z = 0
				var_49_3.localEulerAngles.x = 0
				var_49_3.localEulerAngles = var_49_3.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_5 and arg_46_1.time_ < 0 + var_49_5 + arg_49_0 then
				var_49_3.localPosition = Vector3.New(0, 100, 0)
				var_49_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_3.position).x, (manager.ui.mainCamera.transform.position - var_49_3.position).y, (manager.ui.mainCamera.transform.position - var_49_3.position).z)
				var_49_3.localEulerAngles.z = 0
				var_49_3.localEulerAngles.x = 0
				var_49_3.localEulerAngles = var_49_3.localEulerAngles

				local var_49_6 = GameObjectTools.GetOrAddComponent(var_49_3.gameObject, typeof(DynamicBoneHelper))

				if var_49_6 then
					var_49_6:EnableDynamicBone(true)
				end
			end

			local var_49_7 = arg_46_1.actors_["105401ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_7) and arg_46_1.var_.characterEffect105401ui_story == nil then
				arg_46_1.var_.characterEffect105401ui_story = var_49_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_8 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_8 and not isNil(var_49_7) then
				if arg_46_1.var_.characterEffect105401ui_story and not isNil(var_49_7) then
					arg_46_1.var_.characterEffect105401ui_story.fillFlat = true
					arg_46_1.var_.characterEffect105401ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_8)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_8 and arg_46_1.time_ < 0 + var_49_8 + arg_49_0 and not isNil(var_49_7) and arg_46_1.var_.characterEffect105401ui_story then
				arg_46_1.var_.characterEffect105401ui_story.fillFlat = true
				arg_46_1.var_.characterEffect105401ui_story.fillRatio = 0.5
			end

			local var_49_9 = 0
			local var_49_10 = 1.25

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_9 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_11 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(936041010).content)

				arg_46_1.text_.text = var_49_11

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_13 = 50 <= 0 and var_49_10 or var_49_10 * (utf8.len(var_49_11) / 50)

				if (50 <= 0 and var_49_10 or var_49_10 * (utf8.len(var_49_11) / 50)) > 0 and var_49_10 < var_49_13 then
					arg_46_1.talkMaxDuration = var_49_13

					if var_49_13 + var_49_9 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_9
					end
				end

				arg_46_1.text_.text = var_49_11
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_14 = math.max(var_49_10, arg_46_1.talkMaxDuration)

			if var_49_9 <= arg_46_1.time_ and arg_46_1.time_ < var_49_9 + var_49_14 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_9) / var_49_14

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_9 + var_49_14 and arg_46_1.time_ < var_49_9 + var_49_14 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play936041011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 936041011
		arg_50_1.duration_ = 5.93

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play936041012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos104402ui_story = arg_50_1.actors_["104402ui_story"].transform.localPosition

				local var_53_0 = GameObjectTools.GetOrAddComponent(arg_50_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_53_0 then
					var_53_0:EnableDynamicBone(false)
				end
			end

			local var_53_1 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_1 then
				arg_50_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_50_1.time_ - 0) / var_53_1)
				arg_50_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["104402ui_story"].transform.position).z)
				arg_50_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["104402ui_story"].transform.localEulerAngles = arg_50_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_1 and arg_50_1.time_ < 0 + var_53_1 + arg_53_0 then
				arg_50_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_50_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["104402ui_story"].transform.position).z)
				arg_50_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["104402ui_story"].transform.localEulerAngles = arg_50_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_53_2 = GameObjectTools.GetOrAddComponent(arg_50_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(true)
				end
			end

			local var_53_3 = arg_50_1.actors_["104402ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_3) and arg_50_1.var_.characterEffect104402ui_story == nil then
				arg_50_1.var_.characterEffect104402ui_story = var_53_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_4 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 and not isNil(var_53_3) then
				if arg_50_1.var_.characterEffect104402ui_story and not isNil(var_53_3) then
					arg_50_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 and not isNil(var_53_3) and arg_50_1.var_.characterEffect104402ui_story then
				arg_50_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_53_6 = 0
			local var_53_7 = 0.625

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_8 = arg_50_1:GetWordFromCfg(936041011)
				local var_53_9 = arg_50_1:FormatText(var_53_8.content)

				arg_50_1.text_.text = var_53_9

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 25 <= 0 and var_53_7 or var_53_7 * (utf8.len(var_53_9) / 25)

				if (25 <= 0 and var_53_7 or var_53_7 * (utf8.len(var_53_9) / 25)) > 0 and var_53_7 < var_53_11 then
					arg_50_1.talkMaxDuration = var_53_11

					if var_53_11 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_11 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_9
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041011", "story_v_side_old_936041.awb") ~= 0 then
					local var_53_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041011", "story_v_side_old_936041.awb") / 1000

					if var_53_12 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_12 + var_53_6
					end

					if var_53_8.prefab_name ~= "" and arg_50_1.actors_[var_53_8.prefab_name] ~= nil then
						local var_53_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_8.prefab_name].transform, "story_v_side_old_936041", "936041011", "story_v_side_old_936041.awb")

						arg_50_1:RecordAudio("936041011", var_53_13)
						arg_50_1:RecordAudio("936041011", var_53_13)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041011", "story_v_side_old_936041.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041011", "story_v_side_old_936041.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_14 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_14 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_14

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_14 and arg_50_1.time_ < var_53_6 + var_53_14 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play936041012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 936041012
		arg_54_1.duration_ = 4.17

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play936041013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos104402ui_story = arg_54_1.actors_["104402ui_story"].transform.localPosition

				local var_57_0 = GameObjectTools.GetOrAddComponent(arg_54_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_57_0 then
					var_57_0:EnableDynamicBone(false)
				end
			end

			local var_57_1 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_1 then
				arg_54_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_54_1.time_ - 0) / var_57_1)
				arg_54_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["104402ui_story"].transform.position).z)
				arg_54_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["104402ui_story"].transform.localEulerAngles = arg_54_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_1 and arg_54_1.time_ < 0 + var_57_1 + arg_57_0 then
				arg_54_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_54_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["104402ui_story"].transform.position).z)
				arg_54_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["104402ui_story"].transform.localEulerAngles = arg_54_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_57_2 = GameObjectTools.GetOrAddComponent(arg_54_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_57_2 then
					var_57_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402actionlink/104402action435")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_57_3 = 0
			local var_57_4 = 0.55

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_3 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_5 = arg_54_1:GetWordFromCfg(936041012)
				local var_57_6 = arg_54_1:FormatText(var_57_5.content)

				arg_54_1.text_.text = var_57_6

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_8 = 22 <= 0 and var_57_4 or var_57_4 * (utf8.len(var_57_6) / 22)

				if (22 <= 0 and var_57_4 or var_57_4 * (utf8.len(var_57_6) / 22)) > 0 and var_57_4 < var_57_8 then
					arg_54_1.talkMaxDuration = var_57_8

					if var_57_8 + var_57_3 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_3
					end
				end

				arg_54_1.text_.text = var_57_6
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041012", "story_v_side_old_936041.awb") ~= 0 then
					local var_57_9 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041012", "story_v_side_old_936041.awb") / 1000

					if var_57_9 + var_57_3 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_9 + var_57_3
					end

					if var_57_5.prefab_name ~= "" and arg_54_1.actors_[var_57_5.prefab_name] ~= nil then
						local var_57_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_5.prefab_name].transform, "story_v_side_old_936041", "936041012", "story_v_side_old_936041.awb")

						arg_54_1:RecordAudio("936041012", var_57_10)
						arg_54_1:RecordAudio("936041012", var_57_10)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041012", "story_v_side_old_936041.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041012", "story_v_side_old_936041.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_11 = math.max(var_57_4, arg_54_1.talkMaxDuration)

			if var_57_3 <= arg_54_1.time_ and arg_54_1.time_ < var_57_3 + var_57_11 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_3) / var_57_11

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_3 + var_57_11 and arg_54_1.time_ < var_57_3 + var_57_11 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play936041013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 936041013
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play936041014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["104402ui_story"]) and arg_58_1.var_.characterEffect104402ui_story == nil then
				arg_58_1.var_.characterEffect104402ui_story = arg_58_1.actors_["104402ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["104402ui_story"]) then
				if arg_58_1.var_.characterEffect104402ui_story and not isNil(arg_58_1.actors_["104402ui_story"]) then
					arg_58_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_58_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_0)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["104402ui_story"]) and arg_58_1.var_.characterEffect104402ui_story then
				arg_58_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_58_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_61_1 = 0
			local var_61_2 = 0.825

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(936041013).content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 33 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 33)

				if (33 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 33)) > 0 and var_61_2 < var_61_5 then
					arg_58_1.talkMaxDuration = var_61_5

					if var_61_5 + var_61_1 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + var_61_1
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_6 = math.max(var_61_2, arg_58_1.talkMaxDuration)

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_6 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_1) / var_61_6

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_1 + var_61_6 and arg_58_1.time_ < var_61_1 + var_61_6 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play936041014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 936041014
		arg_62_1.duration_ = 4.47

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play936041015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["104402ui_story"]) and arg_62_1.var_.characterEffect104402ui_story == nil then
				arg_62_1.var_.characterEffect104402ui_story = arg_62_1.actors_["104402ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["104402ui_story"]) then
				if arg_62_1.var_.characterEffect104402ui_story and not isNil(arg_62_1.actors_["104402ui_story"]) then
					arg_62_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["104402ui_story"]) and arg_62_1.var_.characterEffect104402ui_story then
				arg_62_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action5_2")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_65_2 = 0
			local var_65_3 = 0.425

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_4 = arg_62_1:GetWordFromCfg(936041014)
				local var_65_5 = arg_62_1:FormatText(var_65_4.content)

				arg_62_1.text_.text = var_65_5

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_7 = 17 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 17)

				if (17 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 17)) > 0 and var_65_3 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_5
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041014", "story_v_side_old_936041.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041014", "story_v_side_old_936041.awb") / 1000

					if var_65_8 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_2
					end

					if var_65_4.prefab_name ~= "" and arg_62_1.actors_[var_65_4.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_4.prefab_name].transform, "story_v_side_old_936041", "936041014", "story_v_side_old_936041.awb")

						arg_62_1:RecordAudio("936041014", var_65_9)
						arg_62_1:RecordAudio("936041014", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041014", "story_v_side_old_936041.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041014", "story_v_side_old_936041.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_3, arg_62_1.talkMaxDuration)

			if var_65_2 <= arg_62_1.time_ and arg_62_1.time_ < var_65_2 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_2) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_2 + var_65_10 and arg_62_1.time_ < var_65_2 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play936041015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 936041015
		arg_66_1.duration_ = 5.5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play936041016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos104402ui_story = arg_66_1.actors_["104402ui_story"].transform.localPosition

				local var_69_0 = GameObjectTools.GetOrAddComponent(arg_66_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_69_0 then
					var_69_0:EnableDynamicBone(false)
				end
			end

			local var_69_1 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_1 then
				arg_66_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_66_1.time_ - 0) / var_69_1)
				arg_66_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["104402ui_story"].transform.position).z)
				arg_66_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["104402ui_story"].transform.localEulerAngles = arg_66_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_1 and arg_66_1.time_ < 0 + var_69_1 + arg_69_0 then
				arg_66_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_66_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["104402ui_story"].transform.position).z)
				arg_66_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["104402ui_story"].transform.localEulerAngles = arg_66_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_69_2 = GameObjectTools.GetOrAddComponent(arg_66_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_69_3 = 0
			local var_69_4 = 0.675

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_3 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_5 = arg_66_1:GetWordFromCfg(936041015)
				local var_69_6 = arg_66_1:FormatText(var_69_5.content)

				arg_66_1.text_.text = var_69_6

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_8 = 27 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_6) / 27)

				if (27 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_6) / 27)) > 0 and var_69_4 < var_69_8 then
					arg_66_1.talkMaxDuration = var_69_8

					if var_69_8 + var_69_3 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_3
					end
				end

				arg_66_1.text_.text = var_69_6
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041015", "story_v_side_old_936041.awb") ~= 0 then
					local var_69_9 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041015", "story_v_side_old_936041.awb") / 1000

					if var_69_9 + var_69_3 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_3
					end

					if var_69_5.prefab_name ~= "" and arg_66_1.actors_[var_69_5.prefab_name] ~= nil then
						local var_69_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_5.prefab_name].transform, "story_v_side_old_936041", "936041015", "story_v_side_old_936041.awb")

						arg_66_1:RecordAudio("936041015", var_69_10)
						arg_66_1:RecordAudio("936041015", var_69_10)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041015", "story_v_side_old_936041.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041015", "story_v_side_old_936041.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_11 = math.max(var_69_4, arg_66_1.talkMaxDuration)

			if var_69_3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_3 + var_69_11 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_3) / var_69_11

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_3 + var_69_11 and arg_66_1.time_ < var_69_3 + var_69_11 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play936041016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 936041016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play936041017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["104402ui_story"]) and arg_70_1.var_.characterEffect104402ui_story == nil then
				arg_70_1.var_.characterEffect104402ui_story = arg_70_1.actors_["104402ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["104402ui_story"]) then
				if arg_70_1.var_.characterEffect104402ui_story and not isNil(arg_70_1.actors_["104402ui_story"]) then
					arg_70_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_70_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_0)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["104402ui_story"]) and arg_70_1.var_.characterEffect104402ui_story then
				arg_70_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_70_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_73_1 = 0
			local var_73_2 = 0.425

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(936041016).content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 17 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 17)

				if (17 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 17)) > 0 and var_73_2 < var_73_5 then
					arg_70_1.talkMaxDuration = var_73_5

					if var_73_5 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_6 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_6 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_6

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_6 and arg_70_1.time_ < var_73_1 + var_73_6 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play936041017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 936041017
		arg_74_1.duration_ = 8.83

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play936041018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos104402ui_story = arg_74_1.actors_["104402ui_story"].transform.localPosition

				local var_77_0 = GameObjectTools.GetOrAddComponent(arg_74_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_77_0 then
					var_77_0:EnableDynamicBone(false)
				end
			end

			local var_77_1 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_1 then
				arg_74_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_74_1.time_ - 0) / var_77_1)
				arg_74_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["104402ui_story"].transform.position).z)
				arg_74_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["104402ui_story"].transform.localEulerAngles = arg_74_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_1 and arg_74_1.time_ < 0 + var_77_1 + arg_77_0 then
				arg_74_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_74_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["104402ui_story"].transform.position).z)
				arg_74_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["104402ui_story"].transform.localEulerAngles = arg_74_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_77_2 = GameObjectTools.GetOrAddComponent(arg_74_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_77_2 then
					var_77_2:EnableDynamicBone(true)
				end
			end

			local var_77_3 = arg_74_1.actors_["104402ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_3) and arg_74_1.var_.characterEffect104402ui_story == nil then
				arg_74_1.var_.characterEffect104402ui_story = var_77_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_4 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 and not isNil(var_77_3) then
				if arg_74_1.var_.characterEffect104402ui_story and not isNil(var_77_3) then
					arg_74_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 and not isNil(var_77_3) and arg_74_1.var_.characterEffect104402ui_story then
				arg_74_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_2")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_77_6 = 0
			local var_77_7 = 0.975

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_8 = arg_74_1:GetWordFromCfg(936041017)
				local var_77_9 = arg_74_1:FormatText(var_77_8.content)

				arg_74_1.text_.text = var_77_9

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_11 = 39 <= 0 and var_77_7 or var_77_7 * (utf8.len(var_77_9) / 39)

				if (39 <= 0 and var_77_7 or var_77_7 * (utf8.len(var_77_9) / 39)) > 0 and var_77_7 < var_77_11 then
					arg_74_1.talkMaxDuration = var_77_11

					if var_77_11 + var_77_6 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_11 + var_77_6
					end
				end

				arg_74_1.text_.text = var_77_9
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041017", "story_v_side_old_936041.awb") ~= 0 then
					local var_77_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041017", "story_v_side_old_936041.awb") / 1000

					if var_77_12 + var_77_6 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_12 + var_77_6
					end

					if var_77_8.prefab_name ~= "" and arg_74_1.actors_[var_77_8.prefab_name] ~= nil then
						local var_77_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_8.prefab_name].transform, "story_v_side_old_936041", "936041017", "story_v_side_old_936041.awb")

						arg_74_1:RecordAudio("936041017", var_77_13)
						arg_74_1:RecordAudio("936041017", var_77_13)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041017", "story_v_side_old_936041.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041017", "story_v_side_old_936041.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_14 = math.max(var_77_7, arg_74_1.talkMaxDuration)

			if var_77_6 <= arg_74_1.time_ and arg_74_1.time_ < var_77_6 + var_77_14 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_6) / var_77_14

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_6 + var_77_14 and arg_74_1.time_ < var_77_6 + var_77_14 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play936041018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 936041018
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play936041019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["104402ui_story"]) and arg_78_1.var_.characterEffect104402ui_story == nil then
				arg_78_1.var_.characterEffect104402ui_story = arg_78_1.actors_["104402ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["104402ui_story"]) then
				if arg_78_1.var_.characterEffect104402ui_story and not isNil(arg_78_1.actors_["104402ui_story"]) then
					arg_78_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_78_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_0)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["104402ui_story"]) and arg_78_1.var_.characterEffect104402ui_story then
				arg_78_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_78_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_81_1 = 0
			local var_81_2 = 0.4

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_3 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(936041018).content)

				arg_78_1.text_.text = var_81_3

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 16 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_3) / 16)

				if (16 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_3) / 16)) > 0 and var_81_2 < var_81_5 then
					arg_78_1.talkMaxDuration = var_81_5

					if var_81_5 + var_81_1 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + var_81_1
					end
				end

				arg_78_1.text_.text = var_81_3
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_6 = math.max(var_81_2, arg_78_1.talkMaxDuration)

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_6 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_1) / var_81_6

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_1 + var_81_6 and arg_78_1.time_ < var_81_1 + var_81_6 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play936041019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 936041019
		arg_82_1.duration_ = 9.97

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play936041020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos104402ui_story = arg_82_1.actors_["104402ui_story"].transform.localPosition

				local var_85_0 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_0 then
					var_85_0:EnableDynamicBone(false)
				end
			end

			local var_85_1 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_1 then
				arg_82_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_82_1.time_ - 0) / var_85_1)
				arg_82_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["104402ui_story"].transform.position).z)
				arg_82_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["104402ui_story"].transform.localEulerAngles = arg_82_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_1 and arg_82_1.time_ < 0 + var_85_1 + arg_85_0 then
				arg_82_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_82_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["104402ui_story"].transform.position).z)
				arg_82_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["104402ui_story"].transform.localEulerAngles = arg_82_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_85_2 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(true)
				end
			end

			local var_85_3 = arg_82_1.actors_["104402ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect104402ui_story == nil then
				arg_82_1.var_.characterEffect104402ui_story = var_85_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_4 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 and not isNil(var_85_3) then
				if arg_82_1.var_.characterEffect104402ui_story and not isNil(var_85_3) then
					arg_82_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect104402ui_story then
				arg_82_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_85_6 = 0
			local var_85_7 = 1.075

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_8 = arg_82_1:GetWordFromCfg(936041019)
				local var_85_9 = arg_82_1:FormatText(var_85_8.content)

				arg_82_1.text_.text = var_85_9

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 43 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 43)

				if (43 <= 0 and var_85_7 or var_85_7 * (utf8.len(var_85_9) / 43)) > 0 and var_85_7 < var_85_11 then
					arg_82_1.talkMaxDuration = var_85_11

					if var_85_11 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_9
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041019", "story_v_side_old_936041.awb") ~= 0 then
					local var_85_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041019", "story_v_side_old_936041.awb") / 1000

					if var_85_12 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_12 + var_85_6
					end

					if var_85_8.prefab_name ~= "" and arg_82_1.actors_[var_85_8.prefab_name] ~= nil then
						local var_85_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_8.prefab_name].transform, "story_v_side_old_936041", "936041019", "story_v_side_old_936041.awb")

						arg_82_1:RecordAudio("936041019", var_85_13)
						arg_82_1:RecordAudio("936041019", var_85_13)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041019", "story_v_side_old_936041.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041019", "story_v_side_old_936041.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_14 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_14 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_14

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_14 and arg_82_1.time_ < var_85_6 + var_85_14 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play936041020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 936041020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play936041021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["104402ui_story"]) and arg_86_1.var_.characterEffect104402ui_story == nil then
				arg_86_1.var_.characterEffect104402ui_story = arg_86_1.actors_["104402ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["104402ui_story"]) then
				if arg_86_1.var_.characterEffect104402ui_story and not isNil(arg_86_1.actors_["104402ui_story"]) then
					arg_86_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_86_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_0)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["104402ui_story"]) and arg_86_1.var_.characterEffect104402ui_story then
				arg_86_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_86_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_89_1 = 0
			local var_89_2 = 0.875

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_3 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(936041020).content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 35 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 35)

				if (35 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 35)) > 0 and var_89_2 < var_89_5 then
					arg_86_1.talkMaxDuration = var_89_5

					if var_89_5 + var_89_1 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + var_89_1
					end
				end

				arg_86_1.text_.text = var_89_3
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_6 = math.max(var_89_2, arg_86_1.talkMaxDuration)

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_6 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_1) / var_89_6

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_1 + var_89_6 and arg_86_1.time_ < var_89_1 + var_89_6 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play936041021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 936041021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play936041022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.625

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_1 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(936041021).content)

				arg_90_1.text_.text = var_93_1

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_3 = 25 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 25)

				if (25 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 25)) > 0 and var_93_0 < var_93_3 then
					arg_90_1.talkMaxDuration = var_93_3

					if var_93_3 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_3 + 0
					end
				end

				arg_90_1.text_.text = var_93_1
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_4 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_4

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play936041022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 936041022
		arg_94_1.duration_ = 2

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play936041023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos104402ui_story = arg_94_1.actors_["104402ui_story"].transform.localPosition

				local var_97_0 = GameObjectTools.GetOrAddComponent(arg_94_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_97_0 then
					var_97_0:EnableDynamicBone(false)
				end
			end

			local var_97_1 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_1 then
				arg_94_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_94_1.time_ - 0) / var_97_1)
				arg_94_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["104402ui_story"].transform.position).z)
				arg_94_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["104402ui_story"].transform.localEulerAngles = arg_94_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_1 and arg_94_1.time_ < 0 + var_97_1 + arg_97_0 then
				arg_94_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_94_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["104402ui_story"].transform.position).z)
				arg_94_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["104402ui_story"].transform.localEulerAngles = arg_94_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_97_2 = GameObjectTools.GetOrAddComponent(arg_94_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(true)
				end
			end

			local var_97_3 = arg_94_1.actors_["104402ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect104402ui_story == nil then
				arg_94_1.var_.characterEffect104402ui_story = var_97_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_4 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 and not isNil(var_97_3) then
				if arg_94_1.var_.characterEffect104402ui_story and not isNil(var_97_3) then
					arg_94_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect104402ui_story then
				arg_94_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_97_6 = 0
			local var_97_7 = 0.15

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_8 = arg_94_1:GetWordFromCfg(936041022)
				local var_97_9 = arg_94_1:FormatText(var_97_8.content)

				arg_94_1.text_.text = var_97_9

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 6 <= 0 and var_97_7 or var_97_7 * (utf8.len(var_97_9) / 6)

				if (6 <= 0 and var_97_7 or var_97_7 * (utf8.len(var_97_9) / 6)) > 0 and var_97_7 < var_97_11 then
					arg_94_1.talkMaxDuration = var_97_11

					if var_97_11 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_11 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_9
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041022", "story_v_side_old_936041.awb") ~= 0 then
					local var_97_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041022", "story_v_side_old_936041.awb") / 1000

					if var_97_12 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_12 + var_97_6
					end

					if var_97_8.prefab_name ~= "" and arg_94_1.actors_[var_97_8.prefab_name] ~= nil then
						local var_97_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_8.prefab_name].transform, "story_v_side_old_936041", "936041022", "story_v_side_old_936041.awb")

						arg_94_1:RecordAudio("936041022", var_97_13)
						arg_94_1:RecordAudio("936041022", var_97_13)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041022", "story_v_side_old_936041.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041022", "story_v_side_old_936041.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_14 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_14 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_14

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_14 and arg_94_1.time_ < var_97_6 + var_97_14 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play936041023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 936041023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play936041024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos104402ui_story = arg_98_1.actors_["104402ui_story"].transform.localPosition

				local var_101_0 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_0 then
					var_101_0:EnableDynamicBone(false)
				end
			end

			local var_101_1 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_1 then
				arg_98_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_1)
				arg_98_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["104402ui_story"].transform.position).z)
				arg_98_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["104402ui_story"].transform.localEulerAngles = arg_98_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_1 and arg_98_1.time_ < 0 + var_101_1 + arg_101_0 then
				arg_98_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["104402ui_story"].transform.position).z)
				arg_98_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["104402ui_story"].transform.localEulerAngles = arg_98_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_101_2 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(true)
				end
			end

			local var_101_3 = arg_98_1.actors_["104402ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_3) and arg_98_1.var_.characterEffect104402ui_story == nil then
				arg_98_1.var_.characterEffect104402ui_story = var_101_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_4 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 and not isNil(var_101_3) then
				if arg_98_1.var_.characterEffect104402ui_story and not isNil(var_101_3) then
					arg_98_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_98_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_4)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 and not isNil(var_101_3) and arg_98_1.var_.characterEffect104402ui_story then
				arg_98_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_98_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			if 0.7 < arg_98_1.time_ and arg_98_1.time_ <= 0.7 + arg_101_0 then
				arg_98_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_side_1033_footstep", "")
			end

			local var_101_6 = 0
			local var_101_7 = 1

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_8 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(936041023).content)

				arg_98_1.text_.text = var_101_8

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_10 = 40 <= 0 and var_101_7 or var_101_7 * (utf8.len(var_101_8) / 40)

				if (40 <= 0 and var_101_7 or var_101_7 * (utf8.len(var_101_8) / 40)) > 0 and var_101_7 < var_101_10 then
					arg_98_1.talkMaxDuration = var_101_10

					if var_101_10 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_8
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_11 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_11 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_11

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_11 and arg_98_1.time_ < var_101_6 + var_101_11 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play936041024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 936041024
		arg_102_1.duration_ = 5.07

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play936041025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos104402ui_story = arg_102_1.actors_["104402ui_story"].transform.localPosition

				local var_105_0 = GameObjectTools.GetOrAddComponent(arg_102_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_105_0 then
					var_105_0:EnableDynamicBone(false)
				end
			end

			local var_105_1 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_1 then
				arg_102_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_102_1.time_ - 0) / var_105_1)
				arg_102_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["104402ui_story"].transform.position).z)
				arg_102_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["104402ui_story"].transform.localEulerAngles = arg_102_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_1 and arg_102_1.time_ < 0 + var_105_1 + arg_105_0 then
				arg_102_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_102_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["104402ui_story"].transform.position).z)
				arg_102_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["104402ui_story"].transform.localEulerAngles = arg_102_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_105_2 = GameObjectTools.GetOrAddComponent(arg_102_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_105_2 then
					var_105_2:EnableDynamicBone(true)
				end
			end

			local var_105_3 = arg_102_1.actors_["104402ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_3) and arg_102_1.var_.characterEffect104402ui_story == nil then
				arg_102_1.var_.characterEffect104402ui_story = var_105_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_4 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 and not isNil(var_105_3) then
				if arg_102_1.var_.characterEffect104402ui_story and not isNil(var_105_3) then
					arg_102_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 and not isNil(var_105_3) and arg_102_1.var_.characterEffect104402ui_story then
				arg_102_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402actionlink/104402action438")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_105_6 = 0
			local var_105_7 = 0.5

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_8 = arg_102_1:GetWordFromCfg(936041024)
				local var_105_9 = arg_102_1:FormatText(var_105_8.content)

				arg_102_1.text_.text = var_105_9

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 20 <= 0 and var_105_7 or var_105_7 * (utf8.len(var_105_9) / 20)

				if (20 <= 0 and var_105_7 or var_105_7 * (utf8.len(var_105_9) / 20)) > 0 and var_105_7 < var_105_11 then
					arg_102_1.talkMaxDuration = var_105_11

					if var_105_11 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_11 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_9
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041024", "story_v_side_old_936041.awb") ~= 0 then
					local var_105_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041024", "story_v_side_old_936041.awb") / 1000

					if var_105_12 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_12 + var_105_6
					end

					if var_105_8.prefab_name ~= "" and arg_102_1.actors_[var_105_8.prefab_name] ~= nil then
						local var_105_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_8.prefab_name].transform, "story_v_side_old_936041", "936041024", "story_v_side_old_936041.awb")

						arg_102_1:RecordAudio("936041024", var_105_13)
						arg_102_1:RecordAudio("936041024", var_105_13)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041024", "story_v_side_old_936041.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041024", "story_v_side_old_936041.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_14 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_14 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_14

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_14 and arg_102_1.time_ < var_105_6 + var_105_14 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play936041025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 936041025
		arg_106_1.duration_ = 3.7

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play936041026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos104402ui_story = arg_106_1.actors_["104402ui_story"].transform.localPosition

				local var_109_0 = GameObjectTools.GetOrAddComponent(arg_106_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_109_0 then
					var_109_0:EnableDynamicBone(false)
				end
			end

			local var_109_1 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_1 then
				arg_106_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_106_1.time_ - 0) / var_109_1)
				arg_106_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["104402ui_story"].transform.position).z)
				arg_106_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["104402ui_story"].transform.localEulerAngles = arg_106_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_1 and arg_106_1.time_ < 0 + var_109_1 + arg_109_0 then
				arg_106_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_106_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["104402ui_story"].transform.position).z)
				arg_106_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["104402ui_story"].transform.localEulerAngles = arg_106_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_109_2 = GameObjectTools.GetOrAddComponent(arg_106_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_2")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_109_3 = 0
			local var_109_4 = 0.5

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_3 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_5 = arg_106_1:GetWordFromCfg(936041025)
				local var_109_6 = arg_106_1:FormatText(var_109_5.content)

				arg_106_1.text_.text = var_109_6

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_8 = 20 <= 0 and var_109_4 or var_109_4 * (utf8.len(var_109_6) / 20)

				if (20 <= 0 and var_109_4 or var_109_4 * (utf8.len(var_109_6) / 20)) > 0 and var_109_4 < var_109_8 then
					arg_106_1.talkMaxDuration = var_109_8

					if var_109_8 + var_109_3 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_3
					end
				end

				arg_106_1.text_.text = var_109_6
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041025", "story_v_side_old_936041.awb") ~= 0 then
					local var_109_9 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041025", "story_v_side_old_936041.awb") / 1000

					if var_109_9 + var_109_3 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_3
					end

					if var_109_5.prefab_name ~= "" and arg_106_1.actors_[var_109_5.prefab_name] ~= nil then
						local var_109_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_5.prefab_name].transform, "story_v_side_old_936041", "936041025", "story_v_side_old_936041.awb")

						arg_106_1:RecordAudio("936041025", var_109_10)
						arg_106_1:RecordAudio("936041025", var_109_10)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041025", "story_v_side_old_936041.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041025", "story_v_side_old_936041.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_11 = math.max(var_109_4, arg_106_1.talkMaxDuration)

			if var_109_3 <= arg_106_1.time_ and arg_106_1.time_ < var_109_3 + var_109_11 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_3) / var_109_11

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_3 + var_109_11 and arg_106_1.time_ < var_109_3 + var_109_11 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play936041026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 936041026
		arg_110_1.duration_ = 5.47

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play936041027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if arg_110_1.bgs_.X206_g == nil then
				local var_113_0 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X206_g")
				var_113_0.name = "X206_g"
				var_113_0.transform.parent = arg_110_1.stage_.transform
				var_113_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_.X206_g = var_113_0
			end

			if 2 < arg_110_1.time_ and arg_110_1.time_ <= 2 + arg_113_0 then
				local var_113_1 = arg_110_1.bgs_.X206_g

				arg_110_1.bgs_.X206_g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_113_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_2 = var_113_1:GetComponent("SpriteRenderer")

				if var_113_2 and var_113_2.sprite then
					local var_113_3 = 2 * (var_113_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_113_1.transform.localScale = Vector3.New(var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "X206_g" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_4 = 4

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			if arg_110_1.time_ >= var_113_4 + 0.3 and arg_110_1.time_ < var_113_4 + 0.3 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_5 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_6 = 2

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 then
				local var_113_7 = Color.New(0, 0, 0)

				var_113_7.a = Mathf.Lerp(0, 1, (arg_110_1.time_ - var_113_5) / var_113_6)
				arg_110_1.mask_.color = var_113_7
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 then
				local var_113_8 = Color.New(0, 0, 0)

				var_113_8.a = 1
				arg_110_1.mask_.color = var_113_8
			end

			local var_113_9 = 2

			if 2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_10 = 2

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_10 then
				local var_113_11 = Color.New(0, 0, 0)

				var_113_11.a = Mathf.Lerp(1, 0, (arg_110_1.time_ - var_113_9) / var_113_10)
				arg_110_1.mask_.color = var_113_11
			end

			if arg_110_1.time_ >= var_113_9 + var_113_10 and arg_110_1.time_ < var_113_9 + var_113_10 + arg_113_0 then
				local var_113_12 = Color.New(0, 0, 0)

				arg_110_1.mask_.enabled = false
				var_113_12.a = 0
				arg_110_1.mask_.color = var_113_12
			end

			local var_113_13 = arg_110_1.actors_["104402ui_story"].transform

			if 1.96599999815226 < arg_110_1.time_ and arg_110_1.time_ <= 1.96599999815226 + arg_113_0 then
				arg_110_1.var_.moveOldPos104402ui_story = var_113_13.localPosition

				local var_113_14 = GameObjectTools.GetOrAddComponent(var_113_13.gameObject, typeof(DynamicBoneHelper))

				if var_113_14 then
					var_113_14:EnableDynamicBone(false)
				end
			end

			local var_113_15 = 0.001

			if 1.96599999815226 <= arg_110_1.time_ and arg_110_1.time_ < 1.96599999815226 + var_113_15 then
				var_113_13.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 1.96599999815226) / var_113_15)
				var_113_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_13.position).x, (manager.ui.mainCamera.transform.position - var_113_13.position).y, (manager.ui.mainCamera.transform.position - var_113_13.position).z)
				var_113_13.localEulerAngles.z = 0
				var_113_13.localEulerAngles.x = 0
				var_113_13.localEulerAngles = var_113_13.localEulerAngles
			end

			if arg_110_1.time_ >= 1.96599999815226 + var_113_15 and arg_110_1.time_ < 1.96599999815226 + var_113_15 + arg_113_0 then
				var_113_13.localPosition = Vector3.New(0, 100, 0)
				var_113_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_13.position).x, (manager.ui.mainCamera.transform.position - var_113_13.position).y, (manager.ui.mainCamera.transform.position - var_113_13.position).z)
				var_113_13.localEulerAngles.z = 0
				var_113_13.localEulerAngles.x = 0
				var_113_13.localEulerAngles = var_113_13.localEulerAngles

				local var_113_16 = GameObjectTools.GetOrAddComponent(var_113_13.gameObject, typeof(DynamicBoneHelper))

				if var_113_16 then
					var_113_16:EnableDynamicBone(true)
				end
			end

			local var_113_17 = arg_110_1.actors_["104402ui_story"]

			if 1.96599999815226 < arg_110_1.time_ and arg_110_1.time_ <= 1.96599999815226 + arg_113_0 and not isNil(var_113_17) and arg_110_1.var_.characterEffect104402ui_story == nil then
				arg_110_1.var_.characterEffect104402ui_story = var_113_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_18 = 0.034000001847744

			if 1.96599999815226 <= arg_110_1.time_ and arg_110_1.time_ < 1.96599999815226 + var_113_18 and not isNil(var_113_17) then
				if arg_110_1.var_.characterEffect104402ui_story and not isNil(var_113_17) then
					arg_110_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_110_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 1.96599999815226) / var_113_18)
				end
			end

			if arg_110_1.time_ >= 1.96599999815226 + var_113_18 and arg_110_1.time_ < 1.96599999815226 + var_113_18 + arg_113_0 and not isNil(var_113_17) and arg_110_1.var_.characterEffect104402ui_story then
				arg_110_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_110_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			if 0.133333333333333 < arg_110_1.time_ and arg_110_1.time_ <= 0.133333333333333 + arg_113_0 then
				arg_110_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 1.66666666666667 < arg_110_1.time_ and arg_110_1.time_ <= 1.66666666666667 + arg_113_0 then
				arg_110_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_21 = 4
			local var_113_22 = 0.1

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_21 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_23 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_23:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_24 = arg_110_1:GetWordFromCfg(936041026)
				local var_113_25 = arg_110_1:FormatText(var_113_24.content)

				arg_110_1.text_.text = var_113_25

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_27 = 4 <= 0 and var_113_22 or var_113_22 * (utf8.len(var_113_25) / 4)

				if (4 <= 0 and var_113_22 or var_113_22 * (utf8.len(var_113_25) / 4)) > 0 and var_113_22 < var_113_27 then
					arg_110_1.talkMaxDuration = var_113_27
					var_113_21 = var_113_21 + 0.3

					if var_113_27 + var_113_21 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_27 + var_113_21
					end
				end

				arg_110_1.text_.text = var_113_25
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041026", "story_v_side_old_936041.awb") ~= 0 then
					local var_113_28 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041026", "story_v_side_old_936041.awb") / 1000

					if var_113_28 + var_113_21 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_28 + var_113_21
					end

					if var_113_24.prefab_name ~= "" and arg_110_1.actors_[var_113_24.prefab_name] ~= nil then
						local var_113_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_24.prefab_name].transform, "story_v_side_old_936041", "936041026", "story_v_side_old_936041.awb")

						arg_110_1:RecordAudio("936041026", var_113_29)
						arg_110_1:RecordAudio("936041026", var_113_29)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041026", "story_v_side_old_936041.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041026", "story_v_side_old_936041.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_30 = var_113_21 + 0.3
			local var_113_31 = math.max(var_113_22, arg_110_1.talkMaxDuration)

			if var_113_21 + 0.3 <= arg_110_1.time_ and arg_110_1.time_ < var_113_30 + var_113_31 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_30) / var_113_31

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_30 + var_113_31 and arg_110_1.time_ < var_113_30 + var_113_31 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play936041027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 936041027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play936041028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_cheers", "")
			end

			local var_119_1 = 0
			local var_119_2 = 1.525

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(936041027).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 61 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 61)

				if (61 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 61)) > 0 and var_119_2 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_6 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_6 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_6

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_6 and arg_116_1.time_ < var_119_1 + var_119_6 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play936041028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 936041028
		arg_120_1.duration_ = 4.8

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play936041029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos614801ui_story = arg_120_1.actors_["614801ui_story"].transform.localPosition

				local var_123_0 = GameObjectTools.GetOrAddComponent(arg_120_1.actors_["614801ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_123_0 then
					var_123_0:EnableDynamicBone(false)
				end
			end

			local var_123_1 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_1 then
				arg_120_1.actors_["614801ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos614801ui_story, Vector3.New(-0.7, -0.985, -6), (arg_120_1.time_ - 0) / var_123_1)
				arg_120_1.actors_["614801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["614801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["614801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["614801ui_story"].transform.position).z)
				arg_120_1.actors_["614801ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["614801ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["614801ui_story"].transform.localEulerAngles = arg_120_1.actors_["614801ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_1 and arg_120_1.time_ < 0 + var_123_1 + arg_123_0 then
				arg_120_1.actors_["614801ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_120_1.actors_["614801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["614801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["614801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["614801ui_story"].transform.position).z)
				arg_120_1.actors_["614801ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["614801ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["614801ui_story"].transform.localEulerAngles = arg_120_1.actors_["614801ui_story"].transform.localEulerAngles

				local var_123_2 = GameObjectTools.GetOrAddComponent(arg_120_1.actors_["614801ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(true)
				end
			end

			local var_123_3 = arg_120_1.actors_["614801ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect614801ui_story == nil then
				arg_120_1.var_.characterEffect614801ui_story = var_123_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_4 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 and not isNil(var_123_3) then
				if arg_120_1.var_.characterEffect614801ui_story and not isNil(var_123_3) then
					arg_120_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect614801ui_story then
				arg_120_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_123_6 = 0
			local var_123_7 = 0.7

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_8 = arg_120_1:GetWordFromCfg(936041028)
				local var_123_9 = arg_120_1:FormatText(var_123_8.content)

				arg_120_1.text_.text = var_123_9

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 28 <= 0 and var_123_7 or var_123_7 * (utf8.len(var_123_9) / 28)

				if (28 <= 0 and var_123_7 or var_123_7 * (utf8.len(var_123_9) / 28)) > 0 and var_123_7 < var_123_11 then
					arg_120_1.talkMaxDuration = var_123_11

					if var_123_11 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_9
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041028", "story_v_side_old_936041.awb") ~= 0 then
					local var_123_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041028", "story_v_side_old_936041.awb") / 1000

					if var_123_12 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_12 + var_123_6
					end

					if var_123_8.prefab_name ~= "" and arg_120_1.actors_[var_123_8.prefab_name] ~= nil then
						local var_123_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_8.prefab_name].transform, "story_v_side_old_936041", "936041028", "story_v_side_old_936041.awb")

						arg_120_1:RecordAudio("936041028", var_123_13)
						arg_120_1:RecordAudio("936041028", var_123_13)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041028", "story_v_side_old_936041.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041028", "story_v_side_old_936041.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_14 and arg_120_1.time_ < var_123_6 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play936041029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 936041029
		arg_124_1.duration_ = 4.93

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play936041030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos121102ui_story = arg_124_1.actors_["121102ui_story"].transform.localPosition

				local var_127_0 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["121102ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_0 then
					var_127_0:EnableDynamicBone(false)
				end
			end

			local var_127_1 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_1 then
				arg_124_1.actors_["121102ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos121102ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_124_1.time_ - 0) / var_127_1)
				arg_124_1.actors_["121102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["121102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["121102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["121102ui_story"].transform.position).z)
				arg_124_1.actors_["121102ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["121102ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["121102ui_story"].transform.localEulerAngles = arg_124_1.actors_["121102ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_1 and arg_124_1.time_ < 0 + var_127_1 + arg_127_0 then
				arg_124_1.actors_["121102ui_story"].transform.localPosition = Vector3.New(0.7, -0.67, -6.07)
				arg_124_1.actors_["121102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["121102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["121102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["121102ui_story"].transform.position).z)
				arg_124_1.actors_["121102ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["121102ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["121102ui_story"].transform.localEulerAngles = arg_124_1.actors_["121102ui_story"].transform.localEulerAngles

				local var_127_2 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["121102ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(true)
				end
			end

			local var_127_3 = arg_124_1.actors_["121102ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect121102ui_story == nil then
				arg_124_1.var_.characterEffect121102ui_story = var_127_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_4 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 and not isNil(var_127_3) then
				if arg_124_1.var_.characterEffect121102ui_story and not isNil(var_127_3) then
					arg_124_1.var_.characterEffect121102ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect121102ui_story then
				arg_124_1.var_.characterEffect121102ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_127_6 = arg_124_1.actors_["614801ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_6) and arg_124_1.var_.characterEffect614801ui_story == nil then
				arg_124_1.var_.characterEffect614801ui_story = var_127_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_7 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 and not isNil(var_127_6) then
				if arg_124_1.var_.characterEffect614801ui_story and not isNil(var_127_6) then
					arg_124_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_124_1.var_.characterEffect614801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_7)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 and not isNil(var_127_6) and arg_124_1.var_.characterEffect614801ui_story then
				arg_124_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_124_1.var_.characterEffect614801ui_story.fillRatio = 0.5
			end

			local var_127_8 = 0
			local var_127_9 = 0.625

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_10 = arg_124_1:GetWordFromCfg(936041029)
				local var_127_11 = arg_124_1:FormatText(var_127_10.content)

				arg_124_1.text_.text = var_127_11

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_13 = 25 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 25)

				if (25 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 25)) > 0 and var_127_9 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_8
					end
				end

				arg_124_1.text_.text = var_127_11
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041029", "story_v_side_old_936041.awb") ~= 0 then
					local var_127_14 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041029", "story_v_side_old_936041.awb") / 1000

					if var_127_14 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_14 + var_127_8
					end

					if var_127_10.prefab_name ~= "" and arg_124_1.actors_[var_127_10.prefab_name] ~= nil then
						local var_127_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_10.prefab_name].transform, "story_v_side_old_936041", "936041029", "story_v_side_old_936041.awb")

						arg_124_1:RecordAudio("936041029", var_127_15)
						arg_124_1:RecordAudio("936041029", var_127_15)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041029", "story_v_side_old_936041.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041029", "story_v_side_old_936041.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_9, arg_124_1.talkMaxDuration)

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_8) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_8 + var_127_16 and arg_124_1.time_ < var_127_8 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play936041030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 936041030
		arg_128_1.duration_ = 4.87

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play936041031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["121102ui_story"]) and arg_128_1.var_.characterEffect121102ui_story == nil then
				arg_128_1.var_.characterEffect121102ui_story = arg_128_1.actors_["121102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["121102ui_story"]) then
				if arg_128_1.var_.characterEffect121102ui_story and not isNil(arg_128_1.actors_["121102ui_story"]) then
					arg_128_1.var_.characterEffect121102ui_story.fillFlat = true
					arg_128_1.var_.characterEffect121102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_0)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["121102ui_story"]) and arg_128_1.var_.characterEffect121102ui_story then
				arg_128_1.var_.characterEffect121102ui_story.fillFlat = true
				arg_128_1.var_.characterEffect121102ui_story.fillRatio = 0.5
			end

			local var_131_1 = arg_128_1.actors_["614801ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect614801ui_story == nil then
				arg_128_1.var_.characterEffect614801ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 and not isNil(var_131_1) then
				if arg_128_1.var_.characterEffect614801ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect614801ui_story then
				arg_128_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_131_4 = 0
			local var_131_5 = 0.55

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(936041030)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 22 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 22)

				if (22 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 22)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041030", "story_v_side_old_936041.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041030", "story_v_side_old_936041.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_side_old_936041", "936041030", "story_v_side_old_936041.awb")

						arg_128_1:RecordAudio("936041030", var_131_11)
						arg_128_1:RecordAudio("936041030", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041030", "story_v_side_old_936041.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041030", "story_v_side_old_936041.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play936041031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 936041031
		arg_132_1.duration_ = 5.6

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play936041032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos105401ui_story = arg_132_1.actors_["105401ui_story"].transform.localPosition

				local var_135_0 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["105401ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_0 then
					var_135_0:EnableDynamicBone(false)
				end
			end

			local var_135_1 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_1 then
				arg_132_1.actors_["105401ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos105401ui_story, Vector3.New(0.7, -0.985, -6), (arg_132_1.time_ - 0) / var_135_1)
				arg_132_1.actors_["105401ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["105401ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["105401ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["105401ui_story"].transform.position).z)
				arg_132_1.actors_["105401ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["105401ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["105401ui_story"].transform.localEulerAngles = arg_132_1.actors_["105401ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_1 and arg_132_1.time_ < 0 + var_135_1 + arg_135_0 then
				arg_132_1.actors_["105401ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_132_1.actors_["105401ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["105401ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["105401ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["105401ui_story"].transform.position).z)
				arg_132_1.actors_["105401ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["105401ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["105401ui_story"].transform.localEulerAngles = arg_132_1.actors_["105401ui_story"].transform.localEulerAngles

				local var_135_2 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["105401ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(true)
				end
			end

			local var_135_3 = arg_132_1.actors_["121102ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos121102ui_story = var_135_3.localPosition

				local var_135_4 = GameObjectTools.GetOrAddComponent(var_135_3.gameObject, typeof(DynamicBoneHelper))

				if var_135_4 then
					var_135_4:EnableDynamicBone(false)
				end
			end

			local var_135_5 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_5 then
				var_135_3.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos121102ui_story, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_5)
				var_135_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_3.position).x, (manager.ui.mainCamera.transform.position - var_135_3.position).y, (manager.ui.mainCamera.transform.position - var_135_3.position).z)
				var_135_3.localEulerAngles.z = 0
				var_135_3.localEulerAngles.x = 0
				var_135_3.localEulerAngles = var_135_3.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_5 and arg_132_1.time_ < 0 + var_135_5 + arg_135_0 then
				var_135_3.localPosition = Vector3.New(0, 100, 0)
				var_135_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_3.position).x, (manager.ui.mainCamera.transform.position - var_135_3.position).y, (manager.ui.mainCamera.transform.position - var_135_3.position).z)
				var_135_3.localEulerAngles.z = 0
				var_135_3.localEulerAngles.x = 0
				var_135_3.localEulerAngles = var_135_3.localEulerAngles

				local var_135_6 = GameObjectTools.GetOrAddComponent(var_135_3.gameObject, typeof(DynamicBoneHelper))

				if var_135_6 then
					var_135_6:EnableDynamicBone(true)
				end
			end

			local var_135_7 = arg_132_1.actors_["105401ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_7) and arg_132_1.var_.characterEffect105401ui_story == nil then
				arg_132_1.var_.characterEffect105401ui_story = var_135_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_8 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_8 and not isNil(var_135_7) then
				if arg_132_1.var_.characterEffect105401ui_story and not isNil(var_135_7) then
					arg_132_1.var_.characterEffect105401ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_8 and arg_132_1.time_ < 0 + var_135_8 + arg_135_0 and not isNil(var_135_7) and arg_132_1.var_.characterEffect105401ui_story then
				arg_132_1.var_.characterEffect105401ui_story.fillFlat = false
			end

			local var_135_10 = arg_132_1.actors_["614801ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_10) and arg_132_1.var_.characterEffect614801ui_story == nil then
				arg_132_1.var_.characterEffect614801ui_story = var_135_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_11 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_11 and not isNil(var_135_10) then
				if arg_132_1.var_.characterEffect614801ui_story and not isNil(var_135_10) then
					arg_132_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_132_1.var_.characterEffect614801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_11)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_11 and arg_132_1.time_ < 0 + var_135_11 + arg_135_0 and not isNil(var_135_10) and arg_132_1.var_.characterEffect614801ui_story then
				arg_132_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_132_1.var_.characterEffect614801ui_story.fillRatio = 0.5
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_135_12 = 0
			local var_135_13 = 0.575

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_12 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_14 = arg_132_1:GetWordFromCfg(936041031)
				local var_135_15 = arg_132_1:FormatText(var_135_14.content)

				arg_132_1.text_.text = var_135_15

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_17 = 23 <= 0 and var_135_13 or var_135_13 * (utf8.len(var_135_15) / 23)

				if (23 <= 0 and var_135_13 or var_135_13 * (utf8.len(var_135_15) / 23)) > 0 and var_135_13 < var_135_17 then
					arg_132_1.talkMaxDuration = var_135_17

					if var_135_17 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_17 + var_135_12
					end
				end

				arg_132_1.text_.text = var_135_15
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041031", "story_v_side_old_936041.awb") ~= 0 then
					local var_135_18 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041031", "story_v_side_old_936041.awb") / 1000

					if var_135_18 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_18 + var_135_12
					end

					if var_135_14.prefab_name ~= "" and arg_132_1.actors_[var_135_14.prefab_name] ~= nil then
						local var_135_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_14.prefab_name].transform, "story_v_side_old_936041", "936041031", "story_v_side_old_936041.awb")

						arg_132_1:RecordAudio("936041031", var_135_19)
						arg_132_1:RecordAudio("936041031", var_135_19)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041031", "story_v_side_old_936041.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041031", "story_v_side_old_936041.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_20 = math.max(var_135_13, arg_132_1.talkMaxDuration)

			if var_135_12 <= arg_132_1.time_ and arg_132_1.time_ < var_135_12 + var_135_20 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_12) / var_135_20

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_12 + var_135_20 and arg_132_1.time_ < var_135_12 + var_135_20 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play936041032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 936041032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play936041033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos614801ui_story = arg_136_1.actors_["614801ui_story"].transform.localPosition

				local var_139_0 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["614801ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_0 then
					var_139_0:EnableDynamicBone(false)
				end
			end

			local var_139_1 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_1 then
				arg_136_1.actors_["614801ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos614801ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_1)
				arg_136_1.actors_["614801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["614801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["614801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["614801ui_story"].transform.position).z)
				arg_136_1.actors_["614801ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["614801ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["614801ui_story"].transform.localEulerAngles = arg_136_1.actors_["614801ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_1 and arg_136_1.time_ < 0 + var_139_1 + arg_139_0 then
				arg_136_1.actors_["614801ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.actors_["614801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["614801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["614801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["614801ui_story"].transform.position).z)
				arg_136_1.actors_["614801ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["614801ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["614801ui_story"].transform.localEulerAngles = arg_136_1.actors_["614801ui_story"].transform.localEulerAngles

				local var_139_2 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["614801ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(true)
				end
			end

			local var_139_3 = arg_136_1.actors_["105401ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos105401ui_story = var_139_3.localPosition

				local var_139_4 = GameObjectTools.GetOrAddComponent(var_139_3.gameObject, typeof(DynamicBoneHelper))

				if var_139_4 then
					var_139_4:EnableDynamicBone(false)
				end
			end

			local var_139_5 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_5 then
				var_139_3.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos105401ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_5)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_5 and arg_136_1.time_ < 0 + var_139_5 + arg_139_0 then
				var_139_3.localPosition = Vector3.New(0, 100, 0)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles

				local var_139_6 = GameObjectTools.GetOrAddComponent(var_139_3.gameObject, typeof(DynamicBoneHelper))

				if var_139_6 then
					var_139_6:EnableDynamicBone(true)
				end
			end

			local var_139_7 = arg_136_1.actors_["614801ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_7) and arg_136_1.var_.characterEffect614801ui_story == nil then
				arg_136_1.var_.characterEffect614801ui_story = var_139_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_8 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_8 and not isNil(var_139_7) then
				if arg_136_1.var_.characterEffect614801ui_story and not isNil(var_139_7) then
					arg_136_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_136_1.var_.characterEffect614801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_8)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_8 and arg_136_1.time_ < 0 + var_139_8 + arg_139_0 and not isNil(var_139_7) and arg_136_1.var_.characterEffect614801ui_story then
				arg_136_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_136_1.var_.characterEffect614801ui_story.fillRatio = 0.5
			end

			local var_139_9 = 0
			local var_139_10 = 1.375

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_11 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(936041032).content)

				arg_136_1.text_.text = var_139_11

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_13 = 55 <= 0 and var_139_10 or var_139_10 * (utf8.len(var_139_11) / 55)

				if (55 <= 0 and var_139_10 or var_139_10 * (utf8.len(var_139_11) / 55)) > 0 and var_139_10 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_9 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_9
					end
				end

				arg_136_1.text_.text = var_139_11
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_10, arg_136_1.talkMaxDuration)

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_9) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_9 + var_139_14 and arg_136_1.time_ < var_139_9 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play936041033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 936041033
		arg_140_1.duration_ = 2.17

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play936041034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos104402ui_story = arg_140_1.actors_["104402ui_story"].transform.localPosition

				local var_143_0 = GameObjectTools.GetOrAddComponent(arg_140_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_143_0 then
					var_143_0:EnableDynamicBone(false)
				end
			end

			local var_143_1 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_1 then
				arg_140_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_140_1.time_ - 0) / var_143_1)
				arg_140_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["104402ui_story"].transform.position).z)
				arg_140_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["104402ui_story"].transform.localEulerAngles = arg_140_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_1 and arg_140_1.time_ < 0 + var_143_1 + arg_143_0 then
				arg_140_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_140_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["104402ui_story"].transform.position).z)
				arg_140_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["104402ui_story"].transform.localEulerAngles = arg_140_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_143_2 = GameObjectTools.GetOrAddComponent(arg_140_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_143_2 then
					var_143_2:EnableDynamicBone(true)
				end
			end

			local var_143_3 = arg_140_1.actors_["104402ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect104402ui_story == nil then
				arg_140_1.var_.characterEffect104402ui_story = var_143_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_4 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 and not isNil(var_143_3) then
				if arg_140_1.var_.characterEffect104402ui_story and not isNil(var_143_3) then
					arg_140_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect104402ui_story then
				arg_140_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_143_6 = 0
			local var_143_7 = 0.4

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_8 = arg_140_1:GetWordFromCfg(936041033)
				local var_143_9 = arg_140_1:FormatText(var_143_8.content)

				arg_140_1.text_.text = var_143_9

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 16 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_9) / 16)

				if (16 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_9) / 16)) > 0 and var_143_7 < var_143_11 then
					arg_140_1.talkMaxDuration = var_143_11

					if var_143_11 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_11 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_9
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041033", "story_v_side_old_936041.awb") ~= 0 then
					local var_143_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041033", "story_v_side_old_936041.awb") / 1000

					if var_143_12 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_6
					end

					if var_143_8.prefab_name ~= "" and arg_140_1.actors_[var_143_8.prefab_name] ~= nil then
						local var_143_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_8.prefab_name].transform, "story_v_side_old_936041", "936041033", "story_v_side_old_936041.awb")

						arg_140_1:RecordAudio("936041033", var_143_13)
						arg_140_1:RecordAudio("936041033", var_143_13)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041033", "story_v_side_old_936041.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041033", "story_v_side_old_936041.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_14 and arg_140_1.time_ < var_143_6 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play936041034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 936041034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play936041035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos104402ui_story = arg_144_1.actors_["104402ui_story"].transform.localPosition

				local var_147_0 = GameObjectTools.GetOrAddComponent(arg_144_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_147_0 then
					var_147_0:EnableDynamicBone(false)
				end
			end

			local var_147_1 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_1 then
				arg_144_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_144_1.time_ - 0) / var_147_1)
				arg_144_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["104402ui_story"].transform.position).z)
				arg_144_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["104402ui_story"].transform.localEulerAngles = arg_144_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_1 and arg_144_1.time_ < 0 + var_147_1 + arg_147_0 then
				arg_144_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_144_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["104402ui_story"].transform.position).z)
				arg_144_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["104402ui_story"].transform.localEulerAngles = arg_144_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_147_2 = GameObjectTools.GetOrAddComponent(arg_144_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(true)
				end
			end

			local var_147_3 = arg_144_1.actors_["104402ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_3) and arg_144_1.var_.characterEffect104402ui_story == nil then
				arg_144_1.var_.characterEffect104402ui_story = var_147_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_4 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 and not isNil(var_147_3) then
				if arg_144_1.var_.characterEffect104402ui_story and not isNil(var_147_3) then
					arg_144_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_144_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_4)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 and not isNil(var_147_3) and arg_144_1.var_.characterEffect104402ui_story then
				arg_144_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_144_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_144_1.time_ and arg_144_1.time_ <= 0.034000001847744 + arg_147_0 then
				arg_144_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_147_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_144_1.bgmTxt_.text ~= var_147_7 and arg_144_1.bgmTxt_.text ~= "" then
						if arg_144_1.bgmTxt2_.text ~= "" then
							arg_144_1.bgmTxt_.text = arg_144_1.bgmTxt2_.text
						end

						arg_144_1.bgmTxt2_.text = var_147_7

						arg_144_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_144_1.bgmTxt_.text = var_147_7
						arg_144_1.bgmTxt2_.text = var_147_7
					end

					if arg_144_1.bgmTimer then
						arg_144_1.bgmTimer:Stop()

						arg_144_1.bgmTimer = nil
					end

					if arg_144_1.settingData.show_music_name == 1 then
						arg_144_1.musicController:SetSelectedState("show")
						arg_144_1.musicAnimator_:Play("open", 0, 0)

						if arg_144_1.settingData.music_time ~= 0 then
							arg_144_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_144_1.settingData.music_time), function()
								if arg_144_1 == nil or isNil(arg_144_1.bgmTxt_) then
									return
								end

								arg_144_1.musicController:SetSelectedState("hide")
								arg_144_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_147_8 = 0
			local var_147_9 = 1.325

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_10 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(936041034).content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_12 = 53 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_10) / 53)

				if (53 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_10) / 53)) > 0 and var_147_9 < var_147_12 then
					arg_144_1.talkMaxDuration = var_147_12

					if var_147_12 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_8
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_13 = math.max(var_147_9, arg_144_1.talkMaxDuration)

			if var_147_8 <= arg_144_1.time_ and arg_144_1.time_ < var_147_8 + var_147_13 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_8) / var_147_13

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_8 + var_147_13 and arg_144_1.time_ < var_147_8 + var_147_13 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play936041035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 936041035
		arg_149_1.duration_ = 8.67

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play936041036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if arg_149_1.bgs_.ST15a == nil then
				local var_152_0 = Object.Instantiate(arg_149_1.paintGo_)

				var_152_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15a")
				var_152_0.name = "ST15a"
				var_152_0.transform.parent = arg_149_1.stage_.transform
				var_152_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.bgs_.ST15a = var_152_0
			end

			if 2 < arg_149_1.time_ and arg_149_1.time_ <= 2 + arg_152_0 then
				local var_152_1 = arg_149_1.bgs_.ST15a

				arg_149_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_152_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_2 = var_152_1:GetComponent("SpriteRenderer")

				if var_152_2 and var_152_2.sprite then
					local var_152_3 = 2 * (var_152_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_152_1.transform.localScale = Vector3.New(var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "ST15a" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_4 = 4.00000000298023

			if 4.00000000298023 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			if arg_149_1.time_ >= var_152_4 + 0.3 and arg_149_1.time_ < var_152_4 + 0.3 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end

			local var_152_5 = 0

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_6 = 2

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_6 then
				local var_152_7 = Color.New(0, 0, 0)

				var_152_7.a = Mathf.Lerp(0, 1, (arg_149_1.time_ - var_152_5) / var_152_6)
				arg_149_1.mask_.color = var_152_7
			end

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 then
				local var_152_8 = Color.New(0, 0, 0)

				var_152_8.a = 1
				arg_149_1.mask_.color = var_152_8
			end

			local var_152_9 = 2

			if 2 < arg_149_1.time_ and arg_149_1.time_ <= var_152_9 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_10 = 2

			if var_152_9 <= arg_149_1.time_ and arg_149_1.time_ < var_152_9 + var_152_10 then
				local var_152_11 = Color.New(0, 0, 0)

				var_152_11.a = Mathf.Lerp(1, 0, (arg_149_1.time_ - var_152_9) / var_152_10)
				arg_149_1.mask_.color = var_152_11
			end

			if arg_149_1.time_ >= var_152_9 + var_152_10 and arg_149_1.time_ < var_152_9 + var_152_10 + arg_152_0 then
				local var_152_12 = Color.New(0, 0, 0)

				arg_149_1.mask_.enabled = false
				var_152_12.a = 0
				arg_149_1.mask_.color = var_152_12
			end

			local var_152_13 = arg_149_1.actors_["104402ui_story"].transform

			if 3.8 < arg_149_1.time_ and arg_149_1.time_ <= 3.8 + arg_152_0 then
				arg_149_1.var_.moveOldPos104402ui_story = var_152_13.localPosition

				local var_152_14 = GameObjectTools.GetOrAddComponent(var_152_13.gameObject, typeof(DynamicBoneHelper))

				if var_152_14 then
					var_152_14:EnableDynamicBone(false)
				end
			end

			local var_152_15 = 0.001

			if 3.8 <= arg_149_1.time_ and arg_149_1.time_ < 3.8 + var_152_15 then
				var_152_13.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_149_1.time_ - 3.8) / var_152_15)
				var_152_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_13.position).x, (manager.ui.mainCamera.transform.position - var_152_13.position).y, (manager.ui.mainCamera.transform.position - var_152_13.position).z)
				var_152_13.localEulerAngles.z = 0
				var_152_13.localEulerAngles.x = 0
				var_152_13.localEulerAngles = var_152_13.localEulerAngles
			end

			if arg_149_1.time_ >= 3.8 + var_152_15 and arg_149_1.time_ < 3.8 + var_152_15 + arg_152_0 then
				var_152_13.localPosition = Vector3.New(0, -1, -5.93)
				var_152_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_13.position).x, (manager.ui.mainCamera.transform.position - var_152_13.position).y, (manager.ui.mainCamera.transform.position - var_152_13.position).z)
				var_152_13.localEulerAngles.z = 0
				var_152_13.localEulerAngles.x = 0
				var_152_13.localEulerAngles = var_152_13.localEulerAngles

				local var_152_16 = GameObjectTools.GetOrAddComponent(var_152_13.gameObject, typeof(DynamicBoneHelper))

				if var_152_16 then
					var_152_16:EnableDynamicBone(true)
				end
			end

			local var_152_17 = arg_149_1.actors_["104402ui_story"]

			if 3.8 < arg_149_1.time_ and arg_149_1.time_ <= 3.8 + arg_152_0 and not isNil(var_152_17) and arg_149_1.var_.characterEffect104402ui_story == nil then
				arg_149_1.var_.characterEffect104402ui_story = var_152_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_18 = 0.200000002980232

			if 3.8 <= arg_149_1.time_ and arg_149_1.time_ < 3.8 + var_152_18 and not isNil(var_152_17) then
				if arg_149_1.var_.characterEffect104402ui_story and not isNil(var_152_17) then
					arg_149_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 3.8 + var_152_18 and arg_149_1.time_ < 3.8 + var_152_18 + arg_152_0 and not isNil(var_152_17) and arg_149_1.var_.characterEffect104402ui_story then
				arg_149_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 3.8 < arg_149_1.time_ and arg_149_1.time_ <= 3.8 + arg_152_0 then
				arg_149_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			if 3.8 < arg_149_1.time_ and arg_149_1.time_ <= 3.8 + arg_152_0 then
				arg_149_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 1.63333333333333 < arg_149_1.time_ and arg_149_1.time_ <= 1.63333333333333 + arg_152_0 then
				arg_149_1:AudioAction("play", "music", "bgm_activity_5_0_scene_104402_story", "bgm_activity_5_0_scene_104402_story", "bgm_activity_5_0_scene_104402_story.awb")

				local var_152_22 = manager.audio:GetAudioName("bgm_activity_5_0_scene_104402_story", "bgm_activity_5_0_scene_104402_story")

				if "" ~= "" then
					if arg_149_1.bgmTxt_.text ~= var_152_22 and arg_149_1.bgmTxt_.text ~= "" then
						if arg_149_1.bgmTxt2_.text ~= "" then
							arg_149_1.bgmTxt_.text = arg_149_1.bgmTxt2_.text
						end

						arg_149_1.bgmTxt2_.text = var_152_22

						arg_149_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_149_1.bgmTxt_.text = var_152_22
						arg_149_1.bgmTxt2_.text = var_152_22
					end

					if arg_149_1.bgmTimer then
						arg_149_1.bgmTimer:Stop()

						arg_149_1.bgmTimer = nil
					end

					if arg_149_1.settingData.show_music_name == 1 then
						arg_149_1.musicController:SetSelectedState("show")
						arg_149_1.musicAnimator_:Play("open", 0, 0)

						if arg_149_1.settingData.music_time ~= 0 then
							arg_149_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_149_1.settingData.music_time), function()
								if arg_149_1 == nil or isNil(arg_149_1.bgmTxt_) then
									return
								end

								arg_149_1.musicController:SetSelectedState("hide")
								arg_149_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.133333333333333 < arg_149_1.time_ and arg_149_1.time_ <= 0.133333333333333 + arg_152_0 then
				arg_149_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 1.63333333333333 < arg_149_1.time_ and arg_149_1.time_ <= 1.63333333333333 + arg_152_0 then
				arg_149_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_beach_night", "")
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_25 = 4.00000000298023
			local var_152_26 = 0.55

			if 4.00000000298023 < arg_149_1.time_ and arg_149_1.time_ <= var_152_25 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_27 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_27:setOnUpdate(LuaHelper.FloatAction(function(arg_154_0)
					arg_149_1.dialogCg_.alpha = arg_154_0
				end))
				var_152_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_28 = arg_149_1:GetWordFromCfg(936041035)
				local var_152_29 = arg_149_1:FormatText(var_152_28.content)

				arg_149_1.text_.text = var_152_29

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_31 = 22 <= 0 and var_152_26 or var_152_26 * (utf8.len(var_152_29) / 22)

				if (22 <= 0 and var_152_26 or var_152_26 * (utf8.len(var_152_29) / 22)) > 0 and var_152_26 < var_152_31 then
					arg_149_1.talkMaxDuration = var_152_31
					var_152_25 = var_152_25 + 0.3

					if var_152_31 + var_152_25 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_31 + var_152_25
					end
				end

				arg_149_1.text_.text = var_152_29
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041035", "story_v_side_old_936041.awb") ~= 0 then
					local var_152_32 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041035", "story_v_side_old_936041.awb") / 1000

					if var_152_32 + var_152_25 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_32 + var_152_25
					end

					if var_152_28.prefab_name ~= "" and arg_149_1.actors_[var_152_28.prefab_name] ~= nil then
						local var_152_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_28.prefab_name].transform, "story_v_side_old_936041", "936041035", "story_v_side_old_936041.awb")

						arg_149_1:RecordAudio("936041035", var_152_33)
						arg_149_1:RecordAudio("936041035", var_152_33)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041035", "story_v_side_old_936041.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041035", "story_v_side_old_936041.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_34 = var_152_25 + 0.3
			local var_152_35 = math.max(var_152_26, arg_149_1.talkMaxDuration)

			if var_152_25 + 0.3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_34 + var_152_35 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_34) / var_152_35

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_34 + var_152_35 and arg_149_1.time_ < var_152_34 + var_152_35 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play936041036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 936041036
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play936041037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos104402ui_story = arg_156_1.actors_["104402ui_story"].transform.localPosition

				local var_159_0 = GameObjectTools.GetOrAddComponent(arg_156_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_159_0 then
					var_159_0:EnableDynamicBone(false)
				end
			end

			local var_159_1 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_1 then
				arg_156_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_1)
				arg_156_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["104402ui_story"].transform.position).z)
				arg_156_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["104402ui_story"].transform.localEulerAngles = arg_156_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_1 and arg_156_1.time_ < 0 + var_159_1 + arg_159_0 then
				arg_156_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["104402ui_story"].transform.position).z)
				arg_156_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["104402ui_story"].transform.localEulerAngles = arg_156_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_159_2 = GameObjectTools.GetOrAddComponent(arg_156_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_159_2 then
					var_159_2:EnableDynamicBone(true)
				end
			end

			local var_159_3 = arg_156_1.actors_["104402ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_3) and arg_156_1.var_.characterEffect104402ui_story == nil then
				arg_156_1.var_.characterEffect104402ui_story = var_159_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_4 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 and not isNil(var_159_3) then
				if arg_156_1.var_.characterEffect104402ui_story and not isNil(var_159_3) then
					arg_156_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_156_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_4)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 and not isNil(var_159_3) and arg_156_1.var_.characterEffect104402ui_story then
				arg_156_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_156_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_159_5 = 0
			local var_159_6 = 0.975

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_7 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(936041036).content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 39 <= 0 and var_159_6 or var_159_6 * (utf8.len(var_159_7) / 39)

				if (39 <= 0 and var_159_6 or var_159_6 * (utf8.len(var_159_7) / 39)) > 0 and var_159_6 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_5
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_6, arg_156_1.talkMaxDuration)

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_5) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_5 + var_159_10 and arg_156_1.time_ < var_159_5 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play936041037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 936041037
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play936041038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0.6 < arg_160_1.time_ and arg_160_1.time_ <= 0.6 + arg_163_0 then
				arg_160_1:AudioAction("play", "effect", "se_story_150", "se_story_150_footstep_slow", "")
			end

			local var_163_1 = 0
			local var_163_2 = 1.45

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(936041037).content)

				arg_160_1.text_.text = var_163_3

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 58 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 58)

				if (58 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 58)) > 0 and var_163_2 < var_163_5 then
					arg_160_1.talkMaxDuration = var_163_5

					if var_163_5 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + var_163_1
					end
				end

				arg_160_1.text_.text = var_163_3
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_6 = math.max(var_163_2, arg_160_1.talkMaxDuration)

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_6 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_1) / var_163_6

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_1 + var_163_6 and arg_160_1.time_ < var_163_1 + var_163_6 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play936041038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 936041038
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play936041039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 1.075

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_1 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(936041038).content)

				arg_164_1.text_.text = var_167_1

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_3 = 43 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 43)

				if (43 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 43)) > 0 and var_167_0 < var_167_3 then
					arg_164_1.talkMaxDuration = var_167_3

					if var_167_3 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_3 + 0
					end
				end

				arg_164_1.text_.text = var_167_1
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_4 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_4

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play936041039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 936041039
		arg_168_1.duration_ = 5.53

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play936041040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos104402ui_story = arg_168_1.actors_["104402ui_story"].transform.localPosition

				local var_171_0 = GameObjectTools.GetOrAddComponent(arg_168_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_171_0 then
					var_171_0:EnableDynamicBone(false)
				end
			end

			local var_171_1 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_1 then
				arg_168_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_168_1.time_ - 0) / var_171_1)
				arg_168_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["104402ui_story"].transform.position).z)
				arg_168_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["104402ui_story"].transform.localEulerAngles = arg_168_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_1 and arg_168_1.time_ < 0 + var_171_1 + arg_171_0 then
				arg_168_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_168_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["104402ui_story"].transform.position).z)
				arg_168_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["104402ui_story"].transform.localEulerAngles = arg_168_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_171_2 = GameObjectTools.GetOrAddComponent(arg_168_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_171_2 then
					var_171_2:EnableDynamicBone(true)
				end
			end

			local var_171_3 = arg_168_1.actors_["104402ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_3) and arg_168_1.var_.characterEffect104402ui_story == nil then
				arg_168_1.var_.characterEffect104402ui_story = var_171_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_4 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_4 and not isNil(var_171_3) then
				if arg_168_1.var_.characterEffect104402ui_story and not isNil(var_171_3) then
					arg_168_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_4 and arg_168_1.time_ < 0 + var_171_4 + arg_171_0 and not isNil(var_171_3) and arg_168_1.var_.characterEffect104402ui_story then
				arg_168_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_171_6 = 0
			local var_171_7 = 0.625

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_8 = arg_168_1:GetWordFromCfg(936041039)
				local var_171_9 = arg_168_1:FormatText(var_171_8.content)

				arg_168_1.text_.text = var_171_9

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 25 <= 0 and var_171_7 or var_171_7 * (utf8.len(var_171_9) / 25)

				if (25 <= 0 and var_171_7 or var_171_7 * (utf8.len(var_171_9) / 25)) > 0 and var_171_7 < var_171_11 then
					arg_168_1.talkMaxDuration = var_171_11

					if var_171_11 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_9
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041039", "story_v_side_old_936041.awb") ~= 0 then
					local var_171_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041039", "story_v_side_old_936041.awb") / 1000

					if var_171_12 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_12 + var_171_6
					end

					if var_171_8.prefab_name ~= "" and arg_168_1.actors_[var_171_8.prefab_name] ~= nil then
						local var_171_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_8.prefab_name].transform, "story_v_side_old_936041", "936041039", "story_v_side_old_936041.awb")

						arg_168_1:RecordAudio("936041039", var_171_13)
						arg_168_1:RecordAudio("936041039", var_171_13)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041039", "story_v_side_old_936041.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041039", "story_v_side_old_936041.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_14 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_14 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_14

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_14 and arg_168_1.time_ < var_171_6 + var_171_14 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play936041040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 936041040
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play936041041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["104402ui_story"]) and arg_172_1.var_.characterEffect104402ui_story == nil then
				arg_172_1.var_.characterEffect104402ui_story = arg_172_1.actors_["104402ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["104402ui_story"]) then
				if arg_172_1.var_.characterEffect104402ui_story and not isNil(arg_172_1.actors_["104402ui_story"]) then
					arg_172_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_172_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["104402ui_story"]) and arg_172_1.var_.characterEffect104402ui_story then
				arg_172_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_172_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_175_1 = 0
			local var_175_2 = 0.725

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(936041040).content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 29 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 29)

				if (29 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 29)) > 0 and var_175_2 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_6 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_6 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_6

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_6 and arg_172_1.time_ < var_175_1 + var_175_6 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play936041041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 936041041
		arg_176_1.duration_ = 5.07

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play936041042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["104402ui_story"]) and arg_176_1.var_.characterEffect104402ui_story == nil then
				arg_176_1.var_.characterEffect104402ui_story = arg_176_1.actors_["104402ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["104402ui_story"]) then
				if arg_176_1.var_.characterEffect104402ui_story and not isNil(arg_176_1.actors_["104402ui_story"]) then
					arg_176_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["104402ui_story"]) and arg_176_1.var_.characterEffect104402ui_story then
				arg_176_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_1")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_179_2 = 0
			local var_179_3 = 0.6

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_2 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_4 = arg_176_1:GetWordFromCfg(936041041)
				local var_179_5 = arg_176_1:FormatText(var_179_4.content)

				arg_176_1.text_.text = var_179_5

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_7 = 24 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 24)

				if (24 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 24)) > 0 and var_179_3 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_2
					end
				end

				arg_176_1.text_.text = var_179_5
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041041", "story_v_side_old_936041.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041041", "story_v_side_old_936041.awb") / 1000

					if var_179_8 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_2
					end

					if var_179_4.prefab_name ~= "" and arg_176_1.actors_[var_179_4.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_4.prefab_name].transform, "story_v_side_old_936041", "936041041", "story_v_side_old_936041.awb")

						arg_176_1:RecordAudio("936041041", var_179_9)
						arg_176_1:RecordAudio("936041041", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041041", "story_v_side_old_936041.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041041", "story_v_side_old_936041.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_3, arg_176_1.talkMaxDuration)

			if var_179_2 <= arg_176_1.time_ and arg_176_1.time_ < var_179_2 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_2) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_2 + var_179_10 and arg_176_1.time_ < var_179_2 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play936041042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 936041042
		arg_180_1.duration_ = 4

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play936041043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos104402ui_story = arg_180_1.actors_["104402ui_story"].transform.localPosition

				local var_183_0 = GameObjectTools.GetOrAddComponent(arg_180_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_183_0 then
					var_183_0:EnableDynamicBone(false)
				end
			end

			local var_183_1 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_1 then
				arg_180_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_180_1.time_ - 0) / var_183_1)
				arg_180_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["104402ui_story"].transform.position).z)
				arg_180_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["104402ui_story"].transform.localEulerAngles = arg_180_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_1 and arg_180_1.time_ < 0 + var_183_1 + arg_183_0 then
				arg_180_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_180_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["104402ui_story"].transform.position).z)
				arg_180_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["104402ui_story"].transform.localEulerAngles = arg_180_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_183_2 = GameObjectTools.GetOrAddComponent(arg_180_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_183_2 then
					var_183_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_2")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_183_3 = 0
			local var_183_4 = 0.35

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_3 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_5 = arg_180_1:GetWordFromCfg(936041042)
				local var_183_6 = arg_180_1:FormatText(var_183_5.content)

				arg_180_1.text_.text = var_183_6

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_8 = 14 <= 0 and var_183_4 or var_183_4 * (utf8.len(var_183_6) / 14)

				if (14 <= 0 and var_183_4 or var_183_4 * (utf8.len(var_183_6) / 14)) > 0 and var_183_4 < var_183_8 then
					arg_180_1.talkMaxDuration = var_183_8

					if var_183_8 + var_183_3 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_3
					end
				end

				arg_180_1.text_.text = var_183_6
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041042", "story_v_side_old_936041.awb") ~= 0 then
					local var_183_9 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041042", "story_v_side_old_936041.awb") / 1000

					if var_183_9 + var_183_3 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_3
					end

					if var_183_5.prefab_name ~= "" and arg_180_1.actors_[var_183_5.prefab_name] ~= nil then
						local var_183_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_5.prefab_name].transform, "story_v_side_old_936041", "936041042", "story_v_side_old_936041.awb")

						arg_180_1:RecordAudio("936041042", var_183_10)
						arg_180_1:RecordAudio("936041042", var_183_10)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041042", "story_v_side_old_936041.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041042", "story_v_side_old_936041.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_11 = math.max(var_183_4, arg_180_1.talkMaxDuration)

			if var_183_3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_3 + var_183_11 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_3) / var_183_11

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_3 + var_183_11 and arg_180_1.time_ < var_183_3 + var_183_11 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play936041043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 936041043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play936041044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["104402ui_story"]) and arg_184_1.var_.characterEffect104402ui_story == nil then
				arg_184_1.var_.characterEffect104402ui_story = arg_184_1.actors_["104402ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["104402ui_story"]) then
				if arg_184_1.var_.characterEffect104402ui_story and not isNil(arg_184_1.actors_["104402ui_story"]) then
					arg_184_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_184_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_0)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["104402ui_story"]) and arg_184_1.var_.characterEffect104402ui_story then
				arg_184_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_184_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_187_1 = 0
			local var_187_2 = 0.3

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(936041043).content)

				arg_184_1.text_.text = var_187_3

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 12 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 12)

				if (12 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 12)) > 0 and var_187_2 < var_187_5 then
					arg_184_1.talkMaxDuration = var_187_5

					if var_187_5 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + var_187_1
					end
				end

				arg_184_1.text_.text = var_187_3
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_6 = math.max(var_187_2, arg_184_1.talkMaxDuration)

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_6 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_1) / var_187_6

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_1 + var_187_6 and arg_184_1.time_ < var_187_1 + var_187_6 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play936041044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 936041044
		arg_188_1.duration_ = 2.03

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play936041045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos104402ui_story = arg_188_1.actors_["104402ui_story"].transform.localPosition

				local var_191_0 = GameObjectTools.GetOrAddComponent(arg_188_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_191_0 then
					var_191_0:EnableDynamicBone(false)
				end
			end

			local var_191_1 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_1 then
				arg_188_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_188_1.time_ - 0) / var_191_1)
				arg_188_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["104402ui_story"].transform.position).z)
				arg_188_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["104402ui_story"].transform.localEulerAngles = arg_188_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_1 and arg_188_1.time_ < 0 + var_191_1 + arg_191_0 then
				arg_188_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_188_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["104402ui_story"].transform.position).z)
				arg_188_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["104402ui_story"].transform.localEulerAngles = arg_188_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_191_2 = GameObjectTools.GetOrAddComponent(arg_188_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_191_2 then
					var_191_2:EnableDynamicBone(true)
				end
			end

			local var_191_3 = arg_188_1.actors_["104402ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_3) and arg_188_1.var_.characterEffect104402ui_story == nil then
				arg_188_1.var_.characterEffect104402ui_story = var_191_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_4 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 and not isNil(var_191_3) then
				if arg_188_1.var_.characterEffect104402ui_story and not isNil(var_191_3) then
					arg_188_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 and not isNil(var_191_3) and arg_188_1.var_.characterEffect104402ui_story then
				arg_188_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_191_6 = 0
			local var_191_7 = 0.05

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_8 = arg_188_1:GetWordFromCfg(936041044)
				local var_191_9 = arg_188_1:FormatText(var_191_8.content)

				arg_188_1.text_.text = var_191_9

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_11 = 2 <= 0 and var_191_7 or var_191_7 * (utf8.len(var_191_9) / 2)

				if (2 <= 0 and var_191_7 or var_191_7 * (utf8.len(var_191_9) / 2)) > 0 and var_191_7 < var_191_11 then
					arg_188_1.talkMaxDuration = var_191_11

					if var_191_11 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_11 + var_191_6
					end
				end

				arg_188_1.text_.text = var_191_9
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041044", "story_v_side_old_936041.awb") ~= 0 then
					local var_191_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041044", "story_v_side_old_936041.awb") / 1000

					if var_191_12 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_12 + var_191_6
					end

					if var_191_8.prefab_name ~= "" and arg_188_1.actors_[var_191_8.prefab_name] ~= nil then
						local var_191_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_8.prefab_name].transform, "story_v_side_old_936041", "936041044", "story_v_side_old_936041.awb")

						arg_188_1:RecordAudio("936041044", var_191_13)
						arg_188_1:RecordAudio("936041044", var_191_13)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041044", "story_v_side_old_936041.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041044", "story_v_side_old_936041.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_14 = math.max(var_191_7, arg_188_1.talkMaxDuration)

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_14 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_6) / var_191_14

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_6 + var_191_14 and arg_188_1.time_ < var_191_6 + var_191_14 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play936041045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 936041045
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play936041046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["104402ui_story"]) and arg_192_1.var_.characterEffect104402ui_story == nil then
				arg_192_1.var_.characterEffect104402ui_story = arg_192_1.actors_["104402ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["104402ui_story"]) then
				if arg_192_1.var_.characterEffect104402ui_story and not isNil(arg_192_1.actors_["104402ui_story"]) then
					arg_192_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_192_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_0)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["104402ui_story"]) and arg_192_1.var_.characterEffect104402ui_story then
				arg_192_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_192_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_195_1 = 0
			local var_195_2 = 0.25

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_3 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(936041045).content)

				arg_192_1.text_.text = var_195_3

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 10 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 10)

				if (10 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 10)) > 0 and var_195_2 < var_195_5 then
					arg_192_1.talkMaxDuration = var_195_5

					if var_195_5 + var_195_1 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + var_195_1
					end
				end

				arg_192_1.text_.text = var_195_3
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_6 = math.max(var_195_2, arg_192_1.talkMaxDuration)

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_6 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_1) / var_195_6

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_1 + var_195_6 and arg_192_1.time_ < var_195_1 + var_195_6 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play936041046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 936041046
		arg_196_1.duration_ = 2.53

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play936041047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos104402ui_story = arg_196_1.actors_["104402ui_story"].transform.localPosition

				local var_199_0 = GameObjectTools.GetOrAddComponent(arg_196_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_199_0 then
					var_199_0:EnableDynamicBone(false)
				end
			end

			local var_199_1 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				arg_196_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_196_1.time_ - 0) / var_199_1)
				arg_196_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["104402ui_story"].transform.position).z)
				arg_196_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["104402ui_story"].transform.localEulerAngles = arg_196_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 then
				arg_196_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_196_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["104402ui_story"].transform.position).z)
				arg_196_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["104402ui_story"].transform.localEulerAngles = arg_196_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_199_2 = GameObjectTools.GetOrAddComponent(arg_196_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_199_2 then
					var_199_2:EnableDynamicBone(true)
				end
			end

			local var_199_3 = arg_196_1.actors_["104402ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_3) and arg_196_1.var_.characterEffect104402ui_story == nil then
				arg_196_1.var_.characterEffect104402ui_story = var_199_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_4 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_4 and not isNil(var_199_3) then
				if arg_196_1.var_.characterEffect104402ui_story and not isNil(var_199_3) then
					arg_196_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_4 and arg_196_1.time_ < 0 + var_199_4 + arg_199_0 and not isNil(var_199_3) and arg_196_1.var_.characterEffect104402ui_story then
				arg_196_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402actionlink/104402action438")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_199_6 = 0
			local var_199_7 = 0.15

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_6 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_8 = arg_196_1:GetWordFromCfg(936041046)
				local var_199_9 = arg_196_1:FormatText(var_199_8.content)

				arg_196_1.text_.text = var_199_9

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_11 = 6 <= 0 and var_199_7 or var_199_7 * (utf8.len(var_199_9) / 6)

				if (6 <= 0 and var_199_7 or var_199_7 * (utf8.len(var_199_9) / 6)) > 0 and var_199_7 < var_199_11 then
					arg_196_1.talkMaxDuration = var_199_11

					if var_199_11 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_11 + var_199_6
					end
				end

				arg_196_1.text_.text = var_199_9
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041046", "story_v_side_old_936041.awb") ~= 0 then
					local var_199_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041046", "story_v_side_old_936041.awb") / 1000

					if var_199_12 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_12 + var_199_6
					end

					if var_199_8.prefab_name ~= "" and arg_196_1.actors_[var_199_8.prefab_name] ~= nil then
						local var_199_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_8.prefab_name].transform, "story_v_side_old_936041", "936041046", "story_v_side_old_936041.awb")

						arg_196_1:RecordAudio("936041046", var_199_13)
						arg_196_1:RecordAudio("936041046", var_199_13)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041046", "story_v_side_old_936041.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041046", "story_v_side_old_936041.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_14 = math.max(var_199_7, arg_196_1.talkMaxDuration)

			if var_199_6 <= arg_196_1.time_ and arg_196_1.time_ < var_199_6 + var_199_14 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_6) / var_199_14

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_6 + var_199_14 and arg_196_1.time_ < var_199_6 + var_199_14 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play936041047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 936041047
		arg_200_1.duration_ = 4.17

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play936041048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos104402ui_story = arg_200_1.actors_["104402ui_story"].transform.localPosition

				local var_203_0 = GameObjectTools.GetOrAddComponent(arg_200_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_203_0 then
					var_203_0:EnableDynamicBone(false)
				end
			end

			local var_203_1 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_1 then
				arg_200_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_200_1.time_ - 0) / var_203_1)
				arg_200_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["104402ui_story"].transform.position).z)
				arg_200_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["104402ui_story"].transform.localEulerAngles = arg_200_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_1 and arg_200_1.time_ < 0 + var_203_1 + arg_203_0 then
				arg_200_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_200_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["104402ui_story"].transform.position).z)
				arg_200_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["104402ui_story"].transform.localEulerAngles = arg_200_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_203_2 = GameObjectTools.GetOrAddComponent(arg_200_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_203_2 then
					var_203_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_2")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_203_3 = 0
			local var_203_4 = 0.45

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_3 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_5 = arg_200_1:GetWordFromCfg(936041047)
				local var_203_6 = arg_200_1:FormatText(var_203_5.content)

				arg_200_1.text_.text = var_203_6

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_8 = 18 <= 0 and var_203_4 or var_203_4 * (utf8.len(var_203_6) / 18)

				if (18 <= 0 and var_203_4 or var_203_4 * (utf8.len(var_203_6) / 18)) > 0 and var_203_4 < var_203_8 then
					arg_200_1.talkMaxDuration = var_203_8

					if var_203_8 + var_203_3 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_8 + var_203_3
					end
				end

				arg_200_1.text_.text = var_203_6
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041047", "story_v_side_old_936041.awb") ~= 0 then
					local var_203_9 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041047", "story_v_side_old_936041.awb") / 1000

					if var_203_9 + var_203_3 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_9 + var_203_3
					end

					if var_203_5.prefab_name ~= "" and arg_200_1.actors_[var_203_5.prefab_name] ~= nil then
						local var_203_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_5.prefab_name].transform, "story_v_side_old_936041", "936041047", "story_v_side_old_936041.awb")

						arg_200_1:RecordAudio("936041047", var_203_10)
						arg_200_1:RecordAudio("936041047", var_203_10)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041047", "story_v_side_old_936041.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041047", "story_v_side_old_936041.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_11 = math.max(var_203_4, arg_200_1.talkMaxDuration)

			if var_203_3 <= arg_200_1.time_ and arg_200_1.time_ < var_203_3 + var_203_11 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_3) / var_203_11

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_3 + var_203_11 and arg_200_1.time_ < var_203_3 + var_203_11 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play936041048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 936041048
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play936041049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["104402ui_story"]) and arg_204_1.var_.characterEffect104402ui_story == nil then
				arg_204_1.var_.characterEffect104402ui_story = arg_204_1.actors_["104402ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["104402ui_story"]) then
				if arg_204_1.var_.characterEffect104402ui_story and not isNil(arg_204_1.actors_["104402ui_story"]) then
					arg_204_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_204_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_0)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["104402ui_story"]) and arg_204_1.var_.characterEffect104402ui_story then
				arg_204_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_204_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_207_1 = 0
			local var_207_2 = 0.05

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_3 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(936041048).content)

				arg_204_1.text_.text = var_207_3

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 2 <= 0 and var_207_2 or var_207_2 * (utf8.len(var_207_3) / 2)

				if (2 <= 0 and var_207_2 or var_207_2 * (utf8.len(var_207_3) / 2)) > 0 and var_207_2 < var_207_5 then
					arg_204_1.talkMaxDuration = var_207_5

					if var_207_5 + var_207_1 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + var_207_1
					end
				end

				arg_204_1.text_.text = var_207_3
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_6 = math.max(var_207_2, arg_204_1.talkMaxDuration)

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_6 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_1) / var_207_6

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_1 + var_207_6 and arg_204_1.time_ < var_207_1 + var_207_6 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play936041049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 936041049
		arg_208_1.duration_ = 9

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play936041050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if arg_208_1.bgs_.SP93601 == nil then
				local var_211_0 = Object.Instantiate(arg_208_1.paintGo_)

				var_211_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SP93601")
				var_211_0.name = "SP93601"
				var_211_0.transform.parent = arg_208_1.stage_.transform
				var_211_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_208_1.bgs_.SP93601 = var_211_0
			end

			if 2 < arg_208_1.time_ and arg_208_1.time_ <= 2 + arg_211_0 then
				local var_211_1 = arg_208_1.bgs_.SP93601

				arg_208_1.bgs_.SP93601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_211_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_211_2 = var_211_1:GetComponent("SpriteRenderer")

				if var_211_2 and var_211_2.sprite then
					local var_211_3 = 2 * (var_211_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_211_1.transform.localScale = Vector3.New(var_211_3 / var_211_2.sprite.bounds.size.y < var_211_3 * manager.ui.mainCameraCom_.aspect / var_211_2.sprite.bounds.size.x and var_211_3 * manager.ui.mainCameraCom_.aspect / var_211_2.sprite.bounds.size.x or var_211_3 / var_211_2.sprite.bounds.size.y, var_211_3 / var_211_2.sprite.bounds.size.y < var_211_3 * manager.ui.mainCameraCom_.aspect / var_211_2.sprite.bounds.size.x and var_211_3 * manager.ui.mainCameraCom_.aspect / var_211_2.sprite.bounds.size.x or var_211_3 / var_211_2.sprite.bounds.size.y, 0)
				end

				for iter_211_0, iter_211_1 in pairs(arg_208_1.bgs_) do
					if iter_211_0 ~= "SP93601" then
						iter_211_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_211_4 = 3.999999999999

			if 3.999999999999 < arg_208_1.time_ and arg_208_1.time_ <= var_211_4 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			if arg_208_1.time_ >= var_211_4 + 0.3 and arg_208_1.time_ < var_211_4 + 0.3 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			local var_211_5 = 0

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_6 = 2

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_6 then
				local var_211_7 = Color.New(0, 0, 0)

				var_211_7.a = Mathf.Lerp(0, 1, (arg_208_1.time_ - var_211_5) / var_211_6)
				arg_208_1.mask_.color = var_211_7
			end

			if arg_208_1.time_ >= var_211_5 + var_211_6 and arg_208_1.time_ < var_211_5 + var_211_6 + arg_211_0 then
				local var_211_8 = Color.New(0, 0, 0)

				var_211_8.a = 1
				arg_208_1.mask_.color = var_211_8
			end

			local var_211_9 = 2

			if 2 < arg_208_1.time_ and arg_208_1.time_ <= var_211_9 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_10 = 2

			if var_211_9 <= arg_208_1.time_ and arg_208_1.time_ < var_211_9 + var_211_10 then
				local var_211_11 = Color.New(0, 0, 0)

				var_211_11.a = Mathf.Lerp(1, 0, (arg_208_1.time_ - var_211_9) / var_211_10)
				arg_208_1.mask_.color = var_211_11
			end

			if arg_208_1.time_ >= var_211_9 + var_211_10 and arg_208_1.time_ < var_211_9 + var_211_10 + arg_211_0 then
				local var_211_12 = Color.New(0, 0, 0)

				arg_208_1.mask_.enabled = false
				var_211_12.a = 0
				arg_208_1.mask_.color = var_211_12
			end

			local var_211_13 = arg_208_1.actors_["104402ui_story"].transform

			if 1.96599999815226 < arg_208_1.time_ and arg_208_1.time_ <= 1.96599999815226 + arg_211_0 then
				arg_208_1.var_.moveOldPos104402ui_story = var_211_13.localPosition

				local var_211_14 = GameObjectTools.GetOrAddComponent(var_211_13.gameObject, typeof(DynamicBoneHelper))

				if var_211_14 then
					var_211_14:EnableDynamicBone(false)
				end
			end

			local var_211_15 = 0.001

			if 1.96599999815226 <= arg_208_1.time_ and arg_208_1.time_ < 1.96599999815226 + var_211_15 then
				var_211_13.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_208_1.time_ - 1.96599999815226) / var_211_15)
				var_211_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_13.position).x, (manager.ui.mainCamera.transform.position - var_211_13.position).y, (manager.ui.mainCamera.transform.position - var_211_13.position).z)
				var_211_13.localEulerAngles.z = 0
				var_211_13.localEulerAngles.x = 0
				var_211_13.localEulerAngles = var_211_13.localEulerAngles
			end

			if arg_208_1.time_ >= 1.96599999815226 + var_211_15 and arg_208_1.time_ < 1.96599999815226 + var_211_15 + arg_211_0 then
				var_211_13.localPosition = Vector3.New(0, 100, 0)
				var_211_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_13.position).x, (manager.ui.mainCamera.transform.position - var_211_13.position).y, (manager.ui.mainCamera.transform.position - var_211_13.position).z)
				var_211_13.localEulerAngles.z = 0
				var_211_13.localEulerAngles.x = 0
				var_211_13.localEulerAngles = var_211_13.localEulerAngles

				local var_211_16 = GameObjectTools.GetOrAddComponent(var_211_13.gameObject, typeof(DynamicBoneHelper))

				if var_211_16 then
					var_211_16:EnableDynamicBone(true)
				end
			end

			local var_211_17 = arg_208_1.bgs_.SP93601.transform

			if 2 < arg_208_1.time_ and arg_208_1.time_ <= 2 + arg_211_0 then
				arg_208_1.var_.moveOldPosSP93601 = var_211_17.localPosition
			end

			local var_211_18 = 2

			if 2 <= arg_208_1.time_ and arg_208_1.time_ < 2 + var_211_18 then
				var_211_17.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPosSP93601, Vector3.New(0, -1, -1), (arg_208_1.time_ - 2) / var_211_18)
			end

			if arg_208_1.time_ >= 2 + var_211_18 and arg_208_1.time_ < 2 + var_211_18 + arg_211_0 then
				var_211_17.localPosition = Vector3.New(0, -1, -1)
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_19 = 4
			local var_211_20 = 1.425

			if 4 < arg_208_1.time_ and arg_208_1.time_ <= var_211_19 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_21 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_21:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_22 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(936041049).content)

				arg_208_1.text_.text = var_211_22

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_24 = 57 <= 0 and var_211_20 or var_211_20 * (utf8.len(var_211_22) / 57)

				if (57 <= 0 and var_211_20 or var_211_20 * (utf8.len(var_211_22) / 57)) > 0 and var_211_20 < var_211_24 then
					arg_208_1.talkMaxDuration = var_211_24
					var_211_19 = var_211_19 + 0.3

					if var_211_24 + var_211_19 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_24 + var_211_19
					end
				end

				arg_208_1.text_.text = var_211_22
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_25 = var_211_19 + 0.3
			local var_211_26 = math.max(var_211_20, arg_208_1.talkMaxDuration)

			if var_211_19 + 0.3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_25 + var_211_26 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_25) / var_211_26

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_25 + var_211_26 and arg_208_1.time_ < var_211_25 + var_211_26 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93601",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-0.14, 0.95, -2.18),
					endPos = Vector3.New(0, -1, -1),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play936041050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 936041050
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play936041051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.225

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(936041050).content)

				arg_214_1.text_.text = var_217_1

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_3 = 9 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 9)

				if (9 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 9)) > 0 and var_217_0 < var_217_3 then
					arg_214_1.talkMaxDuration = var_217_3

					if var_217_3 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_3 + 0
					end
				end

				arg_214_1.text_.text = var_217_1
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_4 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_4

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play936041051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 936041051
		arg_218_1.duration_ = 9.43

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play936041052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.925

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_1 = arg_218_1:GetWordFromCfg(936041051)
				local var_221_2 = arg_218_1:FormatText(var_221_1.content)

				arg_218_1.text_.text = var_221_2

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 37 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 37)

				if (37 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 37)) > 0 and var_221_0 < var_221_4 then
					arg_218_1.talkMaxDuration = var_221_4

					if var_221_4 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_4 + 0
					end
				end

				arg_218_1.text_.text = var_221_2
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041051", "story_v_side_old_936041.awb") ~= 0 then
					local var_221_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041051", "story_v_side_old_936041.awb") / 1000

					if var_221_5 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + 0
					end

					if var_221_1.prefab_name ~= "" and arg_218_1.actors_[var_221_1.prefab_name] ~= nil then
						local var_221_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_1.prefab_name].transform, "story_v_side_old_936041", "936041051", "story_v_side_old_936041.awb")

						arg_218_1:RecordAudio("936041051", var_221_6)
						arg_218_1:RecordAudio("936041051", var_221_6)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041051", "story_v_side_old_936041.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041051", "story_v_side_old_936041.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play936041052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 936041052
		arg_222_1.duration_ = 4.1

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play936041053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.45

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:GetWordFromCfg(936041052)
				local var_225_2 = arg_222_1:FormatText(var_225_1.content)

				arg_222_1.text_.text = var_225_2

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 18 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 18)

				if (18 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 18)) > 0 and var_225_0 < var_225_4 then
					arg_222_1.talkMaxDuration = var_225_4

					if var_225_4 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_4 + 0
					end
				end

				arg_222_1.text_.text = var_225_2
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041052", "story_v_side_old_936041.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041052", "story_v_side_old_936041.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_side_old_936041", "936041052", "story_v_side_old_936041.awb")

						arg_222_1:RecordAudio("936041052", var_225_6)
						arg_222_1:RecordAudio("936041052", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041052", "story_v_side_old_936041.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041052", "story_v_side_old_936041.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play936041053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 936041053
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play936041054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 1.025

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(936041053).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 41 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 41)

				if (41 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 41)) > 0 and var_229_0 < var_229_3 then
					arg_226_1.talkMaxDuration = var_229_3

					if var_229_3 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_3 + 0
					end
				end

				arg_226_1.text_.text = var_229_1
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_4 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_4

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play936041054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 936041054
		arg_230_1.duration_ = 9.1

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play936041055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 1

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:GetWordFromCfg(936041054)
				local var_233_2 = arg_230_1:FormatText(var_233_1.content)

				arg_230_1.text_.text = var_233_2

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 40 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 40)

				if (40 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 40)) > 0 and var_233_0 < var_233_4 then
					arg_230_1.talkMaxDuration = var_233_4

					if var_233_4 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_4 + 0
					end
				end

				arg_230_1.text_.text = var_233_2
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041054", "story_v_side_old_936041.awb") ~= 0 then
					local var_233_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041054", "story_v_side_old_936041.awb") / 1000

					if var_233_5 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + 0
					end

					if var_233_1.prefab_name ~= "" and arg_230_1.actors_[var_233_1.prefab_name] ~= nil then
						local var_233_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_1.prefab_name].transform, "story_v_side_old_936041", "936041054", "story_v_side_old_936041.awb")

						arg_230_1:RecordAudio("936041054", var_233_6)
						arg_230_1:RecordAudio("936041054", var_233_6)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041054", "story_v_side_old_936041.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041054", "story_v_side_old_936041.awb")
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
	Play936041055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 936041055
		arg_234_1.duration_ = 7.67

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play936041056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.825

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_1 = arg_234_1:GetWordFromCfg(936041055)
				local var_237_2 = arg_234_1:FormatText(var_237_1.content)

				arg_234_1.text_.text = var_237_2

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_4 = 33 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 33)

				if (33 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 33)) > 0 and var_237_0 < var_237_4 then
					arg_234_1.talkMaxDuration = var_237_4

					if var_237_4 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_4 + 0
					end
				end

				arg_234_1.text_.text = var_237_2
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041055", "story_v_side_old_936041.awb") ~= 0 then
					local var_237_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041055", "story_v_side_old_936041.awb") / 1000

					if var_237_5 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + 0
					end

					if var_237_1.prefab_name ~= "" and arg_234_1.actors_[var_237_1.prefab_name] ~= nil then
						local var_237_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_1.prefab_name].transform, "story_v_side_old_936041", "936041055", "story_v_side_old_936041.awb")

						arg_234_1:RecordAudio("936041055", var_237_6)
						arg_234_1:RecordAudio("936041055", var_237_6)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041055", "story_v_side_old_936041.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041055", "story_v_side_old_936041.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_7 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_7

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play936041056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 936041056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play936041057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.15

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_1 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(936041056).content)

				arg_238_1.text_.text = var_241_1

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_3 = 6 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 6)

				if (6 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 6)) > 0 and var_241_0 < var_241_3 then
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
	Play936041057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 936041057
		arg_242_1.duration_ = 2.56

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play936041058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPosSP93601 = arg_242_1.bgs_.SP93601.transform.localPosition
			end

			local var_245_0 = 0.7

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 then
				arg_242_1.bgs_.SP93601.transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPosSP93601, Vector3.New(0.1, -1, -1.5), (arg_242_1.time_ - 0) / var_245_0)
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 then
				arg_242_1.bgs_.SP93601.transform.localPosition = Vector3.New(0.1, -1, -1.5)
			end

			local var_245_1 = arg_242_1.bgs_.SP93601.transform

			if 0.866666666666667 < arg_242_1.time_ and arg_242_1.time_ <= 0.866666666666667 + arg_245_0 then
				arg_242_1.var_.moveOldPosSP93601 = var_245_1.localPosition
			end

			local var_245_2 = 0.733333333333333

			if 0.866666666666667 <= arg_242_1.time_ and arg_242_1.time_ < 0.866666666666667 + var_245_2 then
				var_245_1.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPosSP93601, Vector3.New(0.25, -1, -2), (arg_242_1.time_ - 0.866666666666667) / var_245_2)
			end

			if arg_242_1.time_ >= 0.866666666666667 + var_245_2 and arg_242_1.time_ < 0.866666666666667 + var_245_2 + arg_245_0 then
				var_245_1.localPosition = Vector3.New(0.25, -1, -2)
			end

			local var_245_3 = arg_242_1.bgs_.SP93601.transform

			if 1.73333333333333 < arg_242_1.time_ and arg_242_1.time_ <= 1.73333333333333 + arg_245_0 then
				arg_242_1.var_.moveOldPosSP93601 = var_245_3.localPosition
			end

			local var_245_4 = 0.733333333333333

			if 1.73333333333333 <= arg_242_1.time_ and arg_242_1.time_ < 1.73333333333333 + var_245_4 then
				var_245_3.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPosSP93601, Vector3.New(0.35, -1, -2.5), (arg_242_1.time_ - 1.73333333333333) / var_245_4)
			end

			if arg_242_1.time_ >= 1.73333333333333 + var_245_4 and arg_242_1.time_ < 1.73333333333333 + var_245_4 + arg_245_0 then
				var_245_3.localPosition = Vector3.New(0.35, -1, -2.5)
			end

			local var_245_5 = 0

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 then
				arg_242_1.allBtn_.enabled = false
			end

			if arg_242_1.time_ >= var_245_5 + 2.55833333333333 and arg_242_1.time_ < var_245_5 + 2.55833333333333 + arg_245_0 then
				arg_242_1.allBtn_.enabled = true
			end

			local var_245_6 = 0
			local var_245_7 = 0.15

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_8 = arg_242_1:GetWordFromCfg(936041057)
				local var_245_9 = arg_242_1:FormatText(var_245_8.content)

				arg_242_1.text_.text = var_245_9

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_11 = 6 <= 0 and var_245_7 or var_245_7 * (utf8.len(var_245_9) / 6)

				if (6 <= 0 and var_245_7 or var_245_7 * (utf8.len(var_245_9) / 6)) > 0 and var_245_7 < var_245_11 then
					arg_242_1.talkMaxDuration = var_245_11

					if var_245_11 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_11 + var_245_6
					end
				end

				arg_242_1.text_.text = var_245_9
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041057", "story_v_side_old_936041.awb") ~= 0 then
					local var_245_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041057", "story_v_side_old_936041.awb") / 1000

					if var_245_12 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_12 + var_245_6
					end

					if var_245_8.prefab_name ~= "" and arg_242_1.actors_[var_245_8.prefab_name] ~= nil then
						local var_245_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_8.prefab_name].transform, "story_v_side_old_936041", "936041057", "story_v_side_old_936041.awb")

						arg_242_1:RecordAudio("936041057", var_245_13)
						arg_242_1:RecordAudio("936041057", var_245_13)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041057", "story_v_side_old_936041.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041057", "story_v_side_old_936041.awb")
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
				needEase = true,
				actorName = "SP93601",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.7,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, -1, -1),
					endPos = Vector3.New(0.1, -1, -1.5),
					easeType = LeanTweenType.easeInOutCubic
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93601",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.733333333333333,
				startTime = 0.866666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0.1, -1, -1.5),
					endPos = Vector3.New(0.25, -1, -2),
					easeType = LeanTweenType.easeInOutCubic
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93601",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.733333333333333,
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0.25, -1, -2),
					endPos = Vector3.New(0.35, -1, -2.5),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play936041058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 936041058
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play936041059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 1.25

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(936041058).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 50 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 50)

				if (50 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 50)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play936041059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 936041059
		arg_250_1.duration_ = 6.03

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play936041060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.75

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_1 = arg_250_1:GetWordFromCfg(936041059)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.text_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 30 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 30)

				if (30 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 30)) > 0 and var_253_0 < var_253_4 then
					arg_250_1.talkMaxDuration = var_253_4

					if var_253_4 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_4 + 0
					end
				end

				arg_250_1.text_.text = var_253_2
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041059", "story_v_side_old_936041.awb") ~= 0 then
					local var_253_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041059", "story_v_side_old_936041.awb") / 1000

					if var_253_5 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + 0
					end

					if var_253_1.prefab_name ~= "" and arg_250_1.actors_[var_253_1.prefab_name] ~= nil then
						local var_253_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_1.prefab_name].transform, "story_v_side_old_936041", "936041059", "story_v_side_old_936041.awb")

						arg_250_1:RecordAudio("936041059", var_253_6)
						arg_250_1:RecordAudio("936041059", var_253_6)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041059", "story_v_side_old_936041.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041059", "story_v_side_old_936041.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_7 and arg_250_1.time_ < 0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play936041060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 936041060
		arg_254_1.duration_ = 8.97

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play936041061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 1

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_1 = arg_254_1:GetWordFromCfg(936041060)
				local var_257_2 = arg_254_1:FormatText(var_257_1.content)

				arg_254_1.text_.text = var_257_2

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_4 = 40 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_2) / 40)

				if (40 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_2) / 40)) > 0 and var_257_0 < var_257_4 then
					arg_254_1.talkMaxDuration = var_257_4

					if var_257_4 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_4 + 0
					end
				end

				arg_254_1.text_.text = var_257_2
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041060", "story_v_side_old_936041.awb") ~= 0 then
					local var_257_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041060", "story_v_side_old_936041.awb") / 1000

					if var_257_5 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + 0
					end

					if var_257_1.prefab_name ~= "" and arg_254_1.actors_[var_257_1.prefab_name] ~= nil then
						local var_257_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_1.prefab_name].transform, "story_v_side_old_936041", "936041060", "story_v_side_old_936041.awb")

						arg_254_1:RecordAudio("936041060", var_257_6)
						arg_254_1:RecordAudio("936041060", var_257_6)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041060", "story_v_side_old_936041.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041060", "story_v_side_old_936041.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_7 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_7

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play936041061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 936041061
		arg_258_1.duration_ = 4.5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play936041062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.425

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:GetWordFromCfg(936041061)
				local var_261_2 = arg_258_1:FormatText(var_261_1.content)

				arg_258_1.text_.text = var_261_2

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 17 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 17)

				if (17 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 17)) > 0 and var_261_0 < var_261_4 then
					arg_258_1.talkMaxDuration = var_261_4

					if var_261_4 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_4 + 0
					end
				end

				arg_258_1.text_.text = var_261_2
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041061", "story_v_side_old_936041.awb") ~= 0 then
					local var_261_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041061", "story_v_side_old_936041.awb") / 1000

					if var_261_5 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + 0
					end

					if var_261_1.prefab_name ~= "" and arg_258_1.actors_[var_261_1.prefab_name] ~= nil then
						local var_261_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_1.prefab_name].transform, "story_v_side_old_936041", "936041061", "story_v_side_old_936041.awb")

						arg_258_1:RecordAudio("936041061", var_261_6)
						arg_258_1:RecordAudio("936041061", var_261_6)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041061", "story_v_side_old_936041.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041061", "story_v_side_old_936041.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play936041062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 936041062
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play936041063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.15

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_1 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(936041062).content)

				arg_262_1.text_.text = var_265_1

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_3 = 6 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 6)

				if (6 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 6)) > 0 and var_265_0 < var_265_3 then
					arg_262_1.talkMaxDuration = var_265_3

					if var_265_3 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_3 + 0
					end
				end

				arg_262_1.text_.text = var_265_1
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_4 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_4

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play936041063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 936041063
		arg_266_1.duration_ = 3.1

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play936041064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.3

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_1 = arg_266_1:GetWordFromCfg(936041063)
				local var_269_2 = arg_266_1:FormatText(var_269_1.content)

				arg_266_1.text_.text = var_269_2

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_4 = 12 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 12)

				if (12 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 12)) > 0 and var_269_0 < var_269_4 then
					arg_266_1.talkMaxDuration = var_269_4

					if var_269_4 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_4 + 0
					end
				end

				arg_266_1.text_.text = var_269_2
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041063", "story_v_side_old_936041.awb") ~= 0 then
					local var_269_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041063", "story_v_side_old_936041.awb") / 1000

					if var_269_5 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + 0
					end

					if var_269_1.prefab_name ~= "" and arg_266_1.actors_[var_269_1.prefab_name] ~= nil then
						local var_269_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_1.prefab_name].transform, "story_v_side_old_936041", "936041063", "story_v_side_old_936041.awb")

						arg_266_1:RecordAudio("936041063", var_269_6)
						arg_266_1:RecordAudio("936041063", var_269_6)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041063", "story_v_side_old_936041.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041063", "story_v_side_old_936041.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_7 and arg_266_1.time_ < 0 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play936041064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 936041064
		arg_270_1.duration_ = 9

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play936041065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_0 = 2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 then
				local var_273_1 = Color.New(0, 0, 0)

				var_273_1.a = Mathf.Lerp(0, 1, (arg_270_1.time_ - 0) / var_273_0)
				arg_270_1.mask_.color = var_273_1
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 then
				local var_273_2 = Color.New(0, 0, 0)

				var_273_2.a = 1
				arg_270_1.mask_.color = var_273_2
			end

			local var_273_3 = 2

			if 2 < arg_270_1.time_ and arg_270_1.time_ <= var_273_3 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_4 = 2

			if var_273_3 <= arg_270_1.time_ and arg_270_1.time_ < var_273_3 + var_273_4 then
				local var_273_5 = Color.New(0, 0, 0)

				var_273_5.a = Mathf.Lerp(1, 0, (arg_270_1.time_ - var_273_3) / var_273_4)
				arg_270_1.mask_.color = var_273_5
			end

			if arg_270_1.time_ >= var_273_3 + var_273_4 and arg_270_1.time_ < var_273_3 + var_273_4 + arg_273_0 then
				local var_273_6 = Color.New(0, 0, 0)

				arg_270_1.mask_.enabled = false
				var_273_6.a = 0
				arg_270_1.mask_.color = var_273_6
			end

			if 2 < arg_270_1.time_ and arg_270_1.time_ <= 2 + arg_273_0 then
				local var_273_7 = arg_270_1.bgs_.SP93601

				arg_270_1.bgs_.SP93601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_273_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_273_8 = var_273_7:GetComponent("SpriteRenderer")

				if var_273_8 and var_273_8.sprite then
					local var_273_9 = 2 * (var_273_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_273_7.transform.localScale = Vector3.New(var_273_9 / var_273_8.sprite.bounds.size.y < var_273_9 * manager.ui.mainCameraCom_.aspect / var_273_8.sprite.bounds.size.x and var_273_9 * manager.ui.mainCameraCom_.aspect / var_273_8.sprite.bounds.size.x or var_273_9 / var_273_8.sprite.bounds.size.y, var_273_9 / var_273_8.sprite.bounds.size.y < var_273_9 * manager.ui.mainCameraCom_.aspect / var_273_8.sprite.bounds.size.x and var_273_9 * manager.ui.mainCameraCom_.aspect / var_273_8.sprite.bounds.size.x or var_273_9 / var_273_8.sprite.bounds.size.y, 0)
				end

				for iter_273_0, iter_273_1 in pairs(arg_270_1.bgs_) do
					if iter_273_0 ~= "SP93601" then
						iter_273_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_273_10 = arg_270_1.bgs_.SP93601.transform

			if 2 < arg_270_1.time_ and arg_270_1.time_ <= 2 + arg_273_0 then
				arg_270_1.var_.moveOldPosSP93601 = var_273_10.localPosition
			end

			local var_273_11 = 1.7

			if 2 <= arg_270_1.time_ and arg_270_1.time_ < 2 + var_273_11 then
				var_273_10.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPosSP93601, Vector3.New(0, 1, 10), (arg_270_1.time_ - 2) / var_273_11)
			end

			if arg_270_1.time_ >= 2 + var_273_11 and arg_270_1.time_ < 2 + var_273_11 + arg_273_0 then
				var_273_10.localPosition = Vector3.New(0, 1, 10)
			end

			local var_273_12 = 4
			local var_273_13 = 0.725

			if 4 < arg_270_1.time_ and arg_270_1.time_ <= var_273_12 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_14 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(936041064).content)

				arg_270_1.text_.text = var_273_14

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_16 = 29 <= 0 and var_273_13 or var_273_13 * (utf8.len(var_273_14) / 29)

				if (29 <= 0 and var_273_13 or var_273_13 * (utf8.len(var_273_14) / 29)) > 0 and var_273_13 < var_273_16 then
					arg_270_1.talkMaxDuration = var_273_16

					if var_273_16 + var_273_12 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_16 + var_273_12
					end
				end

				arg_270_1.text_.text = var_273_14
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_17 = math.max(var_273_13, arg_270_1.talkMaxDuration)

			if var_273_12 <= arg_270_1.time_ and arg_270_1.time_ < var_273_12 + var_273_17 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_12) / var_273_17

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_12 + var_273_17 and arg_270_1.time_ < var_273_12 + var_273_17 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93601",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.7,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play936041065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 936041065
		arg_274_1.duration_ = 4.27

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play936041066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0.3

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_1 = arg_274_1:GetWordFromCfg(936041065)
				local var_277_2 = arg_274_1:FormatText(var_277_1.content)

				arg_274_1.text_.text = var_277_2

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_4 = 12 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 12)

				if (12 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 12)) > 0 and var_277_0 < var_277_4 then
					arg_274_1.talkMaxDuration = var_277_4

					if var_277_4 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_4 + 0
					end
				end

				arg_274_1.text_.text = var_277_2
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041065", "story_v_side_old_936041.awb") ~= 0 then
					local var_277_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041065", "story_v_side_old_936041.awb") / 1000

					if var_277_5 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + 0
					end

					if var_277_1.prefab_name ~= "" and arg_274_1.actors_[var_277_1.prefab_name] ~= nil then
						local var_277_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_1.prefab_name].transform, "story_v_side_old_936041", "936041065", "story_v_side_old_936041.awb")

						arg_274_1:RecordAudio("936041065", var_277_6)
						arg_274_1:RecordAudio("936041065", var_277_6)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041065", "story_v_side_old_936041.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041065", "story_v_side_old_936041.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_7 and arg_274_1.time_ < 0 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play936041066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 936041066
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play936041067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.25

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_1 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(936041066).content)

				arg_278_1.text_.text = var_281_1

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_3 = 10 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 10)

				if (10 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 10)) > 0 and var_281_0 < var_281_3 then
					arg_278_1.talkMaxDuration = var_281_3

					if var_281_3 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_3 + 0
					end
				end

				arg_278_1.text_.text = var_281_1
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_4 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_4

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play936041067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 936041067
		arg_282_1.duration_ = 4.87

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play936041068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.6

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_1 = arg_282_1:GetWordFromCfg(936041067)
				local var_285_2 = arg_282_1:FormatText(var_285_1.content)

				arg_282_1.text_.text = var_285_2

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_4 = 24 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_2) / 24)

				if (24 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_2) / 24)) > 0 and var_285_0 < var_285_4 then
					arg_282_1.talkMaxDuration = var_285_4

					if var_285_4 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_4 + 0
					end
				end

				arg_282_1.text_.text = var_285_2
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041067", "story_v_side_old_936041.awb") ~= 0 then
					local var_285_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041067", "story_v_side_old_936041.awb") / 1000

					if var_285_5 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + 0
					end

					if var_285_1.prefab_name ~= "" and arg_282_1.actors_[var_285_1.prefab_name] ~= nil then
						local var_285_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_1.prefab_name].transform, "story_v_side_old_936041", "936041067", "story_v_side_old_936041.awb")

						arg_282_1:RecordAudio("936041067", var_285_6)
						arg_282_1:RecordAudio("936041067", var_285_6)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041067", "story_v_side_old_936041.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041067", "story_v_side_old_936041.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_7 and arg_282_1.time_ < 0 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play936041068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 936041068
		arg_286_1.duration_ = 7.57

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play936041069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.8

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_1 = arg_286_1:GetWordFromCfg(936041068)
				local var_289_2 = arg_286_1:FormatText(var_289_1.content)

				arg_286_1.text_.text = var_289_2

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 32 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 32)

				if (32 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 32)) > 0 and var_289_0 < var_289_4 then
					arg_286_1.talkMaxDuration = var_289_4

					if var_289_4 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_4 + 0
					end
				end

				arg_286_1.text_.text = var_289_2
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041068", "story_v_side_old_936041.awb") ~= 0 then
					local var_289_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041068", "story_v_side_old_936041.awb") / 1000

					if var_289_5 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + 0
					end

					if var_289_1.prefab_name ~= "" and arg_286_1.actors_[var_289_1.prefab_name] ~= nil then
						local var_289_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_1.prefab_name].transform, "story_v_side_old_936041", "936041068", "story_v_side_old_936041.awb")

						arg_286_1:RecordAudio("936041068", var_289_6)
						arg_286_1:RecordAudio("936041068", var_289_6)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041068", "story_v_side_old_936041.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041068", "story_v_side_old_936041.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_7 and arg_286_1.time_ < 0 + var_289_7 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play936041069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 936041069
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play936041070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.575

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_1 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(936041069).content)

				arg_290_1.text_.text = var_293_1

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_3 = 23 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 23)

				if (23 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 23)) > 0 and var_293_0 < var_293_3 then
					arg_290_1.talkMaxDuration = var_293_3

					if var_293_3 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_3 + 0
					end
				end

				arg_290_1.text_.text = var_293_1
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_4 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_4

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play936041070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 936041070
		arg_294_1.duration_ = 4.27

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play936041071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.4

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_1 = arg_294_1:GetWordFromCfg(936041070)
				local var_297_2 = arg_294_1:FormatText(var_297_1.content)

				arg_294_1.text_.text = var_297_2

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 16 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 16)

				if (16 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 16)) > 0 and var_297_0 < var_297_4 then
					arg_294_1.talkMaxDuration = var_297_4

					if var_297_4 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_4 + 0
					end
				end

				arg_294_1.text_.text = var_297_2
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041070", "story_v_side_old_936041.awb") ~= 0 then
					local var_297_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041070", "story_v_side_old_936041.awb") / 1000

					if var_297_5 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + 0
					end

					if var_297_1.prefab_name ~= "" and arg_294_1.actors_[var_297_1.prefab_name] ~= nil then
						local var_297_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_1.prefab_name].transform, "story_v_side_old_936041", "936041070", "story_v_side_old_936041.awb")

						arg_294_1:RecordAudio("936041070", var_297_6)
						arg_294_1:RecordAudio("936041070", var_297_6)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041070", "story_v_side_old_936041.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041070", "story_v_side_old_936041.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play936041071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 936041071
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play936041072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.525

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(936041071).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 21 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 21)

				if (21 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 21)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play936041072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 936041072
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play936041073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.425

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(936041072).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 17 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 17)

				if (17 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 17)) > 0 and var_305_0 < var_305_3 then
					arg_302_1.talkMaxDuration = var_305_3

					if var_305_3 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_3 + 0
					end
				end

				arg_302_1.text_.text = var_305_1
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_4 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_4

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play936041073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 936041073
		arg_306_1.duration_ = 3.8

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play936041074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0.375

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_1 = arg_306_1:GetWordFromCfg(936041073)
				local var_309_2 = arg_306_1:FormatText(var_309_1.content)

				arg_306_1.text_.text = var_309_2

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 15 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 15)

				if (15 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 15)) > 0 and var_309_0 < var_309_4 then
					arg_306_1.talkMaxDuration = var_309_4

					if var_309_4 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_4 + 0
					end
				end

				arg_306_1.text_.text = var_309_2
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041073", "story_v_side_old_936041.awb") ~= 0 then
					local var_309_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041073", "story_v_side_old_936041.awb") / 1000

					if var_309_5 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + 0
					end

					if var_309_1.prefab_name ~= "" and arg_306_1.actors_[var_309_1.prefab_name] ~= nil then
						local var_309_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_1.prefab_name].transform, "story_v_side_old_936041", "936041073", "story_v_side_old_936041.awb")

						arg_306_1:RecordAudio("936041073", var_309_6)
						arg_306_1:RecordAudio("936041073", var_309_6)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041073", "story_v_side_old_936041.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041073", "story_v_side_old_936041.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play936041074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 936041074
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play936041075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 1.125

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_1 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(936041074).content)

				arg_310_1.text_.text = var_313_1

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_3 = 45 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 45)

				if (45 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 45)) > 0 and var_313_0 < var_313_3 then
					arg_310_1.talkMaxDuration = var_313_3

					if var_313_3 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_3 + 0
					end
				end

				arg_310_1.text_.text = var_313_1
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_4 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_4

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play936041075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 936041075
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play936041076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 1.6

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_1 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(936041075).content)

				arg_314_1.text_.text = var_317_1

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_3 = 64 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 64)

				if (64 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 64)) > 0 and var_317_0 < var_317_3 then
					arg_314_1.talkMaxDuration = var_317_3

					if var_317_3 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_3 + 0
					end
				end

				arg_314_1.text_.text = var_317_1
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_4 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_4 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_4

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_4 and arg_314_1.time_ < 0 + var_317_4 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play936041076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 936041076
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play936041077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 1.125

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_1 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(936041076).content)

				arg_318_1.text_.text = var_321_1

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_3 = 45 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 45)

				if (45 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 45)) > 0 and var_321_0 < var_321_3 then
					arg_318_1.talkMaxDuration = var_321_3

					if var_321_3 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_3 + 0
					end
				end

				arg_318_1.text_.text = var_321_1
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_4 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_4

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play936041077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 936041077
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play936041078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.525

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_1 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(936041077).content)

				arg_322_1.text_.text = var_325_1

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_3 = 21 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 21)

				if (21 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 21)) > 0 and var_325_0 < var_325_3 then
					arg_322_1.talkMaxDuration = var_325_3

					if var_325_3 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_3 + 0
					end
				end

				arg_322_1.text_.text = var_325_1
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_4 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_4 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_4

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_4 and arg_322_1.time_ < 0 + var_325_4 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play936041078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 936041078
		arg_326_1.duration_ = 3.8

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play936041079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.375

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_1 = arg_326_1:GetWordFromCfg(936041078)
				local var_329_2 = arg_326_1:FormatText(var_329_1.content)

				arg_326_1.text_.text = var_329_2

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 15 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 15)

				if (15 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 15)) > 0 and var_329_0 < var_329_4 then
					arg_326_1.talkMaxDuration = var_329_4

					if var_329_4 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_4 + 0
					end
				end

				arg_326_1.text_.text = var_329_2
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041078", "story_v_side_old_936041.awb") ~= 0 then
					local var_329_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041078", "story_v_side_old_936041.awb") / 1000

					if var_329_5 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + 0
					end

					if var_329_1.prefab_name ~= "" and arg_326_1.actors_[var_329_1.prefab_name] ~= nil then
						local var_329_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_1.prefab_name].transform, "story_v_side_old_936041", "936041078", "story_v_side_old_936041.awb")

						arg_326_1:RecordAudio("936041078", var_329_6)
						arg_326_1:RecordAudio("936041078", var_329_6)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041078", "story_v_side_old_936041.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041078", "story_v_side_old_936041.awb")
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
	Play936041079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 936041079
		arg_330_1.duration_ = 4.63

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play936041080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.55

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:GetWordFromCfg(936041079)
				local var_333_2 = arg_330_1:FormatText(var_333_1.content)

				arg_330_1.text_.text = var_333_2

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 22 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 22)

				if (22 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 22)) > 0 and var_333_0 < var_333_4 then
					arg_330_1.talkMaxDuration = var_333_4

					if var_333_4 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_4 + 0
					end
				end

				arg_330_1.text_.text = var_333_2
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041079", "story_v_side_old_936041.awb") ~= 0 then
					local var_333_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041079", "story_v_side_old_936041.awb") / 1000

					if var_333_5 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + 0
					end

					if var_333_1.prefab_name ~= "" and arg_330_1.actors_[var_333_1.prefab_name] ~= nil then
						local var_333_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_1.prefab_name].transform, "story_v_side_old_936041", "936041079", "story_v_side_old_936041.awb")

						arg_330_1:RecordAudio("936041079", var_333_6)
						arg_330_1:RecordAudio("936041079", var_333_6)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041079", "story_v_side_old_936041.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041079", "story_v_side_old_936041.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play936041080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 936041080
		arg_334_1.duration_ = 4.97

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play936041081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.575

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_1 = arg_334_1:GetWordFromCfg(936041080)
				local var_337_2 = arg_334_1:FormatText(var_337_1.content)

				arg_334_1.text_.text = var_337_2

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 23 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 23)

				if (23 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 23)) > 0 and var_337_0 < var_337_4 then
					arg_334_1.talkMaxDuration = var_337_4

					if var_337_4 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_4 + 0
					end
				end

				arg_334_1.text_.text = var_337_2
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041080", "story_v_side_old_936041.awb") ~= 0 then
					local var_337_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041080", "story_v_side_old_936041.awb") / 1000

					if var_337_5 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + 0
					end

					if var_337_1.prefab_name ~= "" and arg_334_1.actors_[var_337_1.prefab_name] ~= nil then
						local var_337_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_1.prefab_name].transform, "story_v_side_old_936041", "936041080", "story_v_side_old_936041.awb")

						arg_334_1:RecordAudio("936041080", var_337_6)
						arg_334_1:RecordAudio("936041080", var_337_6)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041080", "story_v_side_old_936041.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041080", "story_v_side_old_936041.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_7 and arg_334_1.time_ < 0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play936041081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 936041081
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play936041082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0.133333333333333 < arg_338_1.time_ and arg_338_1.time_ <= 0.133333333333333 + arg_341_0 then
				arg_338_1:AudioAction("play", "effect", "ui_skip", "ui_bgm_66", "")
			end

			local var_341_1 = 0
			local var_341_2 = 0.65

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_3 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(936041081).content)

				arg_338_1.text_.text = var_341_3

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 26 <= 0 and var_341_2 or var_341_2 * (utf8.len(var_341_3) / 26)

				if (26 <= 0 and var_341_2 or var_341_2 * (utf8.len(var_341_3) / 26)) > 0 and var_341_2 < var_341_5 then
					arg_338_1.talkMaxDuration = var_341_5

					if var_341_5 + var_341_1 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_5 + var_341_1
					end
				end

				arg_338_1.text_.text = var_341_3
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_6 = math.max(var_341_2, arg_338_1.talkMaxDuration)

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_6 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_1) / var_341_6

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_1 + var_341_6 and arg_338_1.time_ < var_341_1 + var_341_6 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play936041082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 936041082
		arg_342_1.duration_ = 5.13

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play936041083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.375

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_1 = arg_342_1:GetWordFromCfg(936041082)
				local var_345_2 = arg_342_1:FormatText(var_345_1.content)

				arg_342_1.text_.text = var_345_2

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 15 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 15)

				if (15 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 15)) > 0 and var_345_0 < var_345_4 then
					arg_342_1.talkMaxDuration = var_345_4

					if var_345_4 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_4 + 0
					end
				end

				arg_342_1.text_.text = var_345_2
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041082", "story_v_side_old_936041.awb") ~= 0 then
					local var_345_5 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041082", "story_v_side_old_936041.awb") / 1000

					if var_345_5 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + 0
					end

					if var_345_1.prefab_name ~= "" and arg_342_1.actors_[var_345_1.prefab_name] ~= nil then
						local var_345_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_1.prefab_name].transform, "story_v_side_old_936041", "936041082", "story_v_side_old_936041.awb")

						arg_342_1:RecordAudio("936041082", var_345_6)
						arg_342_1:RecordAudio("936041082", var_345_6)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041082", "story_v_side_old_936041.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041082", "story_v_side_old_936041.awb")
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
	Play936041083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 936041083
		arg_346_1.duration_ = 6.43

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play936041084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 1 < arg_346_1.time_ and arg_346_1.time_ <= 1 + arg_349_0 then
				arg_346_1.var_.moveOldPosSP93601 = arg_346_1.bgs_.SP93601.transform.localPosition
			end

			local var_349_0 = 2.06666666666667

			if 1 <= arg_346_1.time_ and arg_346_1.time_ < 1 + var_349_0 then
				arg_346_1.bgs_.SP93601.transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPosSP93601, Vector3.New(0, 1, 0.5), (arg_346_1.time_ - 1) / var_349_0)
			end

			if arg_346_1.time_ >= 1 + var_349_0 and arg_346_1.time_ < 1 + var_349_0 + arg_349_0 then
				arg_346_1.bgs_.SP93601.transform.localPosition = Vector3.New(0, 1, 0.5)
			end

			local var_349_1

			if 1 < arg_346_1.time_ and arg_346_1.time_ <= 1 + arg_349_0 then
				local var_349_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_349_2 then
					var_349_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_349_2.radialBlurScale = 0
					var_349_2.radialBlurGradient = 1
					var_349_2.radialBlurIntensity = 1

					if var_349_1 then
						var_349_2.radialBlurTarget = var_349_1.transform
					end
				end
			end

			local var_349_3 = 2.06666666666667

			if 1 <= arg_346_1.time_ and arg_346_1.time_ < 1 + var_349_3 then
				local var_349_4 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_349_4 then
					var_349_4.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_349_4.radialBlurScale = Mathf.Lerp(0, 0.3, (arg_346_1.time_ - 1) / var_349_3)
					var_349_4.radialBlurGradient = Mathf.Lerp(1, 1, (arg_346_1.time_ - 1) / var_349_3)
					var_349_4.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_346_1.time_ - 1) / var_349_3)
				end
			end

			if arg_346_1.time_ >= 1 + var_349_3 and arg_346_1.time_ < 1 + var_349_3 + arg_349_0 then
				local var_349_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_349_5 then
					var_349_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_349_5.radialBlurScale = 0.3
					var_349_5.radialBlurGradient = 1
					var_349_5.radialBlurIntensity = 1
				end
			end

			local var_349_6 = 0

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				arg_346_1.mask_.enabled = true
				arg_346_1.mask_.raycastTarget = true

				arg_346_1:SetGaussion(false)
			end

			local var_349_7 = 1

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_7 then
				local var_349_8 = Color.New(0, 0, 0)

				var_349_8.a = Mathf.Lerp(0, 1, (arg_346_1.time_ - var_349_6) / var_349_7)
				arg_346_1.mask_.color = var_349_8
			end

			if arg_346_1.time_ >= var_349_6 + var_349_7 and arg_346_1.time_ < var_349_6 + var_349_7 + arg_349_0 then
				local var_349_9 = Color.New(0, 0, 0)

				var_349_9.a = 1
				arg_346_1.mask_.color = var_349_9
			end

			local var_349_10 = 1

			if 1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_10 + arg_349_0 then
				arg_346_1.mask_.enabled = true
				arg_346_1.mask_.raycastTarget = true

				arg_346_1:SetGaussion(false)
			end

			local var_349_11 = 1

			if var_349_10 <= arg_346_1.time_ and arg_346_1.time_ < var_349_10 + var_349_11 then
				local var_349_12 = Color.New(0, 0, 0)

				var_349_12.a = Mathf.Lerp(1, 0, (arg_346_1.time_ - var_349_10) / var_349_11)
				arg_346_1.mask_.color = var_349_12
			end

			if arg_346_1.time_ >= var_349_10 + var_349_11 and arg_346_1.time_ < var_349_10 + var_349_11 + arg_349_0 then
				local var_349_13 = Color.New(0, 0, 0)

				arg_346_1.mask_.enabled = false
				var_349_13.a = 0
				arg_346_1.mask_.color = var_349_13
			end

			if 0.133333333333333 < arg_346_1.time_ and arg_346_1.time_ <= 0.133333333333333 + arg_349_0 then
				arg_346_1:AudioAction("play", "effect", "ui_skip", "ui_bgm_33", "")
			end

			local var_349_15 = 1.43333333333333
			local var_349_16 = 1.5

			if 1.43333333333333 < arg_346_1.time_ and arg_346_1.time_ <= var_349_15 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_17 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(936041083).content)

				arg_346_1.text_.text = var_349_17

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_19 = 60 <= 0 and var_349_16 or var_349_16 * (utf8.len(var_349_17) / 60)

				if (60 <= 0 and var_349_16 or var_349_16 * (utf8.len(var_349_17) / 60)) > 0 and var_349_16 < var_349_19 then
					arg_346_1.talkMaxDuration = var_349_19

					if var_349_19 + var_349_15 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_19 + var_349_15
					end
				end

				arg_346_1.text_.text = var_349_17
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_20 = math.max(var_349_16, arg_346_1.talkMaxDuration)

			if var_349_15 <= arg_346_1.time_ and arg_346_1.time_ < var_349_15 + var_349_20 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_15) / var_349_20

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_15 + var_349_20 and arg_346_1.time_ < var_349_15 + var_349_20 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93601",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.06666666666667,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 1),
					endPos = Vector3.New(0, 1, 0.5),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play936041084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 936041084
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play936041085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 1.125

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_1 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(936041084).content)

				arg_350_1.text_.text = var_353_1

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_3 = 45 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 45)

				if (45 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 45)) > 0 and var_353_0 < var_353_3 then
					arg_350_1.talkMaxDuration = var_353_3

					if var_353_3 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_3 + 0
					end
				end

				arg_350_1.text_.text = var_353_1
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_4 = math.max(var_353_0, arg_350_1.talkMaxDuration)

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - 0) / var_353_4

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play936041085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 936041085
		arg_354_1.duration_ = 9

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play936041086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if arg_354_1.bgs_.STblack == nil then
				local var_357_0 = Object.Instantiate(arg_354_1.paintGo_)

				var_357_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_357_0.name = "STblack"
				var_357_0.transform.parent = arg_354_1.stage_.transform
				var_357_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_354_1.bgs_.STblack = var_357_0
			end

			if 2 < arg_354_1.time_ and arg_354_1.time_ <= 2 + arg_357_0 then
				local var_357_1 = arg_354_1.bgs_.STblack

				arg_354_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_357_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_357_2 = var_357_1:GetComponent("SpriteRenderer")

				if var_357_2 and var_357_2.sprite then
					local var_357_3 = 2 * (var_357_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_357_1.transform.localScale = Vector3.New(var_357_3 / var_357_2.sprite.bounds.size.y < var_357_3 * manager.ui.mainCameraCom_.aspect / var_357_2.sprite.bounds.size.x and var_357_3 * manager.ui.mainCameraCom_.aspect / var_357_2.sprite.bounds.size.x or var_357_3 / var_357_2.sprite.bounds.size.y, var_357_3 / var_357_2.sprite.bounds.size.y < var_357_3 * manager.ui.mainCameraCom_.aspect / var_357_2.sprite.bounds.size.x and var_357_3 * manager.ui.mainCameraCom_.aspect / var_357_2.sprite.bounds.size.x or var_357_3 / var_357_2.sprite.bounds.size.y, 0)
				end

				for iter_357_0, iter_357_1 in pairs(arg_354_1.bgs_) do
					if iter_357_0 ~= "STblack" then
						iter_357_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_357_4 = 4

			if 4 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				arg_354_1.allBtn_.enabled = false
			end

			if arg_354_1.time_ >= var_357_4 + 0.3 and arg_354_1.time_ < var_357_4 + 0.3 + arg_357_0 then
				arg_354_1.allBtn_.enabled = true
			end

			local var_357_5 = 0

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_5 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_6 = 2

			if var_357_5 <= arg_354_1.time_ and arg_354_1.time_ < var_357_5 + var_357_6 then
				local var_357_7 = Color.New(1, 1, 1)

				var_357_7.a = Mathf.Lerp(0, 1, (arg_354_1.time_ - var_357_5) / var_357_6)
				arg_354_1.mask_.color = var_357_7
			end

			if arg_354_1.time_ >= var_357_5 + var_357_6 and arg_354_1.time_ < var_357_5 + var_357_6 + arg_357_0 then
				local var_357_8 = Color.New(1, 1, 1)

				var_357_8.a = 1
				arg_354_1.mask_.color = var_357_8
			end

			local var_357_9 = 2

			if 2 < arg_354_1.time_ and arg_354_1.time_ <= var_357_9 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_10 = 2

			if var_357_9 <= arg_354_1.time_ and arg_354_1.time_ < var_357_9 + var_357_10 then
				local var_357_11 = Color.New(1, 1, 1)

				var_357_11.a = Mathf.Lerp(1, 0, (arg_354_1.time_ - var_357_9) / var_357_10)
				arg_354_1.mask_.color = var_357_11
			end

			if arg_354_1.time_ >= var_357_9 + var_357_10 and arg_354_1.time_ < var_357_9 + var_357_10 + arg_357_0 then
				local var_357_12 = Color.New(1, 1, 1)

				arg_354_1.mask_.enabled = false
				var_357_12.a = 0
				arg_354_1.mask_.color = var_357_12
			end

			if arg_354_1.frameCnt_ <= 1 then
				arg_354_1.dialog_:SetActive(false)
			end

			local var_357_13 = 4
			local var_357_14 = 0.575

			if 4 < arg_354_1.time_ and arg_354_1.time_ <= var_357_13 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0

				arg_354_1.dialog_:SetActive(true)

				arg_354_1.dialogCg_.alpha = 0

				local var_357_15 = LeanTween.value(arg_354_1.dialog_, 0, 1, 0.3)

				var_357_15:setOnUpdate(LuaHelper.FloatAction(function(arg_358_0)
					arg_354_1.dialogCg_.alpha = arg_358_0
				end))
				var_357_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_354_1.dialog_)
					var_357_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_354_1.duration_ = arg_354_1.duration_ + 0.3

				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_16 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(936041085).content)

				arg_354_1.text_.text = var_357_16

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_18 = 23 <= 0 and var_357_14 or var_357_14 * (utf8.len(var_357_16) / 23)

				if (23 <= 0 and var_357_14 or var_357_14 * (utf8.len(var_357_16) / 23)) > 0 and var_357_14 < var_357_18 then
					arg_354_1.talkMaxDuration = var_357_18
					var_357_13 = var_357_13 + 0.3

					if var_357_18 + var_357_13 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_18 + var_357_13
					end
				end

				arg_354_1.text_.text = var_357_16
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_19 = var_357_13 + 0.3
			local var_357_20 = math.max(var_357_14, arg_354_1.talkMaxDuration)

			if var_357_13 + 0.3 <= arg_354_1.time_ and arg_354_1.time_ < var_357_19 + var_357_20 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_19) / var_357_20

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_19 + var_357_20 and arg_354_1.time_ < var_357_19 + var_357_20 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play936041086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 936041086
		arg_360_1.duration_ = 6.73

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play936041087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 1 < arg_360_1.time_ and arg_360_1.time_ <= 1 + arg_363_0 then
				arg_360_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_363_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_360_1.bgmTxt_.text ~= var_363_2 and arg_360_1.bgmTxt_.text ~= "" then
						if arg_360_1.bgmTxt2_.text ~= "" then
							arg_360_1.bgmTxt_.text = arg_360_1.bgmTxt2_.text
						end

						arg_360_1.bgmTxt2_.text = var_363_2

						arg_360_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_360_1.bgmTxt_.text = var_363_2
						arg_360_1.bgmTxt2_.text = var_363_2
					end

					if arg_360_1.bgmTimer then
						arg_360_1.bgmTimer:Stop()

						arg_360_1.bgmTimer = nil
					end

					if arg_360_1.settingData.show_music_name == 1 then
						arg_360_1.musicController:SetSelectedState("show")
						arg_360_1.musicAnimator_:Play("open", 0, 0)

						if arg_360_1.settingData.music_time ~= 0 then
							arg_360_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_360_1.settingData.music_time), function()
								if arg_360_1 == nil or isNil(arg_360_1.bgmTxt_) then
									return
								end

								arg_360_1.musicController:SetSelectedState("hide")
								arg_360_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_363_3 = 0
			local var_363_4 = 0.325

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_3 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1044")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_5 = arg_360_1:GetWordFromCfg(936041086)
				local var_363_6 = arg_360_1:FormatText(var_363_5.content)

				arg_360_1.text_.text = var_363_6

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_8 = 13 <= 0 and var_363_4 or var_363_4 * (utf8.len(var_363_6) / 13)

				if (13 <= 0 and var_363_4 or var_363_4 * (utf8.len(var_363_6) / 13)) > 0 and var_363_4 < var_363_8 then
					arg_360_1.talkMaxDuration = var_363_8

					if var_363_8 + var_363_3 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_3
					end
				end

				arg_360_1.text_.text = var_363_6
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041086", "story_v_side_old_936041.awb") ~= 0 then
					local var_363_9 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041086", "story_v_side_old_936041.awb") / 1000

					if var_363_9 + var_363_3 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_9 + var_363_3
					end

					if var_363_5.prefab_name ~= "" and arg_360_1.actors_[var_363_5.prefab_name] ~= nil then
						local var_363_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_5.prefab_name].transform, "story_v_side_old_936041", "936041086", "story_v_side_old_936041.awb")

						arg_360_1:RecordAudio("936041086", var_363_10)
						arg_360_1:RecordAudio("936041086", var_363_10)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041086", "story_v_side_old_936041.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041086", "story_v_side_old_936041.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_11 = math.max(var_363_4, arg_360_1.talkMaxDuration)

			if var_363_3 <= arg_360_1.time_ and arg_360_1.time_ < var_363_3 + var_363_11 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_3) / var_363_11

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_3 + var_363_11 and arg_360_1.time_ < var_363_3 + var_363_11 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play936041087 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 936041087
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play936041088(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos104402ui_story = arg_365_1.actors_["104402ui_story"].transform.localPosition

				local var_368_0 = GameObjectTools.GetOrAddComponent(arg_365_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_368_0 then
					var_368_0:EnableDynamicBone(false)
				end
			end

			local var_368_1 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_1 then
				arg_365_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_365_1.time_ - 0) / var_368_1)
				arg_365_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["104402ui_story"].transform.position).z)
				arg_365_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["104402ui_story"].transform.localEulerAngles = arg_365_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_1 and arg_365_1.time_ < 0 + var_368_1 + arg_368_0 then
				arg_365_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_365_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["104402ui_story"].transform.position).z)
				arg_365_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["104402ui_story"].transform.localEulerAngles = arg_365_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_368_2 = GameObjectTools.GetOrAddComponent(arg_365_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_368_2 then
					var_368_2:EnableDynamicBone(true)
				end
			end

			local var_368_3 = arg_365_1.actors_["104402ui_story"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_3) and arg_365_1.var_.characterEffect104402ui_story == nil then
				arg_365_1.var_.characterEffect104402ui_story = var_368_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_4 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 and not isNil(var_368_3) then
				if arg_365_1.var_.characterEffect104402ui_story and not isNil(var_368_3) then
					arg_365_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_365_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_365_1.time_ - 0) / var_368_4)
				end
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 and not isNil(var_368_3) and arg_365_1.var_.characterEffect104402ui_story then
				arg_365_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_365_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_368_5 = 0
			local var_368_6 = 0.85

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_5 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_7 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(936041087).content)

				arg_365_1.text_.text = var_368_7

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_9 = 34 <= 0 and var_368_6 or var_368_6 * (utf8.len(var_368_7) / 34)

				if (34 <= 0 and var_368_6 or var_368_6 * (utf8.len(var_368_7) / 34)) > 0 and var_368_6 < var_368_9 then
					arg_365_1.talkMaxDuration = var_368_9

					if var_368_9 + var_368_5 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_9 + var_368_5
					end
				end

				arg_365_1.text_.text = var_368_7
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_6, arg_365_1.talkMaxDuration)

			if var_368_5 <= arg_365_1.time_ and arg_365_1.time_ < var_368_5 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_5) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_5 + var_368_10 and arg_365_1.time_ < var_368_5 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play936041088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 936041088
		arg_369_1.duration_ = 7

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play936041089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				local var_372_0 = arg_369_1.bgs_.X206_g

				arg_369_1.bgs_.X206_g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_372_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_372_1 = var_372_0:GetComponent("SpriteRenderer")

				if var_372_1 and var_372_1.sprite then
					local var_372_2 = 2 * (var_372_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_372_0.transform.localScale = Vector3.New(var_372_2 / var_372_1.sprite.bounds.size.y < var_372_2 * manager.ui.mainCameraCom_.aspect / var_372_1.sprite.bounds.size.x and var_372_2 * manager.ui.mainCameraCom_.aspect / var_372_1.sprite.bounds.size.x or var_372_2 / var_372_1.sprite.bounds.size.y, var_372_2 / var_372_1.sprite.bounds.size.y < var_372_2 * manager.ui.mainCameraCom_.aspect / var_372_1.sprite.bounds.size.x and var_372_2 * manager.ui.mainCameraCom_.aspect / var_372_1.sprite.bounds.size.x or var_372_2 / var_372_1.sprite.bounds.size.y, 0)
				end

				for iter_372_0, iter_372_1 in pairs(arg_369_1.bgs_) do
					if iter_372_0 ~= "X206_g" then
						iter_372_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_372_3 = 2

			if 2 < arg_369_1.time_ and arg_369_1.time_ <= var_372_3 + arg_372_0 then
				arg_369_1.allBtn_.enabled = false
			end

			if arg_369_1.time_ >= var_372_3 + 0.3 and arg_369_1.time_ < var_372_3 + 0.3 + arg_372_0 then
				arg_369_1.allBtn_.enabled = true
			end

			local var_372_4 = 0

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_4 + arg_372_0 then
				arg_369_1.mask_.enabled = true
				arg_369_1.mask_.raycastTarget = true

				arg_369_1:SetGaussion(false)
			end

			local var_372_5 = 2

			if var_372_4 <= arg_369_1.time_ and arg_369_1.time_ < var_372_4 + var_372_5 then
				local var_372_6 = Color.New(0, 0, 0)

				var_372_6.a = Mathf.Lerp(1, 0, (arg_369_1.time_ - var_372_4) / var_372_5)
				arg_369_1.mask_.color = var_372_6
			end

			if arg_369_1.time_ >= var_372_4 + var_372_5 and arg_369_1.time_ < var_372_4 + var_372_5 + arg_372_0 then
				local var_372_7 = Color.New(0, 0, 0)

				arg_369_1.mask_.enabled = false
				var_372_7.a = 0
				arg_369_1.mask_.color = var_372_7
			end

			local var_372_8

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				local var_372_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_372_9 then
					var_372_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_372_9.radialBlurScale = 0
					var_372_9.radialBlurGradient = 1
					var_372_9.radialBlurIntensity = 1

					if var_372_8 then
						var_372_9.radialBlurTarget = var_372_8.transform
					end
				end
			end

			local var_372_10 = 0.166666666666667

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_10 then
				local var_372_11 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_372_11 then
					var_372_11.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_372_11.radialBlurScale = Mathf.Lerp(0, 0, (arg_369_1.time_ - 0) / var_372_10)
					var_372_11.radialBlurGradient = Mathf.Lerp(1, 1, (arg_369_1.time_ - 0) / var_372_10)
					var_372_11.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_369_1.time_ - 0) / var_372_10)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_10 and arg_369_1.time_ < 0 + var_372_10 + arg_372_0 then
				local var_372_12 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_372_12 then
					var_372_12.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_372_12.radialBlurScale = 0
					var_372_12.radialBlurGradient = 1
					var_372_12.radialBlurIntensity = 1
				end
			end

			if 0.166666666666667 < arg_369_1.time_ and arg_369_1.time_ <= 0.166666666666667 + arg_372_0 then
				arg_369_1:AudioAction("play", "music", "bgm_activity_5_0_scene_104402_room", "bgm_activity_5_0_scene_104402_room", "bgm_activity_5_0_scene_104402_room.awb")

				local var_372_15 = manager.audio:GetAudioName("bgm_activity_5_0_scene_104402_room", "bgm_activity_5_0_scene_104402_room")

				if "" ~= "" then
					if arg_369_1.bgmTxt_.text ~= var_372_15 and arg_369_1.bgmTxt_.text ~= "" then
						if arg_369_1.bgmTxt2_.text ~= "" then
							arg_369_1.bgmTxt_.text = arg_369_1.bgmTxt2_.text
						end

						arg_369_1.bgmTxt2_.text = var_372_15

						arg_369_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_369_1.bgmTxt_.text = var_372_15
						arg_369_1.bgmTxt2_.text = var_372_15
					end

					if arg_369_1.bgmTimer then
						arg_369_1.bgmTimer:Stop()

						arg_369_1.bgmTimer = nil
					end

					if arg_369_1.settingData.show_music_name == 1 then
						arg_369_1.musicController:SetSelectedState("show")
						arg_369_1.musicAnimator_:Play("open", 0, 0)

						if arg_369_1.settingData.music_time ~= 0 then
							arg_369_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_369_1.settingData.music_time), function()
								if arg_369_1 == nil or isNil(arg_369_1.bgmTxt_) then
									return
								end

								arg_369_1.musicController:SetSelectedState("hide")
								arg_369_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.133333333333333 < arg_369_1.time_ and arg_369_1.time_ <= 0.133333333333333 + arg_372_0 then
				arg_369_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 0.034000001847744 < arg_369_1.time_ and arg_369_1.time_ <= 0.034000001847744 + arg_372_0 then
				arg_369_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_beach_night", "")
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:AudioAction("play", "effect", "ui_skip", "ui_bgm_100", "")
			end

			if arg_369_1.frameCnt_ <= 1 then
				arg_369_1.dialog_:SetActive(false)
			end

			local var_372_19 = 2
			local var_372_20 = 0.6

			if 2 < arg_369_1.time_ and arg_369_1.time_ <= var_372_19 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0

				arg_369_1.dialog_:SetActive(true)

				arg_369_1.dialogCg_.alpha = 0

				local var_372_21 = LeanTween.value(arg_369_1.dialog_, 0, 1, 0.3)

				var_372_21:setOnUpdate(LuaHelper.FloatAction(function(arg_374_0)
					arg_369_1.dialogCg_.alpha = arg_374_0
				end))
				var_372_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_369_1.dialog_)
					var_372_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_369_1.duration_ = arg_369_1.duration_ + 0.3

				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_22 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(936041088).content)

				arg_369_1.text_.text = var_372_22

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_24 = 24 <= 0 and var_372_20 or var_372_20 * (utf8.len(var_372_22) / 24)

				if (24 <= 0 and var_372_20 or var_372_20 * (utf8.len(var_372_22) / 24)) > 0 and var_372_20 < var_372_24 then
					arg_369_1.talkMaxDuration = var_372_24
					var_372_19 = var_372_19 + 0.3

					if var_372_24 + var_372_19 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_24 + var_372_19
					end
				end

				arg_369_1.text_.text = var_372_22
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_25 = var_372_19 + 0.3
			local var_372_26 = math.max(var_372_20, arg_369_1.talkMaxDuration)

			if var_372_19 + 0.3 <= arg_369_1.time_ and arg_369_1.time_ < var_372_25 + var_372_26 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_25) / var_372_26

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_25 + var_372_26 and arg_369_1.time_ < var_372_25 + var_372_26 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play936041089 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 936041089
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play936041090(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 1.025

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_1 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(936041089).content)

				arg_376_1.text_.text = var_379_1

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_3 = 41 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_1) / 41)

				if (41 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_1) / 41)) > 0 and var_379_0 < var_379_3 then
					arg_376_1.talkMaxDuration = var_379_3

					if var_379_3 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_3 + 0
					end
				end

				arg_376_1.text_.text = var_379_1
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_4 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_4 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_4

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_4 and arg_376_1.time_ < 0 + var_379_4 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play936041090 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 936041090
		arg_380_1.duration_ = 8.57

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play936041091(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos614801ui_story = arg_380_1.actors_["614801ui_story"].transform.localPosition

				local var_383_0 = GameObjectTools.GetOrAddComponent(arg_380_1.actors_["614801ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_383_0 then
					var_383_0:EnableDynamicBone(false)
				end
			end

			local var_383_1 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_1 then
				arg_380_1.actors_["614801ui_story"].transform.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos614801ui_story, Vector3.New(-0.7, -0.985, -6), (arg_380_1.time_ - 0) / var_383_1)
				arg_380_1.actors_["614801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["614801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["614801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["614801ui_story"].transform.position).z)
				arg_380_1.actors_["614801ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["614801ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["614801ui_story"].transform.localEulerAngles = arg_380_1.actors_["614801ui_story"].transform.localEulerAngles
			end

			if arg_380_1.time_ >= 0 + var_383_1 and arg_380_1.time_ < 0 + var_383_1 + arg_383_0 then
				arg_380_1.actors_["614801ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_380_1.actors_["614801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["614801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["614801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["614801ui_story"].transform.position).z)
				arg_380_1.actors_["614801ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["614801ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["614801ui_story"].transform.localEulerAngles = arg_380_1.actors_["614801ui_story"].transform.localEulerAngles

				local var_383_2 = GameObjectTools.GetOrAddComponent(arg_380_1.actors_["614801ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_383_2 then
					var_383_2:EnableDynamicBone(true)
				end
			end

			local var_383_3 = arg_380_1.actors_["614801ui_story"]

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(var_383_3) and arg_380_1.var_.characterEffect614801ui_story == nil then
				arg_380_1.var_.characterEffect614801ui_story = var_383_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_4 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_4 and not isNil(var_383_3) then
				if arg_380_1.var_.characterEffect614801ui_story and not isNil(var_383_3) then
					arg_380_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= 0 + var_383_4 and arg_380_1.time_ < 0 + var_383_4 + arg_383_0 and not isNil(var_383_3) and arg_380_1.var_.characterEffect614801ui_story then
				arg_380_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_383_6 = 0
			local var_383_7 = 1.025

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_6 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_8 = arg_380_1:GetWordFromCfg(936041090)
				local var_383_9 = arg_380_1:FormatText(var_383_8.content)

				arg_380_1.text_.text = var_383_9

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_11 = 41 <= 0 and var_383_7 or var_383_7 * (utf8.len(var_383_9) / 41)

				if (41 <= 0 and var_383_7 or var_383_7 * (utf8.len(var_383_9) / 41)) > 0 and var_383_7 < var_383_11 then
					arg_380_1.talkMaxDuration = var_383_11

					if var_383_11 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_11 + var_383_6
					end
				end

				arg_380_1.text_.text = var_383_9
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041090", "story_v_side_old_936041.awb") ~= 0 then
					local var_383_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041090", "story_v_side_old_936041.awb") / 1000

					if var_383_12 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_12 + var_383_6
					end

					if var_383_8.prefab_name ~= "" and arg_380_1.actors_[var_383_8.prefab_name] ~= nil then
						local var_383_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_8.prefab_name].transform, "story_v_side_old_936041", "936041090", "story_v_side_old_936041.awb")

						arg_380_1:RecordAudio("936041090", var_383_13)
						arg_380_1:RecordAudio("936041090", var_383_13)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041090", "story_v_side_old_936041.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041090", "story_v_side_old_936041.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_14 = math.max(var_383_7, arg_380_1.talkMaxDuration)

			if var_383_6 <= arg_380_1.time_ and arg_380_1.time_ < var_383_6 + var_383_14 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_6) / var_383_14

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_6 + var_383_14 and arg_380_1.time_ < var_383_6 + var_383_14 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play936041091 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 936041091
		arg_384_1.duration_ = 2

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play936041092(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos104402ui_story = arg_384_1.actors_["104402ui_story"].transform.localPosition

				local var_387_0 = GameObjectTools.GetOrAddComponent(arg_384_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_387_0 then
					var_387_0:EnableDynamicBone(false)
				end
			end

			local var_387_1 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_1 then
				arg_384_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos104402ui_story, Vector3.New(0.7, -1, -5.93), (arg_384_1.time_ - 0) / var_387_1)
				arg_384_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["104402ui_story"].transform.position).z)
				arg_384_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["104402ui_story"].transform.localEulerAngles = arg_384_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_384_1.time_ >= 0 + var_387_1 and arg_384_1.time_ < 0 + var_387_1 + arg_387_0 then
				arg_384_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_384_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["104402ui_story"].transform.position).z)
				arg_384_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["104402ui_story"].transform.localEulerAngles = arg_384_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_387_2 = GameObjectTools.GetOrAddComponent(arg_384_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_387_2 then
					var_387_2:EnableDynamicBone(true)
				end
			end

			local var_387_3 = arg_384_1.actors_["104402ui_story"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_3) and arg_384_1.var_.characterEffect104402ui_story == nil then
				arg_384_1.var_.characterEffect104402ui_story = var_387_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_4 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_4 and not isNil(var_387_3) then
				if arg_384_1.var_.characterEffect104402ui_story and not isNil(var_387_3) then
					arg_384_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= 0 + var_387_4 and arg_384_1.time_ < 0 + var_387_4 + arg_387_0 and not isNil(var_387_3) and arg_384_1.var_.characterEffect104402ui_story then
				arg_384_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_387_6 = arg_384_1.actors_["614801ui_story"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_6) and arg_384_1.var_.characterEffect614801ui_story == nil then
				arg_384_1.var_.characterEffect614801ui_story = var_387_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_7 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_7 and not isNil(var_387_6) then
				if arg_384_1.var_.characterEffect614801ui_story and not isNil(var_387_6) then
					arg_384_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_384_1.var_.characterEffect614801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_384_1.time_ - 0) / var_387_7)
				end
			end

			if arg_384_1.time_ >= 0 + var_387_7 and arg_384_1.time_ < 0 + var_387_7 + arg_387_0 and not isNil(var_387_6) and arg_384_1.var_.characterEffect614801ui_story then
				arg_384_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_384_1.var_.characterEffect614801ui_story.fillRatio = 0.5
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_387_8 = 0
			local var_387_9 = 0.1

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_8 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_10 = arg_384_1:GetWordFromCfg(936041091)
				local var_387_11 = arg_384_1:FormatText(var_387_10.content)

				arg_384_1.text_.text = var_387_11

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_13 = 4 <= 0 and var_387_9 or var_387_9 * (utf8.len(var_387_11) / 4)

				if (4 <= 0 and var_387_9 or var_387_9 * (utf8.len(var_387_11) / 4)) > 0 and var_387_9 < var_387_13 then
					arg_384_1.talkMaxDuration = var_387_13

					if var_387_13 + var_387_8 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_13 + var_387_8
					end
				end

				arg_384_1.text_.text = var_387_11
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041091", "story_v_side_old_936041.awb") ~= 0 then
					local var_387_14 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041091", "story_v_side_old_936041.awb") / 1000

					if var_387_14 + var_387_8 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_14 + var_387_8
					end

					if var_387_10.prefab_name ~= "" and arg_384_1.actors_[var_387_10.prefab_name] ~= nil then
						local var_387_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_10.prefab_name].transform, "story_v_side_old_936041", "936041091", "story_v_side_old_936041.awb")

						arg_384_1:RecordAudio("936041091", var_387_15)
						arg_384_1:RecordAudio("936041091", var_387_15)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041091", "story_v_side_old_936041.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041091", "story_v_side_old_936041.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_16 = math.max(var_387_9, arg_384_1.talkMaxDuration)

			if var_387_8 <= arg_384_1.time_ and arg_384_1.time_ < var_387_8 + var_387_16 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_8) / var_387_16

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_8 + var_387_16 and arg_384_1.time_ < var_387_8 + var_387_16 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play936041092 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 936041092
		arg_388_1.duration_ = 6.17

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play936041093(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["104402ui_story"]) and arg_388_1.var_.characterEffect104402ui_story == nil then
				arg_388_1.var_.characterEffect104402ui_story = arg_388_1.actors_["104402ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_0 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["104402ui_story"]) then
				if arg_388_1.var_.characterEffect104402ui_story and not isNil(arg_388_1.actors_["104402ui_story"]) then
					arg_388_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_388_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_388_1.time_ - 0) / var_391_0)
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["104402ui_story"]) and arg_388_1.var_.characterEffect104402ui_story then
				arg_388_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_388_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_391_1 = arg_388_1.actors_["614801ui_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect614801ui_story == nil then
				arg_388_1.var_.characterEffect614801ui_story = var_391_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_2 and not isNil(var_391_1) then
				if arg_388_1.var_.characterEffect614801ui_story and not isNil(var_391_1) then
					arg_388_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= 0 + var_391_2 and arg_388_1.time_ < 0 + var_391_2 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect614801ui_story then
				arg_388_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			local var_391_4 = 0
			local var_391_5 = 0.5

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_6 = arg_388_1:GetWordFromCfg(936041092)
				local var_391_7 = arg_388_1:FormatText(var_391_6.content)

				arg_388_1.text_.text = var_391_7

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_9 = 20 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 20)

				if (20 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 20)) > 0 and var_391_5 < var_391_9 then
					arg_388_1.talkMaxDuration = var_391_9

					if var_391_9 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_9 + var_391_4
					end
				end

				arg_388_1.text_.text = var_391_7
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041092", "story_v_side_old_936041.awb") ~= 0 then
					local var_391_10 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041092", "story_v_side_old_936041.awb") / 1000

					if var_391_10 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_4
					end

					if var_391_6.prefab_name ~= "" and arg_388_1.actors_[var_391_6.prefab_name] ~= nil then
						local var_391_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_6.prefab_name].transform, "story_v_side_old_936041", "936041092", "story_v_side_old_936041.awb")

						arg_388_1:RecordAudio("936041092", var_391_11)
						arg_388_1:RecordAudio("936041092", var_391_11)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041092", "story_v_side_old_936041.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041092", "story_v_side_old_936041.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_12 = math.max(var_391_5, arg_388_1.talkMaxDuration)

			if var_391_4 <= arg_388_1.time_ and arg_388_1.time_ < var_391_4 + var_391_12 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_4) / var_391_12

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_4 + var_391_12 and arg_388_1.time_ < var_391_4 + var_391_12 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play936041093 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 936041093
		arg_392_1.duration_ = 5.87

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play936041094(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos104402ui_story = arg_392_1.actors_["104402ui_story"].transform.localPosition

				local var_395_0 = GameObjectTools.GetOrAddComponent(arg_392_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_395_0 then
					var_395_0:EnableDynamicBone(false)
				end
			end

			local var_395_1 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_1 then
				arg_392_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos104402ui_story, Vector3.New(0.7, -1, -5.93), (arg_392_1.time_ - 0) / var_395_1)
				arg_392_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["104402ui_story"].transform.position).z)
				arg_392_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["104402ui_story"].transform.localEulerAngles = arg_392_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_392_1.time_ >= 0 + var_395_1 and arg_392_1.time_ < 0 + var_395_1 + arg_395_0 then
				arg_392_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_392_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["104402ui_story"].transform.position).z)
				arg_392_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["104402ui_story"].transform.localEulerAngles = arg_392_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_395_2 = GameObjectTools.GetOrAddComponent(arg_392_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_395_2 then
					var_395_2:EnableDynamicBone(true)
				end
			end

			local var_395_3 = arg_392_1.actors_["104402ui_story"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_3) and arg_392_1.var_.characterEffect104402ui_story == nil then
				arg_392_1.var_.characterEffect104402ui_story = var_395_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_4 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_4 and not isNil(var_395_3) then
				if arg_392_1.var_.characterEffect104402ui_story and not isNil(var_395_3) then
					arg_392_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= 0 + var_395_4 and arg_392_1.time_ < 0 + var_395_4 + arg_395_0 and not isNil(var_395_3) and arg_392_1.var_.characterEffect104402ui_story then
				arg_392_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_395_6 = arg_392_1.actors_["614801ui_story"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_6) and arg_392_1.var_.characterEffect614801ui_story == nil then
				arg_392_1.var_.characterEffect614801ui_story = var_395_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_7 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_7 and not isNil(var_395_6) then
				if arg_392_1.var_.characterEffect614801ui_story and not isNil(var_395_6) then
					arg_392_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_392_1.var_.characterEffect614801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_392_1.time_ - 0) / var_395_7)
				end
			end

			if arg_392_1.time_ >= 0 + var_395_7 and arg_392_1.time_ < 0 + var_395_7 + arg_395_0 and not isNil(var_395_6) and arg_392_1.var_.characterEffect614801ui_story then
				arg_392_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_392_1.var_.characterEffect614801ui_story.fillRatio = 0.5
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402actionlink/104402action435")
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_395_8 = 0
			local var_395_9 = 0.725

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_8 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_10 = arg_392_1:GetWordFromCfg(936041093)
				local var_395_11 = arg_392_1:FormatText(var_395_10.content)

				arg_392_1.text_.text = var_395_11

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_13 = 29 <= 0 and var_395_9 or var_395_9 * (utf8.len(var_395_11) / 29)

				if (29 <= 0 and var_395_9 or var_395_9 * (utf8.len(var_395_11) / 29)) > 0 and var_395_9 < var_395_13 then
					arg_392_1.talkMaxDuration = var_395_13

					if var_395_13 + var_395_8 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_13 + var_395_8
					end
				end

				arg_392_1.text_.text = var_395_11
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041093", "story_v_side_old_936041.awb") ~= 0 then
					local var_395_14 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041093", "story_v_side_old_936041.awb") / 1000

					if var_395_14 + var_395_8 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_14 + var_395_8
					end

					if var_395_10.prefab_name ~= "" and arg_392_1.actors_[var_395_10.prefab_name] ~= nil then
						local var_395_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_10.prefab_name].transform, "story_v_side_old_936041", "936041093", "story_v_side_old_936041.awb")

						arg_392_1:RecordAudio("936041093", var_395_15)
						arg_392_1:RecordAudio("936041093", var_395_15)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041093", "story_v_side_old_936041.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041093", "story_v_side_old_936041.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_16 = math.max(var_395_9, arg_392_1.talkMaxDuration)

			if var_395_8 <= arg_392_1.time_ and arg_392_1.time_ < var_395_8 + var_395_16 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_8) / var_395_16

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_8 + var_395_16 and arg_392_1.time_ < var_395_8 + var_395_16 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play936041094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 936041094
		arg_396_1.duration_ = 2

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play936041095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos105401ui_story = arg_396_1.actors_["105401ui_story"].transform.localPosition

				local var_399_0 = GameObjectTools.GetOrAddComponent(arg_396_1.actors_["105401ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_399_0 then
					var_399_0:EnableDynamicBone(false)
				end
			end

			local var_399_1 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_1 then
				arg_396_1.actors_["105401ui_story"].transform.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos105401ui_story, Vector3.New(0.7, -0.985, -6), (arg_396_1.time_ - 0) / var_399_1)
				arg_396_1.actors_["105401ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["105401ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["105401ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["105401ui_story"].transform.position).z)
				arg_396_1.actors_["105401ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["105401ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["105401ui_story"].transform.localEulerAngles = arg_396_1.actors_["105401ui_story"].transform.localEulerAngles
			end

			if arg_396_1.time_ >= 0 + var_399_1 and arg_396_1.time_ < 0 + var_399_1 + arg_399_0 then
				arg_396_1.actors_["105401ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_396_1.actors_["105401ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["105401ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["105401ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["105401ui_story"].transform.position).z)
				arg_396_1.actors_["105401ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["105401ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["105401ui_story"].transform.localEulerAngles = arg_396_1.actors_["105401ui_story"].transform.localEulerAngles

				local var_399_2 = GameObjectTools.GetOrAddComponent(arg_396_1.actors_["105401ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_399_2 then
					var_399_2:EnableDynamicBone(true)
				end
			end

			local var_399_3 = arg_396_1.actors_["104402ui_story"].transform

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos104402ui_story = var_399_3.localPosition

				local var_399_4 = GameObjectTools.GetOrAddComponent(var_399_3.gameObject, typeof(DynamicBoneHelper))

				if var_399_4 then
					var_399_4:EnableDynamicBone(false)
				end
			end

			local var_399_5 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_5 then
				var_399_3.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_396_1.time_ - 0) / var_399_5)
				var_399_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_399_3.position).x, (manager.ui.mainCamera.transform.position - var_399_3.position).y, (manager.ui.mainCamera.transform.position - var_399_3.position).z)
				var_399_3.localEulerAngles.z = 0
				var_399_3.localEulerAngles.x = 0
				var_399_3.localEulerAngles = var_399_3.localEulerAngles
			end

			if arg_396_1.time_ >= 0 + var_399_5 and arg_396_1.time_ < 0 + var_399_5 + arg_399_0 then
				var_399_3.localPosition = Vector3.New(0, 100, 0)
				var_399_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_399_3.position).x, (manager.ui.mainCamera.transform.position - var_399_3.position).y, (manager.ui.mainCamera.transform.position - var_399_3.position).z)
				var_399_3.localEulerAngles.z = 0
				var_399_3.localEulerAngles.x = 0
				var_399_3.localEulerAngles = var_399_3.localEulerAngles

				local var_399_6 = GameObjectTools.GetOrAddComponent(var_399_3.gameObject, typeof(DynamicBoneHelper))

				if var_399_6 then
					var_399_6:EnableDynamicBone(true)
				end
			end

			local var_399_7 = arg_396_1.actors_["105401ui_story"]

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(var_399_7) and arg_396_1.var_.characterEffect105401ui_story == nil then
				arg_396_1.var_.characterEffect105401ui_story = var_399_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_8 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_8 and not isNil(var_399_7) then
				if arg_396_1.var_.characterEffect105401ui_story and not isNil(var_399_7) then
					arg_396_1.var_.characterEffect105401ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= 0 + var_399_8 and arg_396_1.time_ < 0 + var_399_8 + arg_399_0 and not isNil(var_399_7) and arg_396_1.var_.characterEffect105401ui_story then
				arg_396_1.var_.characterEffect105401ui_story.fillFlat = false
			end

			local var_399_10 = arg_396_1.actors_["104402ui_story"]

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(var_399_10) and arg_396_1.var_.characterEffect104402ui_story == nil then
				arg_396_1.var_.characterEffect104402ui_story = var_399_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_11 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_11 and not isNil(var_399_10) then
				if arg_396_1.var_.characterEffect104402ui_story and not isNil(var_399_10) then
					arg_396_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_396_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_396_1.time_ - 0) / var_399_11)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_11 and arg_396_1.time_ < 0 + var_399_11 + arg_399_0 and not isNil(var_399_10) and arg_396_1.var_.characterEffect104402ui_story then
				arg_396_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_396_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_399_12 = arg_396_1.actors_["614801ui_story"].transform

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos614801ui_story = var_399_12.localPosition

				local var_399_13 = GameObjectTools.GetOrAddComponent(var_399_12.gameObject, typeof(DynamicBoneHelper))

				if var_399_13 then
					var_399_13:EnableDynamicBone(false)
				end
			end

			local var_399_14 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_14 then
				var_399_12.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos614801ui_story, Vector3.New(0, 100, 0), (arg_396_1.time_ - 0) / var_399_14)
				var_399_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_399_12.position).x, (manager.ui.mainCamera.transform.position - var_399_12.position).y, (manager.ui.mainCamera.transform.position - var_399_12.position).z)
				var_399_12.localEulerAngles.z = 0
				var_399_12.localEulerAngles.x = 0
				var_399_12.localEulerAngles = var_399_12.localEulerAngles
			end

			if arg_396_1.time_ >= 0 + var_399_14 and arg_396_1.time_ < 0 + var_399_14 + arg_399_0 then
				var_399_12.localPosition = Vector3.New(0, 100, 0)
				var_399_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_399_12.position).x, (manager.ui.mainCamera.transform.position - var_399_12.position).y, (manager.ui.mainCamera.transform.position - var_399_12.position).z)
				var_399_12.localEulerAngles.z = 0
				var_399_12.localEulerAngles.x = 0
				var_399_12.localEulerAngles = var_399_12.localEulerAngles

				local var_399_15 = GameObjectTools.GetOrAddComponent(var_399_12.gameObject, typeof(DynamicBoneHelper))

				if var_399_15 then
					var_399_15:EnableDynamicBone(true)
				end
			end

			local var_399_16 = 0
			local var_399_17 = 0.05

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_16 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_18 = arg_396_1:GetWordFromCfg(936041094)
				local var_399_19 = arg_396_1:FormatText(var_399_18.content)

				arg_396_1.text_.text = var_399_19

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_21 = 2 <= 0 and var_399_17 or var_399_17 * (utf8.len(var_399_19) / 2)

				if (2 <= 0 and var_399_17 or var_399_17 * (utf8.len(var_399_19) / 2)) > 0 and var_399_17 < var_399_21 then
					arg_396_1.talkMaxDuration = var_399_21

					if var_399_21 + var_399_16 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_21 + var_399_16
					end
				end

				arg_396_1.text_.text = var_399_19
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041094", "story_v_side_old_936041.awb") ~= 0 then
					local var_399_22 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041094", "story_v_side_old_936041.awb") / 1000

					if var_399_22 + var_399_16 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_22 + var_399_16
					end

					if var_399_18.prefab_name ~= "" and arg_396_1.actors_[var_399_18.prefab_name] ~= nil then
						local var_399_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_18.prefab_name].transform, "story_v_side_old_936041", "936041094", "story_v_side_old_936041.awb")

						arg_396_1:RecordAudio("936041094", var_399_23)
						arg_396_1:RecordAudio("936041094", var_399_23)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041094", "story_v_side_old_936041.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041094", "story_v_side_old_936041.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_24 = math.max(var_399_17, arg_396_1.talkMaxDuration)

			if var_399_16 <= arg_396_1.time_ and arg_396_1.time_ < var_399_16 + var_399_24 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_16) / var_399_24

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_16 + var_399_24 and arg_396_1.time_ < var_399_16 + var_399_24 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play936041095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 936041095
		arg_400_1.duration_ = 2

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play936041096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos121102ui_story = arg_400_1.actors_["121102ui_story"].transform.localPosition

				local var_403_0 = GameObjectTools.GetOrAddComponent(arg_400_1.actors_["121102ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_403_0 then
					var_403_0:EnableDynamicBone(false)
				end
			end

			local var_403_1 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_1 then
				arg_400_1.actors_["121102ui_story"].transform.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos121102ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_400_1.time_ - 0) / var_403_1)
				arg_400_1.actors_["121102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["121102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["121102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["121102ui_story"].transform.position).z)
				arg_400_1.actors_["121102ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["121102ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["121102ui_story"].transform.localEulerAngles = arg_400_1.actors_["121102ui_story"].transform.localEulerAngles
			end

			if arg_400_1.time_ >= 0 + var_403_1 and arg_400_1.time_ < 0 + var_403_1 + arg_403_0 then
				arg_400_1.actors_["121102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_400_1.actors_["121102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["121102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["121102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["121102ui_story"].transform.position).z)
				arg_400_1.actors_["121102ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["121102ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["121102ui_story"].transform.localEulerAngles = arg_400_1.actors_["121102ui_story"].transform.localEulerAngles

				local var_403_2 = GameObjectTools.GetOrAddComponent(arg_400_1.actors_["121102ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_403_2 then
					var_403_2:EnableDynamicBone(true)
				end
			end

			local var_403_3 = arg_400_1.actors_["105401ui_story"].transform

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos105401ui_story = var_403_3.localPosition

				local var_403_4 = GameObjectTools.GetOrAddComponent(var_403_3.gameObject, typeof(DynamicBoneHelper))

				if var_403_4 then
					var_403_4:EnableDynamicBone(false)
				end
			end

			local var_403_5 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_5 then
				var_403_3.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos105401ui_story, Vector3.New(0, 100, 0), (arg_400_1.time_ - 0) / var_403_5)
				var_403_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_403_3.position).x, (manager.ui.mainCamera.transform.position - var_403_3.position).y, (manager.ui.mainCamera.transform.position - var_403_3.position).z)
				var_403_3.localEulerAngles.z = 0
				var_403_3.localEulerAngles.x = 0
				var_403_3.localEulerAngles = var_403_3.localEulerAngles
			end

			if arg_400_1.time_ >= 0 + var_403_5 and arg_400_1.time_ < 0 + var_403_5 + arg_403_0 then
				var_403_3.localPosition = Vector3.New(0, 100, 0)
				var_403_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_403_3.position).x, (manager.ui.mainCamera.transform.position - var_403_3.position).y, (manager.ui.mainCamera.transform.position - var_403_3.position).z)
				var_403_3.localEulerAngles.z = 0
				var_403_3.localEulerAngles.x = 0
				var_403_3.localEulerAngles = var_403_3.localEulerAngles

				local var_403_6 = GameObjectTools.GetOrAddComponent(var_403_3.gameObject, typeof(DynamicBoneHelper))

				if var_403_6 then
					var_403_6:EnableDynamicBone(true)
				end
			end

			local var_403_7 = arg_400_1.actors_["121102ui_story"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_7) and arg_400_1.var_.characterEffect121102ui_story == nil then
				arg_400_1.var_.characterEffect121102ui_story = var_403_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_8 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_8 and not isNil(var_403_7) then
				if arg_400_1.var_.characterEffect121102ui_story and not isNil(var_403_7) then
					arg_400_1.var_.characterEffect121102ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= 0 + var_403_8 and arg_400_1.time_ < 0 + var_403_8 + arg_403_0 and not isNil(var_403_7) and arg_400_1.var_.characterEffect121102ui_story then
				arg_400_1.var_.characterEffect121102ui_story.fillFlat = false
			end

			local var_403_10 = arg_400_1.actors_["614801ui_story"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_10) and arg_400_1.var_.characterEffect614801ui_story == nil then
				arg_400_1.var_.characterEffect614801ui_story = var_403_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_11 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_11 and not isNil(var_403_10) then
				if arg_400_1.var_.characterEffect614801ui_story and not isNil(var_403_10) then
					arg_400_1.var_.characterEffect614801ui_story.fillFlat = true
					arg_400_1.var_.characterEffect614801ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_400_1.time_ - 0) / var_403_11)
				end
			end

			if arg_400_1.time_ >= 0 + var_403_11 and arg_400_1.time_ < 0 + var_403_11 + arg_403_0 and not isNil(var_403_10) and arg_400_1.var_.characterEffect614801ui_story then
				arg_400_1.var_.characterEffect614801ui_story.fillFlat = true
				arg_400_1.var_.characterEffect614801ui_story.fillRatio = 0.5
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_403_12 = 0
			local var_403_13 = 0.05

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_12 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_14 = arg_400_1:GetWordFromCfg(936041095)
				local var_403_15 = arg_400_1:FormatText(var_403_14.content)

				arg_400_1.text_.text = var_403_15

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_17 = 2 <= 0 and var_403_13 or var_403_13 * (utf8.len(var_403_15) / 2)

				if (2 <= 0 and var_403_13 or var_403_13 * (utf8.len(var_403_15) / 2)) > 0 and var_403_13 < var_403_17 then
					arg_400_1.talkMaxDuration = var_403_17

					if var_403_17 + var_403_12 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_17 + var_403_12
					end
				end

				arg_400_1.text_.text = var_403_15
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041095", "story_v_side_old_936041.awb") ~= 0 then
					local var_403_18 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041095", "story_v_side_old_936041.awb") / 1000

					if var_403_18 + var_403_12 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_18 + var_403_12
					end

					if var_403_14.prefab_name ~= "" and arg_400_1.actors_[var_403_14.prefab_name] ~= nil then
						local var_403_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_14.prefab_name].transform, "story_v_side_old_936041", "936041095", "story_v_side_old_936041.awb")

						arg_400_1:RecordAudio("936041095", var_403_19)
						arg_400_1:RecordAudio("936041095", var_403_19)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041095", "story_v_side_old_936041.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041095", "story_v_side_old_936041.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_20 = math.max(var_403_13, arg_400_1.talkMaxDuration)

			if var_403_12 <= arg_400_1.time_ and arg_400_1.time_ < var_403_12 + var_403_20 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_12) / var_403_20

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_12 + var_403_20 and arg_400_1.time_ < var_403_12 + var_403_20 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play936041096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 936041096
		arg_404_1.duration_ = 3.37

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play936041097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos104402ui_story = arg_404_1.actors_["104402ui_story"].transform.localPosition

				local var_407_0 = GameObjectTools.GetOrAddComponent(arg_404_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_407_0 then
					var_407_0:EnableDynamicBone(false)
				end
			end

			local var_407_1 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_1 then
				arg_404_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos104402ui_story, Vector3.New(0.7, -1, -5.93), (arg_404_1.time_ - 0) / var_407_1)
				arg_404_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["104402ui_story"].transform.position).z)
				arg_404_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["104402ui_story"].transform.localEulerAngles = arg_404_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_1 and arg_404_1.time_ < 0 + var_407_1 + arg_407_0 then
				arg_404_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_404_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["104402ui_story"].transform.position).z)
				arg_404_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["104402ui_story"].transform.localEulerAngles = arg_404_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_407_2 = GameObjectTools.GetOrAddComponent(arg_404_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_407_2 then
					var_407_2:EnableDynamicBone(true)
				end
			end

			local var_407_3 = arg_404_1.actors_["614801ui_story"].transform

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos614801ui_story = var_407_3.localPosition

				local var_407_4 = GameObjectTools.GetOrAddComponent(var_407_3.gameObject, typeof(DynamicBoneHelper))

				if var_407_4 then
					var_407_4:EnableDynamicBone(false)
				end
			end

			local var_407_5 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_5 then
				var_407_3.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos614801ui_story, Vector3.New(0, 100, 0), (arg_404_1.time_ - 0) / var_407_5)
				var_407_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_407_3.position).x, (manager.ui.mainCamera.transform.position - var_407_3.position).y, (manager.ui.mainCamera.transform.position - var_407_3.position).z)
				var_407_3.localEulerAngles.z = 0
				var_407_3.localEulerAngles.x = 0
				var_407_3.localEulerAngles = var_407_3.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_5 and arg_404_1.time_ < 0 + var_407_5 + arg_407_0 then
				var_407_3.localPosition = Vector3.New(0, 100, 0)
				var_407_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_407_3.position).x, (manager.ui.mainCamera.transform.position - var_407_3.position).y, (manager.ui.mainCamera.transform.position - var_407_3.position).z)
				var_407_3.localEulerAngles.z = 0
				var_407_3.localEulerAngles.x = 0
				var_407_3.localEulerAngles = var_407_3.localEulerAngles

				local var_407_6 = GameObjectTools.GetOrAddComponent(var_407_3.gameObject, typeof(DynamicBoneHelper))

				if var_407_6 then
					var_407_6:EnableDynamicBone(true)
				end
			end

			local var_407_7 = arg_404_1.actors_["104402ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_7) and arg_404_1.var_.characterEffect104402ui_story == nil then
				arg_404_1.var_.characterEffect104402ui_story = var_407_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_8 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_8 and not isNil(var_407_7) then
				if arg_404_1.var_.characterEffect104402ui_story and not isNil(var_407_7) then
					arg_404_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_8 and arg_404_1.time_ < 0 + var_407_8 + arg_407_0 and not isNil(var_407_7) and arg_404_1.var_.characterEffect104402ui_story then
				arg_404_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_407_10 = arg_404_1.actors_["121102ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_10) and arg_404_1.var_.characterEffect121102ui_story == nil then
				arg_404_1.var_.characterEffect121102ui_story = var_407_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_11 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_11 and not isNil(var_407_10) then
				if arg_404_1.var_.characterEffect121102ui_story and not isNil(var_407_10) then
					arg_404_1.var_.characterEffect121102ui_story.fillFlat = true
					arg_404_1.var_.characterEffect121102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_404_1.time_ - 0) / var_407_11)
				end
			end

			if arg_404_1.time_ >= 0 + var_407_11 and arg_404_1.time_ < 0 + var_407_11 + arg_407_0 and not isNil(var_407_10) and arg_404_1.var_.characterEffect121102ui_story then
				arg_404_1.var_.characterEffect121102ui_story.fillFlat = true
				arg_404_1.var_.characterEffect121102ui_story.fillRatio = 0.5
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_1")
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_407_12 = 0
			local var_407_13 = 0.325

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_12 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_14 = arg_404_1:GetWordFromCfg(936041096)
				local var_407_15 = arg_404_1:FormatText(var_407_14.content)

				arg_404_1.text_.text = var_407_15

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_17 = 13 <= 0 and var_407_13 or var_407_13 * (utf8.len(var_407_15) / 13)

				if (13 <= 0 and var_407_13 or var_407_13 * (utf8.len(var_407_15) / 13)) > 0 and var_407_13 < var_407_17 then
					arg_404_1.talkMaxDuration = var_407_17

					if var_407_17 + var_407_12 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_17 + var_407_12
					end
				end

				arg_404_1.text_.text = var_407_15
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041096", "story_v_side_old_936041.awb") ~= 0 then
					local var_407_18 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041096", "story_v_side_old_936041.awb") / 1000

					if var_407_18 + var_407_12 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_18 + var_407_12
					end

					if var_407_14.prefab_name ~= "" and arg_404_1.actors_[var_407_14.prefab_name] ~= nil then
						local var_407_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_14.prefab_name].transform, "story_v_side_old_936041", "936041096", "story_v_side_old_936041.awb")

						arg_404_1:RecordAudio("936041096", var_407_19)
						arg_404_1:RecordAudio("936041096", var_407_19)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041096", "story_v_side_old_936041.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041096", "story_v_side_old_936041.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_20 = math.max(var_407_13, arg_404_1.talkMaxDuration)

			if var_407_12 <= arg_404_1.time_ and arg_404_1.time_ < var_407_12 + var_407_20 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_12) / var_407_20

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_12 + var_407_20 and arg_404_1.time_ < var_407_12 + var_407_20 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play936041097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 936041097
		arg_408_1.duration_ = 6.97

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play936041098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos121102ui_story = arg_408_1.actors_["121102ui_story"].transform.localPosition

				local var_411_0 = GameObjectTools.GetOrAddComponent(arg_408_1.actors_["121102ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_411_0 then
					var_411_0:EnableDynamicBone(false)
				end
			end

			local var_411_1 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_1 then
				arg_408_1.actors_["121102ui_story"].transform.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos121102ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_408_1.time_ - 0) / var_411_1)
				arg_408_1.actors_["121102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_408_1.actors_["121102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["121102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["121102ui_story"].transform.position).z)
				arg_408_1.actors_["121102ui_story"].transform.localEulerAngles.z = 0
				arg_408_1.actors_["121102ui_story"].transform.localEulerAngles.x = 0
				arg_408_1.actors_["121102ui_story"].transform.localEulerAngles = arg_408_1.actors_["121102ui_story"].transform.localEulerAngles
			end

			if arg_408_1.time_ >= 0 + var_411_1 and arg_408_1.time_ < 0 + var_411_1 + arg_411_0 then
				arg_408_1.actors_["121102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_408_1.actors_["121102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_408_1.actors_["121102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["121102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["121102ui_story"].transform.position).z)
				arg_408_1.actors_["121102ui_story"].transform.localEulerAngles.z = 0
				arg_408_1.actors_["121102ui_story"].transform.localEulerAngles.x = 0
				arg_408_1.actors_["121102ui_story"].transform.localEulerAngles = arg_408_1.actors_["121102ui_story"].transform.localEulerAngles

				local var_411_2 = GameObjectTools.GetOrAddComponent(arg_408_1.actors_["121102ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_411_2 then
					var_411_2:EnableDynamicBone(true)
				end
			end

			local var_411_3 = arg_408_1.actors_["121102ui_story"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_3) and arg_408_1.var_.characterEffect121102ui_story == nil then
				arg_408_1.var_.characterEffect121102ui_story = var_411_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_4 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_4 and not isNil(var_411_3) then
				if arg_408_1.var_.characterEffect121102ui_story and not isNil(var_411_3) then
					arg_408_1.var_.characterEffect121102ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= 0 + var_411_4 and arg_408_1.time_ < 0 + var_411_4 + arg_411_0 and not isNil(var_411_3) and arg_408_1.var_.characterEffect121102ui_story then
				arg_408_1.var_.characterEffect121102ui_story.fillFlat = false
			end

			local var_411_6 = arg_408_1.actors_["104402ui_story"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_6) and arg_408_1.var_.characterEffect104402ui_story == nil then
				arg_408_1.var_.characterEffect104402ui_story = var_411_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_7 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_7 and not isNil(var_411_6) then
				if arg_408_1.var_.characterEffect104402ui_story and not isNil(var_411_6) then
					arg_408_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_408_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_408_1.time_ - 0) / var_411_7)
				end
			end

			if arg_408_1.time_ >= 0 + var_411_7 and arg_408_1.time_ < 0 + var_411_7 + arg_411_0 and not isNil(var_411_6) and arg_408_1.var_.characterEffect104402ui_story then
				arg_408_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_408_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_411_8 = 0
			local var_411_9 = 0.575

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_8 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_10 = arg_408_1:GetWordFromCfg(936041097)
				local var_411_11 = arg_408_1:FormatText(var_411_10.content)

				arg_408_1.text_.text = var_411_11

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_13 = 23 <= 0 and var_411_9 or var_411_9 * (utf8.len(var_411_11) / 23)

				if (23 <= 0 and var_411_9 or var_411_9 * (utf8.len(var_411_11) / 23)) > 0 and var_411_9 < var_411_13 then
					arg_408_1.talkMaxDuration = var_411_13

					if var_411_13 + var_411_8 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_13 + var_411_8
					end
				end

				arg_408_1.text_.text = var_411_11
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041097", "story_v_side_old_936041.awb") ~= 0 then
					local var_411_14 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041097", "story_v_side_old_936041.awb") / 1000

					if var_411_14 + var_411_8 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_14 + var_411_8
					end

					if var_411_10.prefab_name ~= "" and arg_408_1.actors_[var_411_10.prefab_name] ~= nil then
						local var_411_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_10.prefab_name].transform, "story_v_side_old_936041", "936041097", "story_v_side_old_936041.awb")

						arg_408_1:RecordAudio("936041097", var_411_15)
						arg_408_1:RecordAudio("936041097", var_411_15)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041097", "story_v_side_old_936041.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041097", "story_v_side_old_936041.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_16 = math.max(var_411_9, arg_408_1.talkMaxDuration)

			if var_411_8 <= arg_408_1.time_ and arg_408_1.time_ < var_411_8 + var_411_16 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_8) / var_411_16

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_8 + var_411_16 and arg_408_1.time_ < var_411_8 + var_411_16 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play936041098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 936041098
		arg_412_1.duration_ = 4

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play936041099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos104402ui_story = arg_412_1.actors_["104402ui_story"].transform.localPosition

				local var_415_0 = GameObjectTools.GetOrAddComponent(arg_412_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_415_0 then
					var_415_0:EnableDynamicBone(false)
				end
			end

			local var_415_1 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_1 then
				arg_412_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos104402ui_story, Vector3.New(0.7, -1, -5.93), (arg_412_1.time_ - 0) / var_415_1)
				arg_412_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["104402ui_story"].transform.position).z)
				arg_412_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["104402ui_story"].transform.localEulerAngles = arg_412_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_412_1.time_ >= 0 + var_415_1 and arg_412_1.time_ < 0 + var_415_1 + arg_415_0 then
				arg_412_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_412_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["104402ui_story"].transform.position).z)
				arg_412_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["104402ui_story"].transform.localEulerAngles = arg_412_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_415_2 = GameObjectTools.GetOrAddComponent(arg_412_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_415_2 then
					var_415_2:EnableDynamicBone(true)
				end
			end

			local var_415_3 = arg_412_1.actors_["104402ui_story"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_3) and arg_412_1.var_.characterEffect104402ui_story == nil then
				arg_412_1.var_.characterEffect104402ui_story = var_415_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_4 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_4 and not isNil(var_415_3) then
				if arg_412_1.var_.characterEffect104402ui_story and not isNil(var_415_3) then
					arg_412_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= 0 + var_415_4 and arg_412_1.time_ < 0 + var_415_4 + arg_415_0 and not isNil(var_415_3) and arg_412_1.var_.characterEffect104402ui_story then
				arg_412_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_415_6 = arg_412_1.actors_["121102ui_story"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_6) and arg_412_1.var_.characterEffect121102ui_story == nil then
				arg_412_1.var_.characterEffect121102ui_story = var_415_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_7 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_7 and not isNil(var_415_6) then
				if arg_412_1.var_.characterEffect121102ui_story and not isNil(var_415_6) then
					arg_412_1.var_.characterEffect121102ui_story.fillFlat = true
					arg_412_1.var_.characterEffect121102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_412_1.time_ - 0) / var_415_7)
				end
			end

			if arg_412_1.time_ >= 0 + var_415_7 and arg_412_1.time_ < 0 + var_415_7 + arg_415_0 and not isNil(var_415_6) and arg_412_1.var_.characterEffect121102ui_story then
				arg_412_1.var_.characterEffect121102ui_story.fillFlat = true
				arg_412_1.var_.characterEffect121102ui_story.fillRatio = 0.5
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_2")
			end

			if 2 < arg_412_1.time_ and arg_412_1.time_ <= 2 + arg_415_0 then
				arg_412_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_415_8 = 0
			local var_415_9 = 0.125

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_8 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_10 = arg_412_1:GetWordFromCfg(936041098)
				local var_415_11 = arg_412_1:FormatText(var_415_10.content)

				arg_412_1.text_.text = var_415_11

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_13 = 5 <= 0 and var_415_9 or var_415_9 * (utf8.len(var_415_11) / 5)

				if (5 <= 0 and var_415_9 or var_415_9 * (utf8.len(var_415_11) / 5)) > 0 and var_415_9 < var_415_13 then
					arg_412_1.talkMaxDuration = var_415_13

					if var_415_13 + var_415_8 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_13 + var_415_8
					end
				end

				arg_412_1.text_.text = var_415_11
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041098", "story_v_side_old_936041.awb") ~= 0 then
					local var_415_14 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041098", "story_v_side_old_936041.awb") / 1000

					if var_415_14 + var_415_8 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_14 + var_415_8
					end

					if var_415_10.prefab_name ~= "" and arg_412_1.actors_[var_415_10.prefab_name] ~= nil then
						local var_415_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_10.prefab_name].transform, "story_v_side_old_936041", "936041098", "story_v_side_old_936041.awb")

						arg_412_1:RecordAudio("936041098", var_415_15)
						arg_412_1:RecordAudio("936041098", var_415_15)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041098", "story_v_side_old_936041.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041098", "story_v_side_old_936041.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_16 = math.max(var_415_9, arg_412_1.talkMaxDuration)

			if var_415_8 <= arg_412_1.time_ and arg_412_1.time_ < var_415_8 + var_415_16 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_8) / var_415_16

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_8 + var_415_16 and arg_412_1.time_ < var_415_8 + var_415_16 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play936041099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 936041099
		arg_416_1.duration_ = 2

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play936041100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_419_0 = 0
			local var_419_1 = 0.1

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_2 = arg_416_1:GetWordFromCfg(936041099)
				local var_419_3 = arg_416_1:FormatText(var_419_2.content)

				arg_416_1.text_.text = var_419_3

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 4 <= 0 and var_419_1 or var_419_1 * (utf8.len(var_419_3) / 4)

				if (4 <= 0 and var_419_1 or var_419_1 * (utf8.len(var_419_3) / 4)) > 0 and var_419_1 < var_419_5 then
					arg_416_1.talkMaxDuration = var_419_5

					if var_419_5 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_3
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041099", "story_v_side_old_936041.awb") ~= 0 then
					local var_419_6 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041099", "story_v_side_old_936041.awb") / 1000

					if var_419_6 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_6 + var_419_0
					end

					if var_419_2.prefab_name ~= "" and arg_416_1.actors_[var_419_2.prefab_name] ~= nil then
						local var_419_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_2.prefab_name].transform, "story_v_side_old_936041", "936041099", "story_v_side_old_936041.awb")

						arg_416_1:RecordAudio("936041099", var_419_7)
						arg_416_1:RecordAudio("936041099", var_419_7)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041099", "story_v_side_old_936041.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041099", "story_v_side_old_936041.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_8 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_8 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_8

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_8 and arg_416_1.time_ < var_419_0 + var_419_8 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play936041100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 936041100
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play936041101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(arg_420_1.actors_["104402ui_story"]) and arg_420_1.var_.characterEffect104402ui_story == nil then
				arg_420_1.var_.characterEffect104402ui_story = arg_420_1.actors_["104402ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_0 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 and not isNil(arg_420_1.actors_["104402ui_story"]) then
				if arg_420_1.var_.characterEffect104402ui_story and not isNil(arg_420_1.actors_["104402ui_story"]) then
					arg_420_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_420_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_420_1.time_ - 0) / var_423_0)
				end
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 and not isNil(arg_420_1.actors_["104402ui_story"]) and arg_420_1.var_.characterEffect104402ui_story then
				arg_420_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_420_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_423_1 = 0
			local var_423_2 = 0.475

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_420_1.callingController_:SetSelectedState("normal")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_3 = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(936041100).content)

				arg_420_1.text_.text = var_423_3

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_5 = 19 <= 0 and var_423_2 or var_423_2 * (utf8.len(var_423_3) / 19)

				if (19 <= 0 and var_423_2 or var_423_2 * (utf8.len(var_423_3) / 19)) > 0 and var_423_2 < var_423_5 then
					arg_420_1.talkMaxDuration = var_423_5

					if var_423_5 + var_423_1 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_5 + var_423_1
					end
				end

				arg_420_1.text_.text = var_423_3
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_6 = math.max(var_423_2, arg_420_1.talkMaxDuration)

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_6 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_1) / var_423_6

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_1 + var_423_6 and arg_420_1.time_ < var_423_1 + var_423_6 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play936041101 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 936041101
		arg_424_1.duration_ = 3.23

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play936041102(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos614801ui_story = arg_424_1.actors_["614801ui_story"].transform.localPosition

				local var_427_0 = GameObjectTools.GetOrAddComponent(arg_424_1.actors_["614801ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_427_0 then
					var_427_0:EnableDynamicBone(false)
				end
			end

			local var_427_1 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_1 then
				arg_424_1.actors_["614801ui_story"].transform.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos614801ui_story, Vector3.New(-0.7, -0.985, -6), (arg_424_1.time_ - 0) / var_427_1)
				arg_424_1.actors_["614801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["614801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["614801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["614801ui_story"].transform.position).z)
				arg_424_1.actors_["614801ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["614801ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["614801ui_story"].transform.localEulerAngles = arg_424_1.actors_["614801ui_story"].transform.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_1 and arg_424_1.time_ < 0 + var_427_1 + arg_427_0 then
				arg_424_1.actors_["614801ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_424_1.actors_["614801ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["614801ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["614801ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["614801ui_story"].transform.position).z)
				arg_424_1.actors_["614801ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["614801ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["614801ui_story"].transform.localEulerAngles = arg_424_1.actors_["614801ui_story"].transform.localEulerAngles

				local var_427_2 = GameObjectTools.GetOrAddComponent(arg_424_1.actors_["614801ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_427_2 then
					var_427_2:EnableDynamicBone(true)
				end
			end

			local var_427_3 = arg_424_1.actors_["121102ui_story"].transform

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos121102ui_story = var_427_3.localPosition

				local var_427_4 = GameObjectTools.GetOrAddComponent(var_427_3.gameObject, typeof(DynamicBoneHelper))

				if var_427_4 then
					var_427_4:EnableDynamicBone(false)
				end
			end

			local var_427_5 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_5 then
				var_427_3.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos121102ui_story, Vector3.New(0, 100, 0), (arg_424_1.time_ - 0) / var_427_5)
				var_427_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_427_3.position).x, (manager.ui.mainCamera.transform.position - var_427_3.position).y, (manager.ui.mainCamera.transform.position - var_427_3.position).z)
				var_427_3.localEulerAngles.z = 0
				var_427_3.localEulerAngles.x = 0
				var_427_3.localEulerAngles = var_427_3.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_5 and arg_424_1.time_ < 0 + var_427_5 + arg_427_0 then
				var_427_3.localPosition = Vector3.New(0, 100, 0)
				var_427_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_427_3.position).x, (manager.ui.mainCamera.transform.position - var_427_3.position).y, (manager.ui.mainCamera.transform.position - var_427_3.position).z)
				var_427_3.localEulerAngles.z = 0
				var_427_3.localEulerAngles.x = 0
				var_427_3.localEulerAngles = var_427_3.localEulerAngles

				local var_427_6 = GameObjectTools.GetOrAddComponent(var_427_3.gameObject, typeof(DynamicBoneHelper))

				if var_427_6 then
					var_427_6:EnableDynamicBone(true)
				end
			end

			local var_427_7 = arg_424_1.actors_["614801ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_7) and arg_424_1.var_.characterEffect614801ui_story == nil then
				arg_424_1.var_.characterEffect614801ui_story = var_427_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_8 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_8 and not isNil(var_427_7) then
				if arg_424_1.var_.characterEffect614801ui_story and not isNil(var_427_7) then
					arg_424_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= 0 + var_427_8 and arg_424_1.time_ < 0 + var_427_8 + arg_427_0 and not isNil(var_427_7) and arg_424_1.var_.characterEffect614801ui_story then
				arg_424_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("614801ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_427_10 = 0
			local var_427_11 = 0.475

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_10 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_12 = arg_424_1:GetWordFromCfg(936041101)
				local var_427_13 = arg_424_1:FormatText(var_427_12.content)

				arg_424_1.text_.text = var_427_13

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_15 = 19 <= 0 and var_427_11 or var_427_11 * (utf8.len(var_427_13) / 19)

				if (19 <= 0 and var_427_11 or var_427_11 * (utf8.len(var_427_13) / 19)) > 0 and var_427_11 < var_427_15 then
					arg_424_1.talkMaxDuration = var_427_15

					if var_427_15 + var_427_10 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_15 + var_427_10
					end
				end

				arg_424_1.text_.text = var_427_13
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041101", "story_v_side_old_936041.awb") ~= 0 then
					local var_427_16 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041101", "story_v_side_old_936041.awb") / 1000

					if var_427_16 + var_427_10 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_16 + var_427_10
					end

					if var_427_12.prefab_name ~= "" and arg_424_1.actors_[var_427_12.prefab_name] ~= nil then
						local var_427_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_12.prefab_name].transform, "story_v_side_old_936041", "936041101", "story_v_side_old_936041.awb")

						arg_424_1:RecordAudio("936041101", var_427_17)
						arg_424_1:RecordAudio("936041101", var_427_17)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041101", "story_v_side_old_936041.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041101", "story_v_side_old_936041.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_18 = math.max(var_427_11, arg_424_1.talkMaxDuration)

			if var_427_10 <= arg_424_1.time_ and arg_424_1.time_ < var_427_10 + var_427_18 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_10) / var_427_18

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_10 + var_427_18 and arg_424_1.time_ < var_427_10 + var_427_18 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play936041102 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 936041102
		arg_428_1.duration_ = 5.53

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play936041103(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos104402ui_story = arg_428_1.actors_["104402ui_story"].transform.localPosition

				local var_431_0 = GameObjectTools.GetOrAddComponent(arg_428_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_431_0 then
					var_431_0:EnableDynamicBone(false)
				end
			end

			local var_431_1 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_1 then
				arg_428_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos104402ui_story, Vector3.New(0.7, -1, -5.93), (arg_428_1.time_ - 0) / var_431_1)
				arg_428_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["104402ui_story"].transform.position).z)
				arg_428_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["104402ui_story"].transform.localEulerAngles = arg_428_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_428_1.time_ >= 0 + var_431_1 and arg_428_1.time_ < 0 + var_431_1 + arg_431_0 then
				arg_428_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_428_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["104402ui_story"].transform.position).z)
				arg_428_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["104402ui_story"].transform.localEulerAngles = arg_428_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_431_2 = GameObjectTools.GetOrAddComponent(arg_428_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_431_2 then
					var_431_2:EnableDynamicBone(true)
				end
			end

			local var_431_3 = arg_428_1.actors_["104402ui_story"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_3) and arg_428_1.var_.characterEffect104402ui_story == nil then
				arg_428_1.var_.characterEffect104402ui_story = var_431_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_4 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_4 and not isNil(var_431_3) then
				if arg_428_1.var_.characterEffect104402ui_story and not isNil(var_431_3) then
					arg_428_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= 0 + var_431_4 and arg_428_1.time_ < 0 + var_431_4 + arg_431_0 and not isNil(var_431_3) and arg_428_1.var_.characterEffect104402ui_story then
				arg_428_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_431_6 = arg_428_1.actors_["105401ui_story"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_6) and arg_428_1.var_.characterEffect105401ui_story == nil then
				arg_428_1.var_.characterEffect105401ui_story = var_431_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_7 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_7 and not isNil(var_431_6) then
				if arg_428_1.var_.characterEffect105401ui_story and not isNil(var_431_6) then
					arg_428_1.var_.characterEffect105401ui_story.fillFlat = true
					arg_428_1.var_.characterEffect105401ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_428_1.time_ - 0) / var_431_7)
				end
			end

			if arg_428_1.time_ >= 0 + var_431_7 and arg_428_1.time_ < 0 + var_431_7 + arg_431_0 and not isNil(var_431_6) and arg_428_1.var_.characterEffect105401ui_story then
				arg_428_1.var_.characterEffect105401ui_story.fillFlat = true
				arg_428_1.var_.characterEffect105401ui_story.fillRatio = 0.5
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action6_1")
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_431_8 = 0
			local var_431_9 = 0.625

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_8 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_10 = arg_428_1:GetWordFromCfg(936041102)
				local var_431_11 = arg_428_1:FormatText(var_431_10.content)

				arg_428_1.text_.text = var_431_11

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_13 = 25 <= 0 and var_431_9 or var_431_9 * (utf8.len(var_431_11) / 25)

				if (25 <= 0 and var_431_9 or var_431_9 * (utf8.len(var_431_11) / 25)) > 0 and var_431_9 < var_431_13 then
					arg_428_1.talkMaxDuration = var_431_13

					if var_431_13 + var_431_8 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_13 + var_431_8
					end
				end

				arg_428_1.text_.text = var_431_11
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041102", "story_v_side_old_936041.awb") ~= 0 then
					local var_431_14 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041102", "story_v_side_old_936041.awb") / 1000

					if var_431_14 + var_431_8 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_14 + var_431_8
					end

					if var_431_10.prefab_name ~= "" and arg_428_1.actors_[var_431_10.prefab_name] ~= nil then
						local var_431_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_10.prefab_name].transform, "story_v_side_old_936041", "936041102", "story_v_side_old_936041.awb")

						arg_428_1:RecordAudio("936041102", var_431_15)
						arg_428_1:RecordAudio("936041102", var_431_15)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041102", "story_v_side_old_936041.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041102", "story_v_side_old_936041.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_16 = math.max(var_431_9, arg_428_1.talkMaxDuration)

			if var_431_8 <= arg_428_1.time_ and arg_428_1.time_ < var_431_8 + var_431_16 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_8) / var_431_16

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_8 + var_431_16 and arg_428_1.time_ < var_431_8 + var_431_16 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play936041103 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 936041103
		arg_432_1.duration_ = 5.03

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play936041104(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos104402ui_story = arg_432_1.actors_["104402ui_story"].transform.localPosition

				local var_435_0 = GameObjectTools.GetOrAddComponent(arg_432_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_435_0 then
					var_435_0:EnableDynamicBone(false)
				end
			end

			local var_435_1 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_1 then
				arg_432_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos104402ui_story, Vector3.New(0.7, -1, -5.93), (arg_432_1.time_ - 0) / var_435_1)
				arg_432_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_432_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["104402ui_story"].transform.position).z)
				arg_432_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_432_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_432_1.actors_["104402ui_story"].transform.localEulerAngles = arg_432_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_432_1.time_ >= 0 + var_435_1 and arg_432_1.time_ < 0 + var_435_1 + arg_435_0 then
				arg_432_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_432_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_432_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["104402ui_story"].transform.position).z)
				arg_432_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_432_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_432_1.actors_["104402ui_story"].transform.localEulerAngles = arg_432_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_435_2 = GameObjectTools.GetOrAddComponent(arg_432_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_435_2 then
					var_435_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action6_2")
			end

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_435_3 = 0
			local var_435_4 = 0.45

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_3 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_5 = arg_432_1:GetWordFromCfg(936041103)
				local var_435_6 = arg_432_1:FormatText(var_435_5.content)

				arg_432_1.text_.text = var_435_6

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_8 = 18 <= 0 and var_435_4 or var_435_4 * (utf8.len(var_435_6) / 18)

				if (18 <= 0 and var_435_4 or var_435_4 * (utf8.len(var_435_6) / 18)) > 0 and var_435_4 < var_435_8 then
					arg_432_1.talkMaxDuration = var_435_8

					if var_435_8 + var_435_3 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_8 + var_435_3
					end
				end

				arg_432_1.text_.text = var_435_6
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041103", "story_v_side_old_936041.awb") ~= 0 then
					local var_435_9 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041103", "story_v_side_old_936041.awb") / 1000

					if var_435_9 + var_435_3 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_9 + var_435_3
					end

					if var_435_5.prefab_name ~= "" and arg_432_1.actors_[var_435_5.prefab_name] ~= nil then
						local var_435_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_5.prefab_name].transform, "story_v_side_old_936041", "936041103", "story_v_side_old_936041.awb")

						arg_432_1:RecordAudio("936041103", var_435_10)
						arg_432_1:RecordAudio("936041103", var_435_10)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041103", "story_v_side_old_936041.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041103", "story_v_side_old_936041.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_11 = math.max(var_435_4, arg_432_1.talkMaxDuration)

			if var_435_3 <= arg_432_1.time_ and arg_432_1.time_ < var_435_3 + var_435_11 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_3) / var_435_11

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_3 + var_435_11 and arg_432_1.time_ < var_435_3 + var_435_11 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play936041104 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 936041104
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play936041105(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos104402ui_story = arg_436_1.actors_["104402ui_story"].transform.localPosition

				local var_439_0 = GameObjectTools.GetOrAddComponent(arg_436_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_439_0 then
					var_439_0:EnableDynamicBone(false)
				end
			end

			local var_439_1 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_1 then
				arg_436_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_436_1.time_ - 0) / var_439_1)
				arg_436_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["104402ui_story"].transform.position).z)
				arg_436_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["104402ui_story"].transform.localEulerAngles = arg_436_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_436_1.time_ >= 0 + var_439_1 and arg_436_1.time_ < 0 + var_439_1 + arg_439_0 then
				arg_436_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_436_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["104402ui_story"].transform.position).z)
				arg_436_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["104402ui_story"].transform.localEulerAngles = arg_436_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_439_2 = GameObjectTools.GetOrAddComponent(arg_436_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_439_2 then
					var_439_2:EnableDynamicBone(true)
				end
			end

			local var_439_3 = arg_436_1.actors_["614801ui_story"].transform

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos614801ui_story = var_439_3.localPosition

				local var_439_4 = GameObjectTools.GetOrAddComponent(var_439_3.gameObject, typeof(DynamicBoneHelper))

				if var_439_4 then
					var_439_4:EnableDynamicBone(false)
				end
			end

			local var_439_5 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_5 then
				var_439_3.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos614801ui_story, Vector3.New(0, 100, 0), (arg_436_1.time_ - 0) / var_439_5)
				var_439_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_439_3.position).x, (manager.ui.mainCamera.transform.position - var_439_3.position).y, (manager.ui.mainCamera.transform.position - var_439_3.position).z)
				var_439_3.localEulerAngles.z = 0
				var_439_3.localEulerAngles.x = 0
				var_439_3.localEulerAngles = var_439_3.localEulerAngles
			end

			if arg_436_1.time_ >= 0 + var_439_5 and arg_436_1.time_ < 0 + var_439_5 + arg_439_0 then
				var_439_3.localPosition = Vector3.New(0, 100, 0)
				var_439_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_439_3.position).x, (manager.ui.mainCamera.transform.position - var_439_3.position).y, (manager.ui.mainCamera.transform.position - var_439_3.position).z)
				var_439_3.localEulerAngles.z = 0
				var_439_3.localEulerAngles.x = 0
				var_439_3.localEulerAngles = var_439_3.localEulerAngles

				local var_439_6 = GameObjectTools.GetOrAddComponent(var_439_3.gameObject, typeof(DynamicBoneHelper))

				if var_439_6 then
					var_439_6:EnableDynamicBone(true)
				end
			end

			local var_439_7 = arg_436_1.actors_["614801ui_story"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_7) and arg_436_1.var_.characterEffect614801ui_story == nil then
				arg_436_1.var_.characterEffect614801ui_story = var_439_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_8 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_8 and not isNil(var_439_7) then
				if arg_436_1.var_.characterEffect614801ui_story and not isNil(var_439_7) then
					arg_436_1.var_.characterEffect614801ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= 0 + var_439_8 and arg_436_1.time_ < 0 + var_439_8 + arg_439_0 and not isNil(var_439_7) and arg_436_1.var_.characterEffect614801ui_story then
				arg_436_1.var_.characterEffect614801ui_story.fillFlat = false
			end

			local var_439_10 = 0
			local var_439_11 = 0.875

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_10 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_12 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(936041104).content)

				arg_436_1.text_.text = var_439_12

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_14 = 35 <= 0 and var_439_11 or var_439_11 * (utf8.len(var_439_12) / 35)

				if (35 <= 0 and var_439_11 or var_439_11 * (utf8.len(var_439_12) / 35)) > 0 and var_439_11 < var_439_14 then
					arg_436_1.talkMaxDuration = var_439_14

					if var_439_14 + var_439_10 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_14 + var_439_10
					end
				end

				arg_436_1.text_.text = var_439_12
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_15 = math.max(var_439_11, arg_436_1.talkMaxDuration)

			if var_439_10 <= arg_436_1.time_ and arg_436_1.time_ < var_439_10 + var_439_15 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_10) / var_439_15

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_10 + var_439_15 and arg_436_1.time_ < var_439_10 + var_439_15 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "614801ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play936041105 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 936041105
		arg_440_1.duration_ = 9.3

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play936041106(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if arg_440_1.bgs_.ST2201 == nil then
				local var_443_0 = Object.Instantiate(arg_440_1.paintGo_)

				var_443_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2201")
				var_443_0.name = "ST2201"
				var_443_0.transform.parent = arg_440_1.stage_.transform
				var_443_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_440_1.bgs_.ST2201 = var_443_0
			end

			if 2.00000000298023 < arg_440_1.time_ and arg_440_1.time_ <= 2.00000000298023 + arg_443_0 then
				local var_443_1 = arg_440_1.bgs_.ST2201

				arg_440_1.bgs_.ST2201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_443_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_443_2 = var_443_1:GetComponent("SpriteRenderer")

				if var_443_2 and var_443_2.sprite then
					local var_443_3 = 2 * (var_443_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_443_1.transform.localScale = Vector3.New(var_443_3 / var_443_2.sprite.bounds.size.y < var_443_3 * manager.ui.mainCameraCom_.aspect / var_443_2.sprite.bounds.size.x and var_443_3 * manager.ui.mainCameraCom_.aspect / var_443_2.sprite.bounds.size.x or var_443_3 / var_443_2.sprite.bounds.size.y, var_443_3 / var_443_2.sprite.bounds.size.y < var_443_3 * manager.ui.mainCameraCom_.aspect / var_443_2.sprite.bounds.size.x and var_443_3 * manager.ui.mainCameraCom_.aspect / var_443_2.sprite.bounds.size.x or var_443_3 / var_443_2.sprite.bounds.size.y, 0)
				end

				for iter_443_0, iter_443_1 in pairs(arg_440_1.bgs_) do
					if iter_443_0 ~= "ST2201" then
						iter_443_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_443_4 = 3.999999999999

			if 3.999999999999 < arg_440_1.time_ and arg_440_1.time_ <= var_443_4 + arg_443_0 then
				arg_440_1.allBtn_.enabled = false
			end

			if arg_440_1.time_ >= var_443_4 + 0.3 and arg_440_1.time_ < var_443_4 + 0.3 + arg_443_0 then
				arg_440_1.allBtn_.enabled = true
			end

			local var_443_5 = 0

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_5 + arg_443_0 then
				arg_440_1.mask_.enabled = true
				arg_440_1.mask_.raycastTarget = true

				arg_440_1:SetGaussion(false)
			end

			local var_443_6 = 2

			if var_443_5 <= arg_440_1.time_ and arg_440_1.time_ < var_443_5 + var_443_6 then
				local var_443_7 = Color.New(0, 0, 0)

				var_443_7.a = Mathf.Lerp(0, 1, (arg_440_1.time_ - var_443_5) / var_443_6)
				arg_440_1.mask_.color = var_443_7
			end

			if arg_440_1.time_ >= var_443_5 + var_443_6 and arg_440_1.time_ < var_443_5 + var_443_6 + arg_443_0 then
				local var_443_8 = Color.New(0, 0, 0)

				var_443_8.a = 1
				arg_440_1.mask_.color = var_443_8
			end

			local var_443_9 = 2

			if 2 < arg_440_1.time_ and arg_440_1.time_ <= var_443_9 + arg_443_0 then
				arg_440_1.mask_.enabled = true
				arg_440_1.mask_.raycastTarget = true

				arg_440_1:SetGaussion(false)
			end

			local var_443_10 = 2

			if var_443_9 <= arg_440_1.time_ and arg_440_1.time_ < var_443_9 + var_443_10 then
				local var_443_11 = Color.New(0, 0, 0)

				var_443_11.a = Mathf.Lerp(1, 0, (arg_440_1.time_ - var_443_9) / var_443_10)
				arg_440_1.mask_.color = var_443_11
			end

			if arg_440_1.time_ >= var_443_9 + var_443_10 and arg_440_1.time_ < var_443_9 + var_443_10 + arg_443_0 then
				local var_443_12 = Color.New(0, 0, 0)

				arg_440_1.mask_.enabled = false
				var_443_12.a = 0
				arg_440_1.mask_.color = var_443_12
			end

			local var_443_13 = "1033ui_story"

			if arg_440_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_443_14 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_440_1.stage_.transform)

				var_443_14.name = var_443_13
				var_443_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_440_1.actors_[var_443_13] = var_443_14

				local var_443_15 = var_443_14:GetComponentInChildren(typeof(CharacterEffect))

				var_443_15.enabled = true

				local var_443_16 = GameObjectTools.GetOrAddComponent(var_443_14, typeof(DynamicBoneHelper))

				if var_443_16 then
					var_443_16:EnableDynamicBone(false)
				end

				arg_440_1:ShowWeapon(var_443_15.transform, false)

				arg_440_1.var_[var_443_13 .. "Animator"] = var_443_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_440_1.var_[var_443_13 .. "Animator"].applyRootMotion = true
				arg_440_1.var_[var_443_13 .. "LipSync"] = var_443_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_443_17 = arg_440_1.actors_["1033ui_story"].transform

			if 3.8 < arg_440_1.time_ and arg_440_1.time_ <= 3.8 + arg_443_0 then
				arg_440_1.var_.moveOldPos1033ui_story = var_443_17.localPosition
			end

			local var_443_18 = 0.001

			if 3.8 <= arg_440_1.time_ and arg_440_1.time_ < 3.8 + var_443_18 then
				var_443_17.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_440_1.time_ - 3.8) / var_443_18)
				var_443_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_443_17.position).x, (manager.ui.mainCamera.transform.position - var_443_17.position).y, (manager.ui.mainCamera.transform.position - var_443_17.position).z)
				var_443_17.localEulerAngles.z = 0
				var_443_17.localEulerAngles.x = 0
				var_443_17.localEulerAngles = var_443_17.localEulerAngles
			end

			if arg_440_1.time_ >= 3.8 + var_443_18 and arg_440_1.time_ < 3.8 + var_443_18 + arg_443_0 then
				var_443_17.localPosition = Vector3.New(0, -1.01, -6.13)
				var_443_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_443_17.position).x, (manager.ui.mainCamera.transform.position - var_443_17.position).y, (manager.ui.mainCamera.transform.position - var_443_17.position).z)
				var_443_17.localEulerAngles.z = 0
				var_443_17.localEulerAngles.x = 0
				var_443_17.localEulerAngles = var_443_17.localEulerAngles
			end

			local var_443_19 = arg_440_1.actors_["1033ui_story"]

			if 3.8 < arg_440_1.time_ and arg_440_1.time_ <= 3.8 + arg_443_0 and not isNil(var_443_19) and arg_440_1.var_.characterEffect1033ui_story == nil then
				arg_440_1.var_.characterEffect1033ui_story = var_443_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_20 = 0.200000002980232

			if 3.8 <= arg_440_1.time_ and arg_440_1.time_ < 3.8 + var_443_20 and not isNil(var_443_19) then
				if arg_440_1.var_.characterEffect1033ui_story and not isNil(var_443_19) then
					arg_440_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= 3.8 + var_443_20 and arg_440_1.time_ < 3.8 + var_443_20 + arg_443_0 and not isNil(var_443_19) and arg_440_1.var_.characterEffect1033ui_story then
				arg_440_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 3.8 < arg_440_1.time_ and arg_440_1.time_ <= 3.8 + arg_443_0 then
				arg_440_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 3.8 < arg_440_1.time_ and arg_440_1.time_ <= 3.8 + arg_443_0 then
				arg_440_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.266666666666667 < arg_440_1.time_ and arg_440_1.time_ <= 0.266666666666667 + arg_443_0 then
				arg_440_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 1.6 < arg_440_1.time_ and arg_440_1.time_ <= 1.6 + arg_443_0 then
				arg_440_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_440_1.frameCnt_ <= 1 then
				arg_440_1.dialog_:SetActive(false)
			end

			local var_443_24 = 3.999999999999
			local var_443_25 = 0.65

			if 3.999999999999 < arg_440_1.time_ and arg_440_1.time_ <= var_443_24 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0

				arg_440_1.dialog_:SetActive(true)

				arg_440_1.dialogCg_.alpha = 0

				local var_443_26 = LeanTween.value(arg_440_1.dialog_, 0, 1, 0.3)

				var_443_26:setOnUpdate(LuaHelper.FloatAction(function(arg_444_0)
					arg_440_1.dialogCg_.alpha = arg_444_0
				end))
				var_443_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_440_1.dialog_)
					var_443_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_440_1.duration_ = arg_440_1.duration_ + 0.3

				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_27 = arg_440_1:GetWordFromCfg(936041105)
				local var_443_28 = arg_440_1:FormatText(var_443_27.content)

				arg_440_1.text_.text = var_443_28

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_30 = 26 <= 0 and var_443_25 or var_443_25 * (utf8.len(var_443_28) / 26)

				if (26 <= 0 and var_443_25 or var_443_25 * (utf8.len(var_443_28) / 26)) > 0 and var_443_25 < var_443_30 then
					arg_440_1.talkMaxDuration = var_443_30
					var_443_24 = var_443_24 + 0.3

					if var_443_30 + var_443_24 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_30 + var_443_24
					end
				end

				arg_440_1.text_.text = var_443_28
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041105", "story_v_side_old_936041.awb") ~= 0 then
					local var_443_31 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041105", "story_v_side_old_936041.awb") / 1000

					if var_443_31 + var_443_24 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_31 + var_443_24
					end

					if var_443_27.prefab_name ~= "" and arg_440_1.actors_[var_443_27.prefab_name] ~= nil then
						local var_443_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_27.prefab_name].transform, "story_v_side_old_936041", "936041105", "story_v_side_old_936041.awb")

						arg_440_1:RecordAudio("936041105", var_443_32)
						arg_440_1:RecordAudio("936041105", var_443_32)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041105", "story_v_side_old_936041.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041105", "story_v_side_old_936041.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_33 = var_443_24 + 0.3
			local var_443_34 = math.max(var_443_25, arg_440_1.talkMaxDuration)

			if var_443_24 + 0.3 <= arg_440_1.time_ and arg_440_1.time_ < var_443_33 + var_443_34 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_33) / var_443_34

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_33 + var_443_34 and arg_440_1.time_ < var_443_33 + var_443_34 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play936041106 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 936041106
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play936041107(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.var_.moveOldPos1033ui_story = arg_446_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_449_0 = 0.001

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 then
				arg_446_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_446_1.time_ - 0) / var_449_0)
				arg_446_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_446_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["1033ui_story"].transform.position).z)
				arg_446_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_446_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_446_1.actors_["1033ui_story"].transform.localEulerAngles = arg_446_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 then
				arg_446_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_446_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_446_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["1033ui_story"].transform.position).z)
				arg_446_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_446_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_446_1.actors_["1033ui_story"].transform.localEulerAngles = arg_446_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_449_1 = arg_446_1.actors_["1033ui_story"]

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(var_449_1) and arg_446_1.var_.characterEffect1033ui_story == nil then
				arg_446_1.var_.characterEffect1033ui_story = var_449_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_2 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_2 and not isNil(var_449_1) then
				if arg_446_1.var_.characterEffect1033ui_story and not isNil(var_449_1) then
					arg_446_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_446_1.time_ - 0) / var_449_2)
				end
			end

			if arg_446_1.time_ >= 0 + var_449_2 and arg_446_1.time_ < 0 + var_449_2 + arg_449_0 and not isNil(var_449_1) and arg_446_1.var_.characterEffect1033ui_story then
				arg_446_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_449_3 = 0
			local var_449_4 = 0.875

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_3 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_5 = arg_446_1:FormatText(arg_446_1:GetWordFromCfg(936041106).content)

				arg_446_1.text_.text = var_449_5

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_7 = 35 <= 0 and var_449_4 or var_449_4 * (utf8.len(var_449_5) / 35)

				if (35 <= 0 and var_449_4 or var_449_4 * (utf8.len(var_449_5) / 35)) > 0 and var_449_4 < var_449_7 then
					arg_446_1.talkMaxDuration = var_449_7

					if var_449_7 + var_449_3 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_7 + var_449_3
					end
				end

				arg_446_1.text_.text = var_449_5
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_8 = math.max(var_449_4, arg_446_1.talkMaxDuration)

			if var_449_3 <= arg_446_1.time_ and arg_446_1.time_ < var_449_3 + var_449_8 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_3) / var_449_8

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_3 + var_449_8 and arg_446_1.time_ < var_449_3 + var_449_8 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play936041107 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 936041107
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play936041108(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0.375

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_1 = arg_450_1:FormatText(arg_450_1:GetWordFromCfg(936041107).content)

				arg_450_1.text_.text = var_453_1

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_3 = 15 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_1) / 15)

				if (15 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_1) / 15)) > 0 and var_453_0 < var_453_3 then
					arg_450_1.talkMaxDuration = var_453_3

					if var_453_3 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_3 + 0
					end
				end

				arg_450_1.text_.text = var_453_1
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_4 = math.max(var_453_0, arg_450_1.talkMaxDuration)

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_4 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - 0) / var_453_4

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= 0 + var_453_4 and arg_450_1.time_ < 0 + var_453_4 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play936041108 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 936041108
		arg_454_1.duration_ = 5.33

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play936041109(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if arg_454_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_457_0 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_454_1.stage_.transform)

				var_457_0.name = "1066ui_story"
				var_457_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_454_1.actors_["1066ui_story"] = var_457_0

				local var_457_1 = var_457_0:GetComponentInChildren(typeof(CharacterEffect))

				var_457_1.enabled = true

				local var_457_2 = GameObjectTools.GetOrAddComponent(var_457_0, typeof(DynamicBoneHelper))

				if var_457_2 then
					var_457_2:EnableDynamicBone(false)
				end

				arg_454_1:ShowWeapon(var_457_1.transform, false)

				arg_454_1.var_["1066ui_story" .. "Animator"] = var_457_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_454_1.var_["1066ui_story" .. "Animator"].applyRootMotion = true
				arg_454_1.var_["1066ui_story" .. "LipSync"] = var_457_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_457_3 = arg_454_1.actors_["1066ui_story"].transform

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.var_.moveOldPos1066ui_story = var_457_3.localPosition
			end

			local var_457_4 = 0.001

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_4 then
				var_457_3.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_454_1.time_ - 0) / var_457_4)
				var_457_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_457_3.position).x, (manager.ui.mainCamera.transform.position - var_457_3.position).y, (manager.ui.mainCamera.transform.position - var_457_3.position).z)
				var_457_3.localEulerAngles.z = 0
				var_457_3.localEulerAngles.x = 0
				var_457_3.localEulerAngles = var_457_3.localEulerAngles
			end

			if arg_454_1.time_ >= 0 + var_457_4 and arg_454_1.time_ < 0 + var_457_4 + arg_457_0 then
				var_457_3.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				var_457_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_457_3.position).x, (manager.ui.mainCamera.transform.position - var_457_3.position).y, (manager.ui.mainCamera.transform.position - var_457_3.position).z)
				var_457_3.localEulerAngles.z = 0
				var_457_3.localEulerAngles.x = 0
				var_457_3.localEulerAngles = var_457_3.localEulerAngles
			end

			local var_457_5 = arg_454_1.actors_["1066ui_story"]

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(var_457_5) and arg_454_1.var_.characterEffect1066ui_story == nil then
				arg_454_1.var_.characterEffect1066ui_story = var_457_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_6 = 0.200000002980232

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_6 and not isNil(var_457_5) then
				if arg_454_1.var_.characterEffect1066ui_story and not isNil(var_457_5) then
					arg_454_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= 0 + var_457_6 and arg_454_1.time_ < 0 + var_457_6 + arg_457_0 and not isNil(var_457_5) and arg_454_1.var_.characterEffect1066ui_story then
				arg_454_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_457_8 = 0
			local var_457_9 = 0.5

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_8 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_10 = arg_454_1:GetWordFromCfg(936041108)
				local var_457_11 = arg_454_1:FormatText(var_457_10.content)

				arg_454_1.text_.text = var_457_11

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_13 = 20 <= 0 and var_457_9 or var_457_9 * (utf8.len(var_457_11) / 20)

				if (20 <= 0 and var_457_9 or var_457_9 * (utf8.len(var_457_11) / 20)) > 0 and var_457_9 < var_457_13 then
					arg_454_1.talkMaxDuration = var_457_13

					if var_457_13 + var_457_8 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_13 + var_457_8
					end
				end

				arg_454_1.text_.text = var_457_11
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041108", "story_v_side_old_936041.awb") ~= 0 then
					local var_457_14 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041108", "story_v_side_old_936041.awb") / 1000

					if var_457_14 + var_457_8 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_14 + var_457_8
					end

					if var_457_10.prefab_name ~= "" and arg_454_1.actors_[var_457_10.prefab_name] ~= nil then
						local var_457_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_10.prefab_name].transform, "story_v_side_old_936041", "936041108", "story_v_side_old_936041.awb")

						arg_454_1:RecordAudio("936041108", var_457_15)
						arg_454_1:RecordAudio("936041108", var_457_15)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041108", "story_v_side_old_936041.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041108", "story_v_side_old_936041.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_16 = math.max(var_457_9, arg_454_1.talkMaxDuration)

			if var_457_8 <= arg_454_1.time_ and arg_454_1.time_ < var_457_8 + var_457_16 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_8) / var_457_16

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_8 + var_457_16 and arg_454_1.time_ < var_457_8 + var_457_16 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play936041109 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 936041109
		arg_458_1.duration_ = 6

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play936041110(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.var_.moveOldPos104402ui_story = arg_458_1.actors_["104402ui_story"].transform.localPosition

				local var_461_0 = GameObjectTools.GetOrAddComponent(arg_458_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_461_0 then
					var_461_0:EnableDynamicBone(false)
				end
			end

			local var_461_1 = 0.001

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_1 then
				arg_458_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos104402ui_story, Vector3.New(0.7, -1, -5.93), (arg_458_1.time_ - 0) / var_461_1)
				arg_458_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_458_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["104402ui_story"].transform.position).z)
				arg_458_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_458_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_458_1.actors_["104402ui_story"].transform.localEulerAngles = arg_458_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_458_1.time_ >= 0 + var_461_1 and arg_458_1.time_ < 0 + var_461_1 + arg_461_0 then
				arg_458_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_458_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_458_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["104402ui_story"].transform.position).z)
				arg_458_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_458_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_458_1.actors_["104402ui_story"].transform.localEulerAngles = arg_458_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_461_2 = GameObjectTools.GetOrAddComponent(arg_458_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_461_2 then
					var_461_2:EnableDynamicBone(true)
				end
			end

			local var_461_3 = arg_458_1.actors_["104402ui_story"]

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(var_461_3) and arg_458_1.var_.characterEffect104402ui_story == nil then
				arg_458_1.var_.characterEffect104402ui_story = var_461_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_4 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_4 and not isNil(var_461_3) then
				if arg_458_1.var_.characterEffect104402ui_story and not isNil(var_461_3) then
					arg_458_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= 0 + var_461_4 and arg_458_1.time_ < 0 + var_461_4 + arg_461_0 and not isNil(var_461_3) and arg_458_1.var_.characterEffect104402ui_story then
				arg_458_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			local var_461_6 = arg_458_1.actors_["1066ui_story"]

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(var_461_6) and arg_458_1.var_.characterEffect1066ui_story == nil then
				arg_458_1.var_.characterEffect1066ui_story = var_461_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_7 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_7 and not isNil(var_461_6) then
				if arg_458_1.var_.characterEffect1066ui_story and not isNil(var_461_6) then
					arg_458_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_7)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_7 and arg_458_1.time_ < 0 + var_461_7 + arg_461_0 and not isNil(var_461_6) and arg_458_1.var_.characterEffect1066ui_story then
				arg_458_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_461_8 = 0
			local var_461_9 = 0.725

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_8 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_10 = arg_458_1:GetWordFromCfg(936041109)
				local var_461_11 = arg_458_1:FormatText(var_461_10.content)

				arg_458_1.text_.text = var_461_11

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_13 = 29 <= 0 and var_461_9 or var_461_9 * (utf8.len(var_461_11) / 29)

				if (29 <= 0 and var_461_9 or var_461_9 * (utf8.len(var_461_11) / 29)) > 0 and var_461_9 < var_461_13 then
					arg_458_1.talkMaxDuration = var_461_13

					if var_461_13 + var_461_8 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_13 + var_461_8
					end
				end

				arg_458_1.text_.text = var_461_11
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041109", "story_v_side_old_936041.awb") ~= 0 then
					local var_461_14 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041109", "story_v_side_old_936041.awb") / 1000

					if var_461_14 + var_461_8 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_14 + var_461_8
					end

					if var_461_10.prefab_name ~= "" and arg_458_1.actors_[var_461_10.prefab_name] ~= nil then
						local var_461_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_10.prefab_name].transform, "story_v_side_old_936041", "936041109", "story_v_side_old_936041.awb")

						arg_458_1:RecordAudio("936041109", var_461_15)
						arg_458_1:RecordAudio("936041109", var_461_15)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041109", "story_v_side_old_936041.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041109", "story_v_side_old_936041.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_16 = math.max(var_461_9, arg_458_1.talkMaxDuration)

			if var_461_8 <= arg_458_1.time_ and arg_458_1.time_ < var_461_8 + var_461_16 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_8) / var_461_16

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_8 + var_461_16 and arg_458_1.time_ < var_461_8 + var_461_16 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play936041110 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 936041110
		arg_462_1.duration_ = 5.4

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play936041111(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.var_.moveOldPos104402ui_story = arg_462_1.actors_["104402ui_story"].transform.localPosition

				local var_465_0 = GameObjectTools.GetOrAddComponent(arg_462_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_465_0 then
					var_465_0:EnableDynamicBone(false)
				end
			end

			local var_465_1 = 0.001

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_1 then
				arg_462_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos104402ui_story, Vector3.New(0.7, -1, -5.93), (arg_462_1.time_ - 0) / var_465_1)
				arg_462_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_462_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["104402ui_story"].transform.position).z)
				arg_462_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_462_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_462_1.actors_["104402ui_story"].transform.localEulerAngles = arg_462_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_462_1.time_ >= 0 + var_465_1 and arg_462_1.time_ < 0 + var_465_1 + arg_465_0 then
				arg_462_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_462_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_462_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["104402ui_story"].transform.position).z)
				arg_462_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_462_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_462_1.actors_["104402ui_story"].transform.localEulerAngles = arg_462_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_465_2 = GameObjectTools.GetOrAddComponent(arg_462_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_465_2 then
					var_465_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action3_1")
			end

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_465_3 = 0
			local var_465_4 = 0.625

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_3 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_5 = arg_462_1:GetWordFromCfg(936041110)
				local var_465_6 = arg_462_1:FormatText(var_465_5.content)

				arg_462_1.text_.text = var_465_6

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_8 = 25 <= 0 and var_465_4 or var_465_4 * (utf8.len(var_465_6) / 25)

				if (25 <= 0 and var_465_4 or var_465_4 * (utf8.len(var_465_6) / 25)) > 0 and var_465_4 < var_465_8 then
					arg_462_1.talkMaxDuration = var_465_8

					if var_465_8 + var_465_3 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_8 + var_465_3
					end
				end

				arg_462_1.text_.text = var_465_6
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041110", "story_v_side_old_936041.awb") ~= 0 then
					local var_465_9 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041110", "story_v_side_old_936041.awb") / 1000

					if var_465_9 + var_465_3 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_9 + var_465_3
					end

					if var_465_5.prefab_name ~= "" and arg_462_1.actors_[var_465_5.prefab_name] ~= nil then
						local var_465_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_5.prefab_name].transform, "story_v_side_old_936041", "936041110", "story_v_side_old_936041.awb")

						arg_462_1:RecordAudio("936041110", var_465_10)
						arg_462_1:RecordAudio("936041110", var_465_10)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041110", "story_v_side_old_936041.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041110", "story_v_side_old_936041.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_11 = math.max(var_465_4, arg_462_1.talkMaxDuration)

			if var_465_3 <= arg_462_1.time_ and arg_462_1.time_ < var_465_3 + var_465_11 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_3) / var_465_11

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_3 + var_465_11 and arg_462_1.time_ < var_465_3 + var_465_11 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play936041111 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 936041111
		arg_466_1.duration_ = 5.7

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play936041112(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.var_.moveOldPos1066ui_story = arg_466_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_469_0 = 0.001

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 then
				arg_466_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_466_1.time_ - 0) / var_469_0)
				arg_466_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_466_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1066ui_story"].transform.position).z)
				arg_466_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_466_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_466_1.actors_["1066ui_story"].transform.localEulerAngles = arg_466_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 then
				arg_466_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_466_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_466_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1066ui_story"].transform.position).z)
				arg_466_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_466_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_466_1.actors_["1066ui_story"].transform.localEulerAngles = arg_466_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_469_1 = arg_466_1.actors_["1066ui_story"]

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(var_469_1) and arg_466_1.var_.characterEffect1066ui_story == nil then
				arg_466_1.var_.characterEffect1066ui_story = var_469_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_2 and not isNil(var_469_1) then
				if arg_466_1.var_.characterEffect1066ui_story and not isNil(var_469_1) then
					arg_466_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= 0 + var_469_2 and arg_466_1.time_ < 0 + var_469_2 + arg_469_0 and not isNil(var_469_1) and arg_466_1.var_.characterEffect1066ui_story then
				arg_466_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_469_4 = arg_466_1.actors_["104402ui_story"]

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(var_469_4) and arg_466_1.var_.characterEffect104402ui_story == nil then
				arg_466_1.var_.characterEffect104402ui_story = var_469_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_5 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_5 and not isNil(var_469_4) then
				if arg_466_1.var_.characterEffect104402ui_story and not isNil(var_469_4) then
					arg_466_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_466_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_466_1.time_ - 0) / var_469_5)
				end
			end

			if arg_466_1.time_ >= 0 + var_469_5 and arg_466_1.time_ < 0 + var_469_5 + arg_469_0 and not isNil(var_469_4) and arg_466_1.var_.characterEffect104402ui_story then
				arg_466_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_466_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_469_6 = 0
			local var_469_7 = 0.5

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_6 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_8 = arg_466_1:GetWordFromCfg(936041111)
				local var_469_9 = arg_466_1:FormatText(var_469_8.content)

				arg_466_1.text_.text = var_469_9

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_11 = 20 <= 0 and var_469_7 or var_469_7 * (utf8.len(var_469_9) / 20)

				if (20 <= 0 and var_469_7 or var_469_7 * (utf8.len(var_469_9) / 20)) > 0 and var_469_7 < var_469_11 then
					arg_466_1.talkMaxDuration = var_469_11

					if var_469_11 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_11 + var_469_6
					end
				end

				arg_466_1.text_.text = var_469_9
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041111", "story_v_side_old_936041.awb") ~= 0 then
					local var_469_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041111", "story_v_side_old_936041.awb") / 1000

					if var_469_12 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_12 + var_469_6
					end

					if var_469_8.prefab_name ~= "" and arg_466_1.actors_[var_469_8.prefab_name] ~= nil then
						local var_469_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_8.prefab_name].transform, "story_v_side_old_936041", "936041111", "story_v_side_old_936041.awb")

						arg_466_1:RecordAudio("936041111", var_469_13)
						arg_466_1:RecordAudio("936041111", var_469_13)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041111", "story_v_side_old_936041.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041111", "story_v_side_old_936041.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_14 = math.max(var_469_7, arg_466_1.talkMaxDuration)

			if var_469_6 <= arg_466_1.time_ and arg_466_1.time_ < var_469_6 + var_469_14 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_6) / var_469_14

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_6 + var_469_14 and arg_466_1.time_ < var_469_6 + var_469_14 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_466_1:InitPlayNodeList()
	end,
	Play936041112 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 936041112
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play936041113(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(arg_470_1.actors_["1066ui_story"]) and arg_470_1.var_.characterEffect1066ui_story == nil then
				arg_470_1.var_.characterEffect1066ui_story = arg_470_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_0 = 0.200000002980232

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 and not isNil(arg_470_1.actors_["1066ui_story"]) then
				if arg_470_1.var_.characterEffect1066ui_story and not isNil(arg_470_1.actors_["1066ui_story"]) then
					arg_470_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_470_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_470_1.time_ - 0) / var_473_0)
				end
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 and not isNil(arg_470_1.actors_["1066ui_story"]) and arg_470_1.var_.characterEffect1066ui_story then
				arg_470_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_470_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_473_1 = 0
			local var_473_2 = 0.175

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, true)
				arg_470_1.iconController_:SetSelectedState("hero")

				arg_470_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_470_1.callingController_:SetSelectedState("normal")

				arg_470_1.keyicon_.color = Color.New(1, 1, 1)
				arg_470_1.icon_.color = Color.New(1, 1, 1)

				local var_473_3 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(936041112).content)

				arg_470_1.text_.text = var_473_3

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_5 = 7 <= 0 and var_473_2 or var_473_2 * (utf8.len(var_473_3) / 7)

				if (7 <= 0 and var_473_2 or var_473_2 * (utf8.len(var_473_3) / 7)) > 0 and var_473_2 < var_473_5 then
					arg_470_1.talkMaxDuration = var_473_5

					if var_473_5 + var_473_1 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_5 + var_473_1
					end
				end

				arg_470_1.text_.text = var_473_3
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_6 = math.max(var_473_2, arg_470_1.talkMaxDuration)

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_6 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_1) / var_473_6

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_1 + var_473_6 and arg_470_1.time_ < var_473_1 + var_473_6 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play936041113 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 936041113
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play936041114(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos1066ui_story = arg_474_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_477_0 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 then
				arg_474_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_474_1.time_ - 0) / var_477_0)
				arg_474_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).z)
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles = arg_474_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 then
				arg_474_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_474_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).z)
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles = arg_474_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_477_1 = arg_474_1.actors_["104402ui_story"].transform

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos104402ui_story = var_477_1.localPosition

				local var_477_2 = GameObjectTools.GetOrAddComponent(var_477_1.gameObject, typeof(DynamicBoneHelper))

				if var_477_2 then
					var_477_2:EnableDynamicBone(false)
				end
			end

			local var_477_3 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_3 then
				var_477_1.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_474_1.time_ - 0) / var_477_3)
				var_477_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_477_1.position).x, (manager.ui.mainCamera.transform.position - var_477_1.position).y, (manager.ui.mainCamera.transform.position - var_477_1.position).z)
				var_477_1.localEulerAngles.z = 0
				var_477_1.localEulerAngles.x = 0
				var_477_1.localEulerAngles = var_477_1.localEulerAngles
			end

			if arg_474_1.time_ >= 0 + var_477_3 and arg_474_1.time_ < 0 + var_477_3 + arg_477_0 then
				var_477_1.localPosition = Vector3.New(0, 100, 0)
				var_477_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_477_1.position).x, (manager.ui.mainCamera.transform.position - var_477_1.position).y, (manager.ui.mainCamera.transform.position - var_477_1.position).z)
				var_477_1.localEulerAngles.z = 0
				var_477_1.localEulerAngles.x = 0
				var_477_1.localEulerAngles = var_477_1.localEulerAngles

				local var_477_4 = GameObjectTools.GetOrAddComponent(var_477_1.gameObject, typeof(DynamicBoneHelper))

				if var_477_4 then
					var_477_4:EnableDynamicBone(true)
				end
			end

			local var_477_5 = 0
			local var_477_6 = 1

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_5 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_7 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(936041113).content)

				arg_474_1.text_.text = var_477_7

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_9 = 40 <= 0 and var_477_6 or var_477_6 * (utf8.len(var_477_7) / 40)

				if (40 <= 0 and var_477_6 or var_477_6 * (utf8.len(var_477_7) / 40)) > 0 and var_477_6 < var_477_9 then
					arg_474_1.talkMaxDuration = var_477_9

					if var_477_9 + var_477_5 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_9 + var_477_5
					end
				end

				arg_474_1.text_.text = var_477_7
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_10 = math.max(var_477_6, arg_474_1.talkMaxDuration)

			if var_477_5 <= arg_474_1.time_ and arg_474_1.time_ < var_477_5 + var_477_10 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_5) / var_477_10

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_5 + var_477_10 and arg_474_1.time_ < var_477_5 + var_477_10 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play936041114 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 936041114
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play936041115(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_machine03", "")
			end

			local var_481_1 = 0
			local var_481_2 = 0.575

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_3 = arg_478_1:FormatText(arg_478_1:GetWordFromCfg(936041114).content)

				arg_478_1.text_.text = var_481_3

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 23 <= 0 and var_481_2 or var_481_2 * (utf8.len(var_481_3) / 23)

				if (23 <= 0 and var_481_2 or var_481_2 * (utf8.len(var_481_3) / 23)) > 0 and var_481_2 < var_481_5 then
					arg_478_1.talkMaxDuration = var_481_5

					if var_481_5 + var_481_1 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_5 + var_481_1
					end
				end

				arg_478_1.text_.text = var_481_3
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_6 = math.max(var_481_2, arg_478_1.talkMaxDuration)

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_6 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_1) / var_481_6

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_1 + var_481_6 and arg_478_1.time_ < var_481_1 + var_481_6 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play936041115 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 936041115
		arg_482_1.duration_ = 9

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play936041116(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if arg_482_1.bgs_.H08f == nil then
				local var_485_0 = Object.Instantiate(arg_482_1.paintGo_)

				var_485_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H08f")
				var_485_0.name = "H08f"
				var_485_0.transform.parent = arg_482_1.stage_.transform
				var_485_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_482_1.bgs_.H08f = var_485_0
			end

			if 2 < arg_482_1.time_ and arg_482_1.time_ <= 2 + arg_485_0 then
				local var_485_1 = arg_482_1.bgs_.H08f

				arg_482_1.bgs_.H08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_485_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_485_2 = var_485_1:GetComponent("SpriteRenderer")

				if var_485_2 and var_485_2.sprite then
					local var_485_3 = 2 * (var_485_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_485_1.transform.localScale = Vector3.New(var_485_3 / var_485_2.sprite.bounds.size.y < var_485_3 * manager.ui.mainCameraCom_.aspect / var_485_2.sprite.bounds.size.x and var_485_3 * manager.ui.mainCameraCom_.aspect / var_485_2.sprite.bounds.size.x or var_485_3 / var_485_2.sprite.bounds.size.y, var_485_3 / var_485_2.sprite.bounds.size.y < var_485_3 * manager.ui.mainCameraCom_.aspect / var_485_2.sprite.bounds.size.x and var_485_3 * manager.ui.mainCameraCom_.aspect / var_485_2.sprite.bounds.size.x or var_485_3 / var_485_2.sprite.bounds.size.y, 0)
				end

				for iter_485_0, iter_485_1 in pairs(arg_482_1.bgs_) do
					if iter_485_0 ~= "H08f" then
						iter_485_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_485_4 = 4

			if 4 < arg_482_1.time_ and arg_482_1.time_ <= var_485_4 + arg_485_0 then
				arg_482_1.allBtn_.enabled = false
			end

			if arg_482_1.time_ >= var_485_4 + 0.3 and arg_482_1.time_ < var_485_4 + 0.3 + arg_485_0 then
				arg_482_1.allBtn_.enabled = true
			end

			local var_485_5 = 0

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_5 + arg_485_0 then
				arg_482_1.mask_.enabled = true
				arg_482_1.mask_.raycastTarget = true

				arg_482_1:SetGaussion(false)
			end

			local var_485_6 = 2

			if var_485_5 <= arg_482_1.time_ and arg_482_1.time_ < var_485_5 + var_485_6 then
				local var_485_7 = Color.New(0, 0, 0)

				var_485_7.a = Mathf.Lerp(0, 1, (arg_482_1.time_ - var_485_5) / var_485_6)
				arg_482_1.mask_.color = var_485_7
			end

			if arg_482_1.time_ >= var_485_5 + var_485_6 and arg_482_1.time_ < var_485_5 + var_485_6 + arg_485_0 then
				local var_485_8 = Color.New(0, 0, 0)

				var_485_8.a = 1
				arg_482_1.mask_.color = var_485_8
			end

			local var_485_9 = 2

			if 2 < arg_482_1.time_ and arg_482_1.time_ <= var_485_9 + arg_485_0 then
				arg_482_1.mask_.enabled = true
				arg_482_1.mask_.raycastTarget = true

				arg_482_1:SetGaussion(false)
			end

			local var_485_10 = 2

			if var_485_9 <= arg_482_1.time_ and arg_482_1.time_ < var_485_9 + var_485_10 then
				local var_485_11 = Color.New(0, 0, 0)

				var_485_11.a = Mathf.Lerp(1, 0, (arg_482_1.time_ - var_485_9) / var_485_10)
				arg_482_1.mask_.color = var_485_11
			end

			if arg_482_1.time_ >= var_485_9 + var_485_10 and arg_482_1.time_ < var_485_9 + var_485_10 + arg_485_0 then
				local var_485_12 = Color.New(0, 0, 0)

				arg_482_1.mask_.enabled = false
				var_485_12.a = 0
				arg_482_1.mask_.color = var_485_12
			end

			if 0.2 < arg_482_1.time_ and arg_482_1.time_ <= 0.2 + arg_485_0 then
				arg_482_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 1.66666666666667 < arg_482_1.time_ and arg_482_1.time_ <= 1.66666666666667 + arg_485_0 then
				arg_482_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_amb_cheer06_loop", "")
			end

			if arg_482_1.frameCnt_ <= 1 then
				arg_482_1.dialog_:SetActive(false)
			end

			local var_485_15 = 4
			local var_485_16 = 0.1

			if 4 < arg_482_1.time_ and arg_482_1.time_ <= var_485_15 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0

				arg_482_1.dialog_:SetActive(true)

				arg_482_1.dialogCg_.alpha = 0

				local var_485_17 = LeanTween.value(arg_482_1.dialog_, 0, 1, 0.3)

				var_485_17:setOnUpdate(LuaHelper.FloatAction(function(arg_486_0)
					arg_482_1.dialogCg_.alpha = arg_486_0
				end))
				var_485_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_482_1.dialog_)
					var_485_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_482_1.duration_ = arg_482_1.duration_ + 0.3

				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_18 = arg_482_1:FormatText(arg_482_1:GetWordFromCfg(936041115).content)

				arg_482_1.text_.text = var_485_18

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_20 = 4 <= 0 and var_485_16 or var_485_16 * (utf8.len(var_485_18) / 4)

				if (4 <= 0 and var_485_16 or var_485_16 * (utf8.len(var_485_18) / 4)) > 0 and var_485_16 < var_485_20 then
					arg_482_1.talkMaxDuration = var_485_20
					var_485_15 = var_485_15 + 0.3

					if var_485_20 + var_485_15 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_20 + var_485_15
					end
				end

				arg_482_1.text_.text = var_485_18
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_21 = var_485_15 + 0.3
			local var_485_22 = math.max(var_485_16, arg_482_1.talkMaxDuration)

			if var_485_15 + 0.3 <= arg_482_1.time_ and arg_482_1.time_ < var_485_21 + var_485_22 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_21) / var_485_22

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_21 + var_485_22 and arg_482_1.time_ < var_485_21 + var_485_22 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play936041116 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 936041116
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play936041117(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 1.375

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, false)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_1 = arg_488_1:FormatText(arg_488_1:GetWordFromCfg(936041116).content)

				arg_488_1.text_.text = var_491_1

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_3 = 55 <= 0 and var_491_0 or var_491_0 * (utf8.len(var_491_1) / 55)

				if (55 <= 0 and var_491_0 or var_491_0 * (utf8.len(var_491_1) / 55)) > 0 and var_491_0 < var_491_3 then
					arg_488_1.talkMaxDuration = var_491_3

					if var_491_3 + 0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_3 + 0
					end
				end

				arg_488_1.text_.text = var_491_1
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_4 = math.max(var_491_0, arg_488_1.talkMaxDuration)

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_4 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - 0) / var_491_4

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= 0 + var_491_4 and arg_488_1.time_ < 0 + var_491_4 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play936041117 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 936041117
		arg_492_1.duration_ = 2

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play936041118(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.var_.moveOldPos104402ui_story = arg_492_1.actors_["104402ui_story"].transform.localPosition

				local var_495_0 = GameObjectTools.GetOrAddComponent(arg_492_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_495_0 then
					var_495_0:EnableDynamicBone(false)
				end
			end

			local var_495_1 = 0.001

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_1 then
				arg_492_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_492_1.time_ - 0) / var_495_1)
				arg_492_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_492_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["104402ui_story"].transform.position).z)
				arg_492_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_492_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_492_1.actors_["104402ui_story"].transform.localEulerAngles = arg_492_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_492_1.time_ >= 0 + var_495_1 and arg_492_1.time_ < 0 + var_495_1 + arg_495_0 then
				arg_492_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_492_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_492_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["104402ui_story"].transform.position).z)
				arg_492_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_492_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_492_1.actors_["104402ui_story"].transform.localEulerAngles = arg_492_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_495_2 = GameObjectTools.GetOrAddComponent(arg_492_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_495_2 then
					var_495_2:EnableDynamicBone(true)
				end
			end

			local var_495_3 = arg_492_1.actors_["104402ui_story"]

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(var_495_3) and arg_492_1.var_.characterEffect104402ui_story == nil then
				arg_492_1.var_.characterEffect104402ui_story = var_495_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_4 = 0.200000002980232

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_4 and not isNil(var_495_3) then
				if arg_492_1.var_.characterEffect104402ui_story and not isNil(var_495_3) then
					arg_492_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_492_1.time_ >= 0 + var_495_4 and arg_492_1.time_ < 0 + var_495_4 + arg_495_0 and not isNil(var_495_3) and arg_492_1.var_.characterEffect104402ui_story then
				arg_492_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_495_6 = 0
			local var_495_7 = 0.125

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_6 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_8 = arg_492_1:GetWordFromCfg(936041117)
				local var_495_9 = arg_492_1:FormatText(var_495_8.content)

				arg_492_1.text_.text = var_495_9

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_11 = 5 <= 0 and var_495_7 or var_495_7 * (utf8.len(var_495_9) / 5)

				if (5 <= 0 and var_495_7 or var_495_7 * (utf8.len(var_495_9) / 5)) > 0 and var_495_7 < var_495_11 then
					arg_492_1.talkMaxDuration = var_495_11

					if var_495_11 + var_495_6 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_11 + var_495_6
					end
				end

				arg_492_1.text_.text = var_495_9
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041117", "story_v_side_old_936041.awb") ~= 0 then
					local var_495_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041117", "story_v_side_old_936041.awb") / 1000

					if var_495_12 + var_495_6 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_12 + var_495_6
					end

					if var_495_8.prefab_name ~= "" and arg_492_1.actors_[var_495_8.prefab_name] ~= nil then
						local var_495_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_8.prefab_name].transform, "story_v_side_old_936041", "936041117", "story_v_side_old_936041.awb")

						arg_492_1:RecordAudio("936041117", var_495_13)
						arg_492_1:RecordAudio("936041117", var_495_13)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041117", "story_v_side_old_936041.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041117", "story_v_side_old_936041.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_14 = math.max(var_495_7, arg_492_1.talkMaxDuration)

			if var_495_6 <= arg_492_1.time_ and arg_492_1.time_ < var_495_6 + var_495_14 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_6) / var_495_14

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_6 + var_495_14 and arg_492_1.time_ < var_495_6 + var_495_14 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play936041118 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 936041118
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play936041119(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.var_.moveOldPos104402ui_story = arg_496_1.actors_["104402ui_story"].transform.localPosition

				local var_499_0 = GameObjectTools.GetOrAddComponent(arg_496_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_499_0 then
					var_499_0:EnableDynamicBone(false)
				end
			end

			local var_499_1 = 0.001

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_1 then
				arg_496_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_496_1.time_ - 0) / var_499_1)
				arg_496_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_496_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["104402ui_story"].transform.position).z)
				arg_496_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_496_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_496_1.actors_["104402ui_story"].transform.localEulerAngles = arg_496_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_496_1.time_ >= 0 + var_499_1 and arg_496_1.time_ < 0 + var_499_1 + arg_499_0 then
				arg_496_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_496_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_496_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["104402ui_story"].transform.position).z)
				arg_496_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_496_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_496_1.actors_["104402ui_story"].transform.localEulerAngles = arg_496_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_499_2 = GameObjectTools.GetOrAddComponent(arg_496_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_499_2 then
					var_499_2:EnableDynamicBone(true)
				end
			end

			local var_499_3 = arg_496_1.actors_["104402ui_story"]

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(var_499_3) and arg_496_1.var_.characterEffect104402ui_story == nil then
				arg_496_1.var_.characterEffect104402ui_story = var_499_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_4 = 0.200000002980232

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_4 and not isNil(var_499_3) then
				if arg_496_1.var_.characterEffect104402ui_story and not isNil(var_499_3) then
					arg_496_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_496_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_496_1.time_ - 0) / var_499_4)
				end
			end

			if arg_496_1.time_ >= 0 + var_499_4 and arg_496_1.time_ < 0 + var_499_4 + arg_499_0 and not isNil(var_499_3) and arg_496_1.var_.characterEffect104402ui_story then
				arg_496_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_496_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_499_5 = 0
			local var_499_6 = 1

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_5 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_7 = arg_496_1:FormatText(arg_496_1:GetWordFromCfg(936041118).content)

				arg_496_1.text_.text = var_499_7

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_9 = 40 <= 0 and var_499_6 or var_499_6 * (utf8.len(var_499_7) / 40)

				if (40 <= 0 and var_499_6 or var_499_6 * (utf8.len(var_499_7) / 40)) > 0 and var_499_6 < var_499_9 then
					arg_496_1.talkMaxDuration = var_499_9

					if var_499_9 + var_499_5 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_9 + var_499_5
					end
				end

				arg_496_1.text_.text = var_499_7
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_10 = math.max(var_499_6, arg_496_1.talkMaxDuration)

			if var_499_5 <= arg_496_1.time_ and arg_496_1.time_ < var_499_5 + var_499_10 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_5) / var_499_10

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_5 + var_499_10 and arg_496_1.time_ < var_499_5 + var_499_10 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play936041119 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 936041119
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play936041120(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0.225

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, true)
				arg_500_1.iconController_:SetSelectedState("hero")

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_1 = arg_500_1:FormatText(arg_500_1:GetWordFromCfg(936041119).content)

				arg_500_1.text_.text = var_503_1

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_3 = 9 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 9)

				if (9 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 9)) > 0 and var_503_0 < var_503_3 then
					arg_500_1.talkMaxDuration = var_503_3

					if var_503_3 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_3 + 0
					end
				end

				arg_500_1.text_.text = var_503_1
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_4 = math.max(var_503_0, arg_500_1.talkMaxDuration)

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_4 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - 0) / var_503_4

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= 0 + var_503_4 and arg_500_1.time_ < 0 + var_503_4 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play936041120 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 936041120
		arg_504_1.duration_ = 2

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play936041121(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1.var_.moveOldPos104402ui_story = arg_504_1.actors_["104402ui_story"].transform.localPosition

				local var_507_0 = GameObjectTools.GetOrAddComponent(arg_504_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_507_0 then
					var_507_0:EnableDynamicBone(false)
				end
			end

			local var_507_1 = 0.001

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_1 then
				arg_504_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_504_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_504_1.time_ - 0) / var_507_1)
				arg_504_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_504_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["104402ui_story"].transform.position).z)
				arg_504_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_504_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_504_1.actors_["104402ui_story"].transform.localEulerAngles = arg_504_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_504_1.time_ >= 0 + var_507_1 and arg_504_1.time_ < 0 + var_507_1 + arg_507_0 then
				arg_504_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_504_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_504_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["104402ui_story"].transform.position).z)
				arg_504_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_504_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_504_1.actors_["104402ui_story"].transform.localEulerAngles = arg_504_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_507_2 = GameObjectTools.GetOrAddComponent(arg_504_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_507_2 then
					var_507_2:EnableDynamicBone(true)
				end
			end

			local var_507_3 = arg_504_1.actors_["104402ui_story"]

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 and not isNil(var_507_3) and arg_504_1.var_.characterEffect104402ui_story == nil then
				arg_504_1.var_.characterEffect104402ui_story = var_507_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_4 = 0.200000002980232

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_4 and not isNil(var_507_3) then
				if arg_504_1.var_.characterEffect104402ui_story and not isNil(var_507_3) then
					arg_504_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_504_1.time_ >= 0 + var_507_4 and arg_504_1.time_ < 0 + var_507_4 + arg_507_0 and not isNil(var_507_3) and arg_504_1.var_.characterEffect104402ui_story then
				arg_504_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_1")
			end

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_507_6 = 0
			local var_507_7 = 0.225

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_6 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_8 = arg_504_1:GetWordFromCfg(936041120)
				local var_507_9 = arg_504_1:FormatText(var_507_8.content)

				arg_504_1.text_.text = var_507_9

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_11 = 9 <= 0 and var_507_7 or var_507_7 * (utf8.len(var_507_9) / 9)

				if (9 <= 0 and var_507_7 or var_507_7 * (utf8.len(var_507_9) / 9)) > 0 and var_507_7 < var_507_11 then
					arg_504_1.talkMaxDuration = var_507_11

					if var_507_11 + var_507_6 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_11 + var_507_6
					end
				end

				arg_504_1.text_.text = var_507_9
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041120", "story_v_side_old_936041.awb") ~= 0 then
					local var_507_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041120", "story_v_side_old_936041.awb") / 1000

					if var_507_12 + var_507_6 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_12 + var_507_6
					end

					if var_507_8.prefab_name ~= "" and arg_504_1.actors_[var_507_8.prefab_name] ~= nil then
						local var_507_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_8.prefab_name].transform, "story_v_side_old_936041", "936041120", "story_v_side_old_936041.awb")

						arg_504_1:RecordAudio("936041120", var_507_13)
						arg_504_1:RecordAudio("936041120", var_507_13)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041120", "story_v_side_old_936041.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041120", "story_v_side_old_936041.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_14 = math.max(var_507_7, arg_504_1.talkMaxDuration)

			if var_507_6 <= arg_504_1.time_ and arg_504_1.time_ < var_507_6 + var_507_14 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_6) / var_507_14

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_6 + var_507_14 and arg_504_1.time_ < var_507_6 + var_507_14 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_504_1:InitPlayNodeList()
	end,
	Play936041121 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 936041121
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play936041122(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(arg_508_1.actors_["104402ui_story"]) and arg_508_1.var_.characterEffect104402ui_story == nil then
				arg_508_1.var_.characterEffect104402ui_story = arg_508_1.actors_["104402ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_0 = 0.200000002980232

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_0 and not isNil(arg_508_1.actors_["104402ui_story"]) then
				if arg_508_1.var_.characterEffect104402ui_story and not isNil(arg_508_1.actors_["104402ui_story"]) then
					arg_508_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_508_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_508_1.time_ - 0) / var_511_0)
				end
			end

			if arg_508_1.time_ >= 0 + var_511_0 and arg_508_1.time_ < 0 + var_511_0 + arg_511_0 and not isNil(arg_508_1.actors_["104402ui_story"]) and arg_508_1.var_.characterEffect104402ui_story then
				arg_508_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_508_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			local var_511_1 = 0
			local var_511_2 = 0.15

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_3 = arg_508_1:FormatText(arg_508_1:GetWordFromCfg(936041121).content)

				arg_508_1.text_.text = var_511_3

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_5 = 6 <= 0 and var_511_2 or var_511_2 * (utf8.len(var_511_3) / 6)

				if (6 <= 0 and var_511_2 or var_511_2 * (utf8.len(var_511_3) / 6)) > 0 and var_511_2 < var_511_5 then
					arg_508_1.talkMaxDuration = var_511_5

					if var_511_5 + var_511_1 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_5 + var_511_1
					end
				end

				arg_508_1.text_.text = var_511_3
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_6 = math.max(var_511_2, arg_508_1.talkMaxDuration)

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_6 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_1) / var_511_6

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_1 + var_511_6 and arg_508_1.time_ < var_511_1 + var_511_6 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play936041122 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 936041122
		arg_512_1.duration_ = 2.17

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play936041123(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.var_.moveOldPos121102ui_story = arg_512_1.actors_["121102ui_story"].transform.localPosition

				local var_515_0 = GameObjectTools.GetOrAddComponent(arg_512_1.actors_["121102ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_515_0 then
					var_515_0:EnableDynamicBone(false)
				end
			end

			local var_515_1 = 0.001

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_1 then
				arg_512_1.actors_["121102ui_story"].transform.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos121102ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_512_1.time_ - 0) / var_515_1)
				arg_512_1.actors_["121102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_512_1.actors_["121102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["121102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["121102ui_story"].transform.position).z)
				arg_512_1.actors_["121102ui_story"].transform.localEulerAngles.z = 0
				arg_512_1.actors_["121102ui_story"].transform.localEulerAngles.x = 0
				arg_512_1.actors_["121102ui_story"].transform.localEulerAngles = arg_512_1.actors_["121102ui_story"].transform.localEulerAngles
			end

			if arg_512_1.time_ >= 0 + var_515_1 and arg_512_1.time_ < 0 + var_515_1 + arg_515_0 then
				arg_512_1.actors_["121102ui_story"].transform.localPosition = Vector3.New(0.7, -0.67, -6.07)
				arg_512_1.actors_["121102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_512_1.actors_["121102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["121102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["121102ui_story"].transform.position).z)
				arg_512_1.actors_["121102ui_story"].transform.localEulerAngles.z = 0
				arg_512_1.actors_["121102ui_story"].transform.localEulerAngles.x = 0
				arg_512_1.actors_["121102ui_story"].transform.localEulerAngles = arg_512_1.actors_["121102ui_story"].transform.localEulerAngles

				local var_515_2 = GameObjectTools.GetOrAddComponent(arg_512_1.actors_["121102ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_515_2 then
					var_515_2:EnableDynamicBone(true)
				end
			end

			local var_515_3 = arg_512_1.actors_["104402ui_story"].transform

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.var_.moveOldPos104402ui_story = var_515_3.localPosition

				local var_515_4 = GameObjectTools.GetOrAddComponent(var_515_3.gameObject, typeof(DynamicBoneHelper))

				if var_515_4 then
					var_515_4:EnableDynamicBone(false)
				end
			end

			local var_515_5 = 0.001

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_5 then
				var_515_3.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos104402ui_story, Vector3.New(-0.7, -1, -5.93), (arg_512_1.time_ - 0) / var_515_5)
				var_515_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_515_3.position).x, (manager.ui.mainCamera.transform.position - var_515_3.position).y, (manager.ui.mainCamera.transform.position - var_515_3.position).z)
				var_515_3.localEulerAngles.z = 0
				var_515_3.localEulerAngles.x = 0
				var_515_3.localEulerAngles = var_515_3.localEulerAngles
			end

			if arg_512_1.time_ >= 0 + var_515_5 and arg_512_1.time_ < 0 + var_515_5 + arg_515_0 then
				var_515_3.localPosition = Vector3.New(-0.7, -1, -5.93)
				var_515_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_515_3.position).x, (manager.ui.mainCamera.transform.position - var_515_3.position).y, (manager.ui.mainCamera.transform.position - var_515_3.position).z)
				var_515_3.localEulerAngles.z = 0
				var_515_3.localEulerAngles.x = 0
				var_515_3.localEulerAngles = var_515_3.localEulerAngles

				local var_515_6 = GameObjectTools.GetOrAddComponent(var_515_3.gameObject, typeof(DynamicBoneHelper))

				if var_515_6 then
					var_515_6:EnableDynamicBone(true)
				end
			end

			local var_515_7 = arg_512_1.actors_["121102ui_story"]

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(var_515_7) and arg_512_1.var_.characterEffect121102ui_story == nil then
				arg_512_1.var_.characterEffect121102ui_story = var_515_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_8 = 0.200000002980232

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_8 and not isNil(var_515_7) then
				if arg_512_1.var_.characterEffect121102ui_story and not isNil(var_515_7) then
					arg_512_1.var_.characterEffect121102ui_story.fillFlat = false
				end
			end

			if arg_512_1.time_ >= 0 + var_515_8 and arg_512_1.time_ < 0 + var_515_8 + arg_515_0 and not isNil(var_515_7) and arg_512_1.var_.characterEffect121102ui_story then
				arg_512_1.var_.characterEffect121102ui_story.fillFlat = false
			end

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1:PlayTimeline("121102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_515_10 = 0
			local var_515_11 = 0.225

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_10 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_12 = arg_512_1:GetWordFromCfg(936041122)
				local var_515_13 = arg_512_1:FormatText(var_515_12.content)

				arg_512_1.text_.text = var_515_13

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_15 = 9 <= 0 and var_515_11 or var_515_11 * (utf8.len(var_515_13) / 9)

				if (9 <= 0 and var_515_11 or var_515_11 * (utf8.len(var_515_13) / 9)) > 0 and var_515_11 < var_515_15 then
					arg_512_1.talkMaxDuration = var_515_15

					if var_515_15 + var_515_10 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_15 + var_515_10
					end
				end

				arg_512_1.text_.text = var_515_13
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041122", "story_v_side_old_936041.awb") ~= 0 then
					local var_515_16 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041122", "story_v_side_old_936041.awb") / 1000

					if var_515_16 + var_515_10 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_16 + var_515_10
					end

					if var_515_12.prefab_name ~= "" and arg_512_1.actors_[var_515_12.prefab_name] ~= nil then
						local var_515_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_12.prefab_name].transform, "story_v_side_old_936041", "936041122", "story_v_side_old_936041.awb")

						arg_512_1:RecordAudio("936041122", var_515_17)
						arg_512_1:RecordAudio("936041122", var_515_17)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041122", "story_v_side_old_936041.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041122", "story_v_side_old_936041.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_18 = math.max(var_515_11, arg_512_1.talkMaxDuration)

			if var_515_10 <= arg_512_1.time_ and arg_512_1.time_ < var_515_10 + var_515_18 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_10) / var_515_18

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_10 + var_515_18 and arg_512_1.time_ < var_515_10 + var_515_18 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_512_1:InitPlayNodeList()
	end,
	Play936041123 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 936041123
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play936041124(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 and not isNil(arg_516_1.actors_["121102ui_story"]) and arg_516_1.var_.characterEffect121102ui_story == nil then
				arg_516_1.var_.characterEffect121102ui_story = arg_516_1.actors_["121102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_0 = 0.200000002980232

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_0 and not isNil(arg_516_1.actors_["121102ui_story"]) then
				if arg_516_1.var_.characterEffect121102ui_story and not isNil(arg_516_1.actors_["121102ui_story"]) then
					arg_516_1.var_.characterEffect121102ui_story.fillFlat = true
					arg_516_1.var_.characterEffect121102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_516_1.time_ - 0) / var_519_0)
				end
			end

			if arg_516_1.time_ >= 0 + var_519_0 and arg_516_1.time_ < 0 + var_519_0 + arg_519_0 and not isNil(arg_516_1.actors_["121102ui_story"]) and arg_516_1.var_.characterEffect121102ui_story then
				arg_516_1.var_.characterEffect121102ui_story.fillFlat = true
				arg_516_1.var_.characterEffect121102ui_story.fillRatio = 0.5
			end

			local var_519_1 = 0
			local var_519_2 = 1.1

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, false)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_3 = arg_516_1:FormatText(arg_516_1:GetWordFromCfg(936041123).content)

				arg_516_1.text_.text = var_519_3

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_5 = 44 <= 0 and var_519_2 or var_519_2 * (utf8.len(var_519_3) / 44)

				if (44 <= 0 and var_519_2 or var_519_2 * (utf8.len(var_519_3) / 44)) > 0 and var_519_2 < var_519_5 then
					arg_516_1.talkMaxDuration = var_519_5

					if var_519_5 + var_519_1 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_5 + var_519_1
					end
				end

				arg_516_1.text_.text = var_519_3
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_6 = math.max(var_519_2, arg_516_1.talkMaxDuration)

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_6 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_1) / var_519_6

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_1 + var_519_6 and arg_516_1.time_ < var_519_1 + var_519_6 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play936041124 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 936041124
		arg_520_1.duration_ = 3.53

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play936041125(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.var_.moveOldPos121102ui_story = arg_520_1.actors_["121102ui_story"].transform.localPosition

				local var_523_0 = GameObjectTools.GetOrAddComponent(arg_520_1.actors_["121102ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_523_0 then
					var_523_0:EnableDynamicBone(false)
				end
			end

			local var_523_1 = 0.001

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_1 then
				arg_520_1.actors_["121102ui_story"].transform.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos121102ui_story, Vector3.New(0, 100, 0), (arg_520_1.time_ - 0) / var_523_1)
				arg_520_1.actors_["121102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_520_1.actors_["121102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["121102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["121102ui_story"].transform.position).z)
				arg_520_1.actors_["121102ui_story"].transform.localEulerAngles.z = 0
				arg_520_1.actors_["121102ui_story"].transform.localEulerAngles.x = 0
				arg_520_1.actors_["121102ui_story"].transform.localEulerAngles = arg_520_1.actors_["121102ui_story"].transform.localEulerAngles
			end

			if arg_520_1.time_ >= 0 + var_523_1 and arg_520_1.time_ < 0 + var_523_1 + arg_523_0 then
				arg_520_1.actors_["121102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_520_1.actors_["121102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_520_1.actors_["121102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["121102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["121102ui_story"].transform.position).z)
				arg_520_1.actors_["121102ui_story"].transform.localEulerAngles.z = 0
				arg_520_1.actors_["121102ui_story"].transform.localEulerAngles.x = 0
				arg_520_1.actors_["121102ui_story"].transform.localEulerAngles = arg_520_1.actors_["121102ui_story"].transform.localEulerAngles

				local var_523_2 = GameObjectTools.GetOrAddComponent(arg_520_1.actors_["121102ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_523_2 then
					var_523_2:EnableDynamicBone(true)
				end
			end

			local var_523_3 = arg_520_1.actors_["104402ui_story"].transform

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.var_.moveOldPos104402ui_story = var_523_3.localPosition

				local var_523_4 = GameObjectTools.GetOrAddComponent(var_523_3.gameObject, typeof(DynamicBoneHelper))

				if var_523_4 then
					var_523_4:EnableDynamicBone(false)
				end
			end

			local var_523_5 = 0.001

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_5 then
				var_523_3.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_520_1.time_ - 0) / var_523_5)
				var_523_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_523_3.position).x, (manager.ui.mainCamera.transform.position - var_523_3.position).y, (manager.ui.mainCamera.transform.position - var_523_3.position).z)
				var_523_3.localEulerAngles.z = 0
				var_523_3.localEulerAngles.x = 0
				var_523_3.localEulerAngles = var_523_3.localEulerAngles
			end

			if arg_520_1.time_ >= 0 + var_523_5 and arg_520_1.time_ < 0 + var_523_5 + arg_523_0 then
				var_523_3.localPosition = Vector3.New(0, 100, 0)
				var_523_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_523_3.position).x, (manager.ui.mainCamera.transform.position - var_523_3.position).y, (manager.ui.mainCamera.transform.position - var_523_3.position).z)
				var_523_3.localEulerAngles.z = 0
				var_523_3.localEulerAngles.x = 0
				var_523_3.localEulerAngles = var_523_3.localEulerAngles

				local var_523_6 = GameObjectTools.GetOrAddComponent(var_523_3.gameObject, typeof(DynamicBoneHelper))

				if var_523_6 then
					var_523_6:EnableDynamicBone(true)
				end
			end

			local var_523_7 = arg_520_1.actors_["105401ui_story"]

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 and not isNil(var_523_7) and arg_520_1.var_.characterEffect105401ui_story == nil then
				arg_520_1.var_.characterEffect105401ui_story = var_523_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_523_8 = 0.200000002980232

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_8 and not isNil(var_523_7) then
				if arg_520_1.var_.characterEffect105401ui_story and not isNil(var_523_7) then
					arg_520_1.var_.characterEffect105401ui_story.fillFlat = false
				end
			end

			if arg_520_1.time_ >= 0 + var_523_8 and arg_520_1.time_ < 0 + var_523_8 + arg_523_0 and not isNil(var_523_7) and arg_520_1.var_.characterEffect105401ui_story then
				arg_520_1.var_.characterEffect105401ui_story.fillFlat = false
			end

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action7_1")
			end

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1:PlayTimeline("105401ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_523_10 = arg_520_1.actors_["105401ui_story"].transform

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.var_.moveOldPos105401ui_story = var_523_10.localPosition

				local var_523_11 = GameObjectTools.GetOrAddComponent(var_523_10.gameObject, typeof(DynamicBoneHelper))

				if var_523_11 then
					var_523_11:EnableDynamicBone(false)
				end
			end

			local var_523_12 = 0.001

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_12 then
				var_523_10.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos105401ui_story, Vector3.New(0, -0.985, -6), (arg_520_1.time_ - 0) / var_523_12)
				var_523_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_523_10.position).x, (manager.ui.mainCamera.transform.position - var_523_10.position).y, (manager.ui.mainCamera.transform.position - var_523_10.position).z)
				var_523_10.localEulerAngles.z = 0
				var_523_10.localEulerAngles.x = 0
				var_523_10.localEulerAngles = var_523_10.localEulerAngles
			end

			if arg_520_1.time_ >= 0 + var_523_12 and arg_520_1.time_ < 0 + var_523_12 + arg_523_0 then
				var_523_10.localPosition = Vector3.New(0, -0.985, -6)
				var_523_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_523_10.position).x, (manager.ui.mainCamera.transform.position - var_523_10.position).y, (manager.ui.mainCamera.transform.position - var_523_10.position).z)
				var_523_10.localEulerAngles.z = 0
				var_523_10.localEulerAngles.x = 0
				var_523_10.localEulerAngles = var_523_10.localEulerAngles

				local var_523_13 = GameObjectTools.GetOrAddComponent(var_523_10.gameObject, typeof(DynamicBoneHelper))

				if var_523_13 then
					var_523_13:EnableDynamicBone(true)
				end
			end

			local var_523_14 = 0
			local var_523_15 = 0.475

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_14 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_16 = arg_520_1:GetWordFromCfg(936041124)
				local var_523_17 = arg_520_1:FormatText(var_523_16.content)

				arg_520_1.text_.text = var_523_17

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_19 = 19 <= 0 and var_523_15 or var_523_15 * (utf8.len(var_523_17) / 19)

				if (19 <= 0 and var_523_15 or var_523_15 * (utf8.len(var_523_17) / 19)) > 0 and var_523_15 < var_523_19 then
					arg_520_1.talkMaxDuration = var_523_19

					if var_523_19 + var_523_14 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_19 + var_523_14
					end
				end

				arg_520_1.text_.text = var_523_17
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041124", "story_v_side_old_936041.awb") ~= 0 then
					local var_523_20 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041124", "story_v_side_old_936041.awb") / 1000

					if var_523_20 + var_523_14 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_20 + var_523_14
					end

					if var_523_16.prefab_name ~= "" and arg_520_1.actors_[var_523_16.prefab_name] ~= nil then
						local var_523_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_16.prefab_name].transform, "story_v_side_old_936041", "936041124", "story_v_side_old_936041.awb")

						arg_520_1:RecordAudio("936041124", var_523_21)
						arg_520_1:RecordAudio("936041124", var_523_21)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041124", "story_v_side_old_936041.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041124", "story_v_side_old_936041.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_22 = math.max(var_523_15, arg_520_1.talkMaxDuration)

			if var_523_14 <= arg_520_1.time_ and arg_520_1.time_ < var_523_14 + var_523_22 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_14) / var_523_22

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_14 + var_523_22 and arg_520_1.time_ < var_523_14 + var_523_22 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "121102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_520_1:InitPlayNodeList()
	end,
	Play936041125 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 936041125
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play936041126(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 and not isNil(arg_524_1.actors_["105401ui_story"]) and arg_524_1.var_.characterEffect105401ui_story == nil then
				arg_524_1.var_.characterEffect105401ui_story = arg_524_1.actors_["105401ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_0 = 0.200000002980232

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_0 and not isNil(arg_524_1.actors_["105401ui_story"]) then
				if arg_524_1.var_.characterEffect105401ui_story and not isNil(arg_524_1.actors_["105401ui_story"]) then
					arg_524_1.var_.characterEffect105401ui_story.fillFlat = true
					arg_524_1.var_.characterEffect105401ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_524_1.time_ - 0) / var_527_0)
				end
			end

			if arg_524_1.time_ >= 0 + var_527_0 and arg_524_1.time_ < 0 + var_527_0 + arg_527_0 and not isNil(arg_524_1.actors_["105401ui_story"]) and arg_524_1.var_.characterEffect105401ui_story then
				arg_524_1.var_.characterEffect105401ui_story.fillFlat = true
				arg_524_1.var_.characterEffect105401ui_story.fillRatio = 0.5
			end

			local var_527_1 = 0
			local var_527_2 = 0.25

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_3 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(936041125).content)

				arg_524_1.text_.text = var_527_3

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_5 = 10 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_3) / 10)

				if (10 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_3) / 10)) > 0 and var_527_2 < var_527_5 then
					arg_524_1.talkMaxDuration = var_527_5

					if var_527_5 + var_527_1 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_5 + var_527_1
					end
				end

				arg_524_1.text_.text = var_527_3
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_6 = math.max(var_527_2, arg_524_1.talkMaxDuration)

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_6 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_1) / var_527_6

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_1 + var_527_6 and arg_524_1.time_ < var_527_1 + var_527_6 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play936041126 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 936041126
		arg_528_1.duration_ = 4.5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play936041127(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.var_.moveOldPos104402ui_story = arg_528_1.actors_["104402ui_story"].transform.localPosition

				local var_531_0 = GameObjectTools.GetOrAddComponent(arg_528_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_531_0 then
					var_531_0:EnableDynamicBone(false)
				end
			end

			local var_531_1 = 0.001

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_1 then
				arg_528_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_528_1.time_ - 0) / var_531_1)
				arg_528_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_528_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_528_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_528_1.actors_["104402ui_story"].transform.position).z)
				arg_528_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_528_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_528_1.actors_["104402ui_story"].transform.localEulerAngles = arg_528_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_528_1.time_ >= 0 + var_531_1 and arg_528_1.time_ < 0 + var_531_1 + arg_531_0 then
				arg_528_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_528_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_528_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_528_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_528_1.actors_["104402ui_story"].transform.position).z)
				arg_528_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_528_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_528_1.actors_["104402ui_story"].transform.localEulerAngles = arg_528_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_531_2 = GameObjectTools.GetOrAddComponent(arg_528_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_531_2 then
					var_531_2:EnableDynamicBone(true)
				end
			end

			local var_531_3 = arg_528_1.actors_["104402ui_story"]

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 and not isNil(var_531_3) and arg_528_1.var_.characterEffect104402ui_story == nil then
				arg_528_1.var_.characterEffect104402ui_story = var_531_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_4 = 0.200000002980232

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_4 and not isNil(var_531_3) then
				if arg_528_1.var_.characterEffect104402ui_story and not isNil(var_531_3) then
					arg_528_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_528_1.time_ >= 0 + var_531_4 and arg_528_1.time_ < 0 + var_531_4 + arg_531_0 and not isNil(var_531_3) and arg_528_1.var_.characterEffect104402ui_story then
				arg_528_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action5_1")
			end

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_531_6 = arg_528_1.actors_["105401ui_story"].transform

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.var_.moveOldPos105401ui_story = var_531_6.localPosition

				local var_531_7 = GameObjectTools.GetOrAddComponent(var_531_6.gameObject, typeof(DynamicBoneHelper))

				if var_531_7 then
					var_531_7:EnableDynamicBone(false)
				end
			end

			local var_531_8 = 0.001

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_8 then
				var_531_6.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos105401ui_story, Vector3.New(0, 100, 0), (arg_528_1.time_ - 0) / var_531_8)
				var_531_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_531_6.position).x, (manager.ui.mainCamera.transform.position - var_531_6.position).y, (manager.ui.mainCamera.transform.position - var_531_6.position).z)
				var_531_6.localEulerAngles.z = 0
				var_531_6.localEulerAngles.x = 0
				var_531_6.localEulerAngles = var_531_6.localEulerAngles
			end

			if arg_528_1.time_ >= 0 + var_531_8 and arg_528_1.time_ < 0 + var_531_8 + arg_531_0 then
				var_531_6.localPosition = Vector3.New(0, 100, 0)
				var_531_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_531_6.position).x, (manager.ui.mainCamera.transform.position - var_531_6.position).y, (manager.ui.mainCamera.transform.position - var_531_6.position).z)
				var_531_6.localEulerAngles.z = 0
				var_531_6.localEulerAngles.x = 0
				var_531_6.localEulerAngles = var_531_6.localEulerAngles

				local var_531_9 = GameObjectTools.GetOrAddComponent(var_531_6.gameObject, typeof(DynamicBoneHelper))

				if var_531_9 then
					var_531_9:EnableDynamicBone(true)
				end
			end

			local var_531_10 = 0
			local var_531_11 = 0.4

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_10 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_12 = arg_528_1:GetWordFromCfg(936041126)
				local var_531_13 = arg_528_1:FormatText(var_531_12.content)

				arg_528_1.text_.text = var_531_13

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_15 = 16 <= 0 and var_531_11 or var_531_11 * (utf8.len(var_531_13) / 16)

				if (16 <= 0 and var_531_11 or var_531_11 * (utf8.len(var_531_13) / 16)) > 0 and var_531_11 < var_531_15 then
					arg_528_1.talkMaxDuration = var_531_15

					if var_531_15 + var_531_10 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_15 + var_531_10
					end
				end

				arg_528_1.text_.text = var_531_13
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041126", "story_v_side_old_936041.awb") ~= 0 then
					local var_531_16 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041126", "story_v_side_old_936041.awb") / 1000

					if var_531_16 + var_531_10 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_16 + var_531_10
					end

					if var_531_12.prefab_name ~= "" and arg_528_1.actors_[var_531_12.prefab_name] ~= nil then
						local var_531_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_12.prefab_name].transform, "story_v_side_old_936041", "936041126", "story_v_side_old_936041.awb")

						arg_528_1:RecordAudio("936041126", var_531_17)
						arg_528_1:RecordAudio("936041126", var_531_17)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041126", "story_v_side_old_936041.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041126", "story_v_side_old_936041.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_18 = math.max(var_531_11, arg_528_1.talkMaxDuration)

			if var_531_10 <= arg_528_1.time_ and arg_528_1.time_ < var_531_10 + var_531_18 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_10) / var_531_18

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_10 + var_531_18 and arg_528_1.time_ < var_531_10 + var_531_18 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105401ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_528_1:InitPlayNodeList()
	end,
	Play936041127 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 936041127
		arg_532_1.duration_ = 4.87

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play936041128(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.var_.moveOldPos104402ui_story = arg_532_1.actors_["104402ui_story"].transform.localPosition

				local var_535_0 = GameObjectTools.GetOrAddComponent(arg_532_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_535_0 then
					var_535_0:EnableDynamicBone(false)
				end
			end

			local var_535_1 = 0.001

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_1 then
				arg_532_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_532_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_532_1.time_ - 0) / var_535_1)
				arg_532_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_532_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_532_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_532_1.actors_["104402ui_story"].transform.position).z)
				arg_532_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_532_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_532_1.actors_["104402ui_story"].transform.localEulerAngles = arg_532_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_532_1.time_ >= 0 + var_535_1 and arg_532_1.time_ < 0 + var_535_1 + arg_535_0 then
				arg_532_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_532_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_532_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_532_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_532_1.actors_["104402ui_story"].transform.position).z)
				arg_532_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_532_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_532_1.actors_["104402ui_story"].transform.localEulerAngles = arg_532_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_535_2 = GameObjectTools.GetOrAddComponent(arg_532_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_535_2 then
					var_535_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action5_2")
			end

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_535_3 = 0
			local var_535_4 = 0.55

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_3 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_5 = arg_532_1:GetWordFromCfg(936041127)
				local var_535_6 = arg_532_1:FormatText(var_535_5.content)

				arg_532_1.text_.text = var_535_6

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_8 = 22 <= 0 and var_535_4 or var_535_4 * (utf8.len(var_535_6) / 22)

				if (22 <= 0 and var_535_4 or var_535_4 * (utf8.len(var_535_6) / 22)) > 0 and var_535_4 < var_535_8 then
					arg_532_1.talkMaxDuration = var_535_8

					if var_535_8 + var_535_3 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_8 + var_535_3
					end
				end

				arg_532_1.text_.text = var_535_6
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041127", "story_v_side_old_936041.awb") ~= 0 then
					local var_535_9 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041127", "story_v_side_old_936041.awb") / 1000

					if var_535_9 + var_535_3 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_9 + var_535_3
					end

					if var_535_5.prefab_name ~= "" and arg_532_1.actors_[var_535_5.prefab_name] ~= nil then
						local var_535_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_5.prefab_name].transform, "story_v_side_old_936041", "936041127", "story_v_side_old_936041.awb")

						arg_532_1:RecordAudio("936041127", var_535_10)
						arg_532_1:RecordAudio("936041127", var_535_10)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041127", "story_v_side_old_936041.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041127", "story_v_side_old_936041.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_11 = math.max(var_535_4, arg_532_1.talkMaxDuration)

			if var_535_3 <= arg_532_1.time_ and arg_532_1.time_ < var_535_3 + var_535_11 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_3) / var_535_11

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_3 + var_535_11 and arg_532_1.time_ < var_535_3 + var_535_11 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_532_1:InitPlayNodeList()
	end,
	Play936041128 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 936041128
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play936041129(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.var_.moveOldPos104402ui_story = arg_536_1.actors_["104402ui_story"].transform.localPosition

				local var_539_0 = GameObjectTools.GetOrAddComponent(arg_536_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_539_0 then
					var_539_0:EnableDynamicBone(false)
				end
			end

			local var_539_1 = 0.001

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_1 then
				arg_536_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos104402ui_story, Vector3.New(0, 100, 0), (arg_536_1.time_ - 0) / var_539_1)
				arg_536_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_536_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["104402ui_story"].transform.position).z)
				arg_536_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_536_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_536_1.actors_["104402ui_story"].transform.localEulerAngles = arg_536_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_536_1.time_ >= 0 + var_539_1 and arg_536_1.time_ < 0 + var_539_1 + arg_539_0 then
				arg_536_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_536_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_536_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["104402ui_story"].transform.position).z)
				arg_536_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_536_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_536_1.actors_["104402ui_story"].transform.localEulerAngles = arg_536_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_539_2 = GameObjectTools.GetOrAddComponent(arg_536_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_539_2 then
					var_539_2:EnableDynamicBone(true)
				end
			end

			local var_539_3 = arg_536_1.actors_["104402ui_story"]

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 and not isNil(var_539_3) and arg_536_1.var_.characterEffect104402ui_story == nil then
				arg_536_1.var_.characterEffect104402ui_story = var_539_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_4 = 0.200000002980232

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_4 and not isNil(var_539_3) then
				if arg_536_1.var_.characterEffect104402ui_story and not isNil(var_539_3) then
					arg_536_1.var_.characterEffect104402ui_story.fillFlat = true
					arg_536_1.var_.characterEffect104402ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_536_1.time_ - 0) / var_539_4)
				end
			end

			if arg_536_1.time_ >= 0 + var_539_4 and arg_536_1.time_ < 0 + var_539_4 + arg_539_0 and not isNil(var_539_3) and arg_536_1.var_.characterEffect104402ui_story then
				arg_536_1.var_.characterEffect104402ui_story.fillFlat = true
				arg_536_1.var_.characterEffect104402ui_story.fillRatio = 0.5
			end

			if 0.833333333333333 < arg_536_1.time_ and arg_536_1.time_ <= 0.833333333333333 + arg_539_0 then
				arg_536_1:AudioAction("play", "effect", "se_story_140", "se_story_140_hug02", "")
			end

			local var_539_6 = 0
			local var_539_7 = 1.15

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_6 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, false)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_8 = arg_536_1:FormatText(arg_536_1:GetWordFromCfg(936041128).content)

				arg_536_1.text_.text = var_539_8

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_10 = 46 <= 0 and var_539_7 or var_539_7 * (utf8.len(var_539_8) / 46)

				if (46 <= 0 and var_539_7 or var_539_7 * (utf8.len(var_539_8) / 46)) > 0 and var_539_7 < var_539_10 then
					arg_536_1.talkMaxDuration = var_539_10

					if var_539_10 + var_539_6 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_10 + var_539_6
					end
				end

				arg_536_1.text_.text = var_539_8
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_11 = math.max(var_539_7, arg_536_1.talkMaxDuration)

			if var_539_6 <= arg_536_1.time_ and arg_536_1.time_ < var_539_6 + var_539_11 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_6) / var_539_11

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_6 + var_539_11 and arg_536_1.time_ < var_539_6 + var_539_11 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_536_1:InitPlayNodeList()
	end,
	Play936041129 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 936041129
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play936041130(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0.15

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_1 = arg_540_1:FormatText(arg_540_1:GetWordFromCfg(936041129).content)

				arg_540_1.text_.text = var_543_1

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_3 = 6 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_1) / 6)

				if (6 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_1) / 6)) > 0 and var_543_0 < var_543_3 then
					arg_540_1.talkMaxDuration = var_543_3

					if var_543_3 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_3 + 0
					end
				end

				arg_540_1.text_.text = var_543_1
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_4 = math.max(var_543_0, arg_540_1.talkMaxDuration)

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_4 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - 0) / var_543_4

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= 0 + var_543_4 and arg_540_1.time_ < 0 + var_543_4 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play936041130 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 936041130
		arg_544_1.duration_ = 7.8

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play936041131(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.var_.moveOldPos104402ui_story = arg_544_1.actors_["104402ui_story"].transform.localPosition

				local var_547_0 = GameObjectTools.GetOrAddComponent(arg_544_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_547_0 then
					var_547_0:EnableDynamicBone(false)
				end
			end

			local var_547_1 = 0.001

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_1 then
				arg_544_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_544_1.time_ - 0) / var_547_1)
				arg_544_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_544_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["104402ui_story"].transform.position).z)
				arg_544_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_544_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_544_1.actors_["104402ui_story"].transform.localEulerAngles = arg_544_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_544_1.time_ >= 0 + var_547_1 and arg_544_1.time_ < 0 + var_547_1 + arg_547_0 then
				arg_544_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_544_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_544_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["104402ui_story"].transform.position).z)
				arg_544_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_544_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_544_1.actors_["104402ui_story"].transform.localEulerAngles = arg_544_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_547_2 = GameObjectTools.GetOrAddComponent(arg_544_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_547_2 then
					var_547_2:EnableDynamicBone(true)
				end
			end

			local var_547_3 = arg_544_1.actors_["104402ui_story"]

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 and not isNil(var_547_3) and arg_544_1.var_.characterEffect104402ui_story == nil then
				arg_544_1.var_.characterEffect104402ui_story = var_547_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_4 = 0.200000002980232

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_4 and not isNil(var_547_3) then
				if arg_544_1.var_.characterEffect104402ui_story and not isNil(var_547_3) then
					arg_544_1.var_.characterEffect104402ui_story.fillFlat = false
				end
			end

			if arg_544_1.time_ >= 0 + var_547_4 and arg_544_1.time_ < 0 + var_547_4 + arg_547_0 and not isNil(var_547_3) and arg_544_1.var_.characterEffect104402ui_story then
				arg_544_1.var_.characterEffect104402ui_story.fillFlat = false
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action1_1")
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_547_6 = 0
			local var_547_7 = 1

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_6 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_8 = arg_544_1:GetWordFromCfg(936041130)
				local var_547_9 = arg_544_1:FormatText(var_547_8.content)

				arg_544_1.text_.text = var_547_9

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_11 = 40 <= 0 and var_547_7 or var_547_7 * (utf8.len(var_547_9) / 40)

				if (40 <= 0 and var_547_7 or var_547_7 * (utf8.len(var_547_9) / 40)) > 0 and var_547_7 < var_547_11 then
					arg_544_1.talkMaxDuration = var_547_11

					if var_547_11 + var_547_6 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_11 + var_547_6
					end
				end

				arg_544_1.text_.text = var_547_9
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041130", "story_v_side_old_936041.awb") ~= 0 then
					local var_547_12 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041130", "story_v_side_old_936041.awb") / 1000

					if var_547_12 + var_547_6 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_12 + var_547_6
					end

					if var_547_8.prefab_name ~= "" and arg_544_1.actors_[var_547_8.prefab_name] ~= nil then
						local var_547_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_8.prefab_name].transform, "story_v_side_old_936041", "936041130", "story_v_side_old_936041.awb")

						arg_544_1:RecordAudio("936041130", var_547_13)
						arg_544_1:RecordAudio("936041130", var_547_13)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041130", "story_v_side_old_936041.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041130", "story_v_side_old_936041.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_14 = math.max(var_547_7, arg_544_1.talkMaxDuration)

			if var_547_6 <= arg_544_1.time_ and arg_544_1.time_ < var_547_6 + var_547_14 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_6) / var_547_14

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_6 + var_547_14 and arg_544_1.time_ < var_547_6 + var_547_14 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_544_1:InitPlayNodeList()
	end,
	Play936041131 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 936041131
		arg_548_1.duration_ = 3.93

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play936041132(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402action/104402action8_1")
			end

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_551_0 = 0
			local var_551_1 = 0.5

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_2 = arg_548_1:GetWordFromCfg(936041131)
				local var_551_3 = arg_548_1:FormatText(var_551_2.content)

				arg_548_1.text_.text = var_551_3

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_5 = 20 <= 0 and var_551_1 or var_551_1 * (utf8.len(var_551_3) / 20)

				if (20 <= 0 and var_551_1 or var_551_1 * (utf8.len(var_551_3) / 20)) > 0 and var_551_1 < var_551_5 then
					arg_548_1.talkMaxDuration = var_551_5

					if var_551_5 + var_551_0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_5 + var_551_0
					end
				end

				arg_548_1.text_.text = var_551_3
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041131", "story_v_side_old_936041.awb") ~= 0 then
					local var_551_6 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041131", "story_v_side_old_936041.awb") / 1000

					if var_551_6 + var_551_0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_6 + var_551_0
					end

					if var_551_2.prefab_name ~= "" and arg_548_1.actors_[var_551_2.prefab_name] ~= nil then
						local var_551_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_2.prefab_name].transform, "story_v_side_old_936041", "936041131", "story_v_side_old_936041.awb")

						arg_548_1:RecordAudio("936041131", var_551_7)
						arg_548_1:RecordAudio("936041131", var_551_7)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041131", "story_v_side_old_936041.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041131", "story_v_side_old_936041.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_8 = math.max(var_551_1, arg_548_1.talkMaxDuration)

			if var_551_0 <= arg_548_1.time_ and arg_548_1.time_ < var_551_0 + var_551_8 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_0) / var_551_8

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_0 + var_551_8 and arg_548_1.time_ < var_551_0 + var_551_8 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play936041132 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 936041132
		arg_552_1.duration_ = 4.1

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
			arg_552_1.auto_ = false
		end

		function arg_552_1.playNext_(arg_554_0)
			arg_552_1.onStoryFinished_()
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.var_.moveOldPos104402ui_story = arg_552_1.actors_["104402ui_story"].transform.localPosition

				local var_555_0 = GameObjectTools.GetOrAddComponent(arg_552_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_555_0 then
					var_555_0:EnableDynamicBone(false)
				end
			end

			local var_555_1 = 0.001

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_1 then
				arg_552_1.actors_["104402ui_story"].transform.localPosition = Vector3.Lerp(arg_552_1.var_.moveOldPos104402ui_story, Vector3.New(0, -1, -5.93), (arg_552_1.time_ - 0) / var_555_1)
				arg_552_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_552_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_552_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_552_1.actors_["104402ui_story"].transform.position).z)
				arg_552_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_552_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_552_1.actors_["104402ui_story"].transform.localEulerAngles = arg_552_1.actors_["104402ui_story"].transform.localEulerAngles
			end

			if arg_552_1.time_ >= 0 + var_555_1 and arg_552_1.time_ < 0 + var_555_1 + arg_555_0 then
				arg_552_1.actors_["104402ui_story"].transform.localPosition = Vector3.New(0, -1, -5.93)
				arg_552_1.actors_["104402ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_552_1.actors_["104402ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_552_1.actors_["104402ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_552_1.actors_["104402ui_story"].transform.position).z)
				arg_552_1.actors_["104402ui_story"].transform.localEulerAngles.z = 0
				arg_552_1.actors_["104402ui_story"].transform.localEulerAngles.x = 0
				arg_552_1.actors_["104402ui_story"].transform.localEulerAngles = arg_552_1.actors_["104402ui_story"].transform.localEulerAngles

				local var_555_2 = GameObjectTools.GetOrAddComponent(arg_552_1.actors_["104402ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_555_2 then
					var_555_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/story104402/story104402actionlink/104402action486")
			end

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1:PlayTimeline("104402ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_555_3 = 0
			local var_555_4 = 0.45

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_3 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_5 = arg_552_1:GetWordFromCfg(936041132)
				local var_555_6 = arg_552_1:FormatText(var_555_5.content)

				arg_552_1.text_.text = var_555_6

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_8 = 18 <= 0 and var_555_4 or var_555_4 * (utf8.len(var_555_6) / 18)

				if (18 <= 0 and var_555_4 or var_555_4 * (utf8.len(var_555_6) / 18)) > 0 and var_555_4 < var_555_8 then
					arg_552_1.talkMaxDuration = var_555_8

					if var_555_8 + var_555_3 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_8 + var_555_3
					end
				end

				arg_552_1.text_.text = var_555_6
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_936041", "936041132", "story_v_side_old_936041.awb") ~= 0 then
					local var_555_9 = manager.audio:GetVoiceLength("story_v_side_old_936041", "936041132", "story_v_side_old_936041.awb") / 1000

					if var_555_9 + var_555_3 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_9 + var_555_3
					end

					if var_555_5.prefab_name ~= "" and arg_552_1.actors_[var_555_5.prefab_name] ~= nil then
						local var_555_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_5.prefab_name].transform, "story_v_side_old_936041", "936041132", "story_v_side_old_936041.awb")

						arg_552_1:RecordAudio("936041132", var_555_10)
						arg_552_1:RecordAudio("936041132", var_555_10)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_side_old_936041", "936041132", "story_v_side_old_936041.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_side_old_936041", "936041132", "story_v_side_old_936041.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_11 = math.max(var_555_4, arg_552_1.talkMaxDuration)

			if var_555_3 <= arg_552_1.time_ and arg_552_1.time_ < var_555_3 + var_555_11 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_3) / var_555_11

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_3 + var_555_11 and arg_552_1.time_ < var_555_3 + var_555_11 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104402ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_552_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/X206_i",
		"SofdecAsset/story/story_936041001.usm",
		"TextureConfig/Background/X206_g",
		"TextureConfig/Background/ST15a",
		"TextureConfig/Background/SP93601",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST2201",
		"TextureConfig/Background/H08f"
	},
	voices = {
		"story_v_side_old_936041.awb"
	},
	skipMarkers = {
		936041006
	}
}
