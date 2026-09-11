return {
	Play320251001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320251001
		arg_1_1.duration_ = 11

		local var_1_0 = {
			zh = 9.7,
			ja = 11
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play320251002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST61 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61")
				var_4_0.name = "ST61"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST61 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST61

				arg_1_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST61" then
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

			local var_4_9 = "1089ui_story"

			if arg_1_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1089ui_story"].transform

			if 1.699999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.699999999999 + arg_4_0 then
				arg_1_1.var_.moveOldPos1089ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.699999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.699999999999 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_1_1.time_ - 1.699999999999) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.699999999999 + var_4_14 and arg_1_1.time_ < 1.699999999999 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.1, -6.17)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1089ui_story"]

			if 1.699999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.699999999999 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1089ui_story == nil then
				arg_1_1.var_.characterEffect1089ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.699999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.699999999999 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1089ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.699999999999 + var_4_16 and arg_1_1.time_ < 1.699999999999 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1089ui_story then
				arg_1_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 1.699999999998 < arg_1_1.time_ and arg_1_1.time_ <= 1.699999999998 + arg_4_0 then
				arg_1_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action6_1")
			end

			if 1.699999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.699999999999 + arg_4_0 then
				arg_1_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			local var_4_24 = 2
			local var_4_25 = 0.775

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(320251001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 31 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 31)

				if (31 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 31)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251001", "story_v_out_320251.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_320251", "320251001", "story_v_out_320251.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_320251", "320251001", "story_v_out_320251.awb")

						arg_1_1:RecordAudio("320251001", var_4_32)
						arg_1_1:RecordAudio("320251001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320251", "320251001", "story_v_out_320251.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320251", "320251001", "story_v_out_320251.awb")
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
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.699999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play320251002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320251002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play320251003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1089ui_story"]) and arg_9_1.var_.characterEffect1089ui_story == nil then
				arg_9_1.var_.characterEffect1089ui_story = arg_9_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1089ui_story"]) then
				if arg_9_1.var_.characterEffect1089ui_story and not isNil(arg_9_1.actors_["1089ui_story"]) then
					arg_9_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1089ui_story"]) and arg_9_1.var_.characterEffect1089ui_story then
				arg_9_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_12_1 = arg_9_1.actors_["1089ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1089ui_story = var_12_1.localPosition
			end

			local var_12_2 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 then
				var_12_1.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_2)
				var_12_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_1.position).x, (manager.ui.mainCamera.transform.position - var_12_1.position).y, (manager.ui.mainCamera.transform.position - var_12_1.position).z)
				var_12_1.localEulerAngles.z = 0
				var_12_1.localEulerAngles.x = 0
				var_12_1.localEulerAngles = var_12_1.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 then
				var_12_1.localPosition = Vector3.New(0, 100, 0)
				var_12_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_1.position).x, (manager.ui.mainCamera.transform.position - var_12_1.position).y, (manager.ui.mainCamera.transform.position - var_12_1.position).z)
				var_12_1.localEulerAngles.z = 0
				var_12_1.localEulerAngles.x = 0
				var_12_1.localEulerAngles = var_12_1.localEulerAngles
			end

			local var_12_3 = 0
			local var_12_4 = 1.625

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_3 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_5 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(320251002).content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 65 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 65)

				if (65 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 65)) > 0 and var_12_4 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_3
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_4, arg_9_1.talkMaxDuration)

			if var_12_3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_3 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_3) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_3 + var_12_8 and arg_9_1.time_ < var_12_3 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play320251003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320251003
		arg_13_1.duration_ = 2.47

		local var_13_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play320251004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1056ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1056ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1056ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1056ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1056ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1056ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1056ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -1, -5.75)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1056ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1056ui_story == nil then
				arg_13_1.var_.characterEffect1056ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1056ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1056ui_story then
				arg_13_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_16_8 = arg_13_1.actors_["1089ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1089ui_story = var_16_8.localPosition
			end

			local var_16_9 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_9)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(0, 100, 0)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			local var_16_10 = 0
			local var_16_11 = 0.15

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(320251003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 6 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 6)

				if (6 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 6)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251003", "story_v_out_320251.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_320251", "320251003", "story_v_out_320251.awb") / 1000

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_320251", "320251003", "story_v_out_320251.awb")

						arg_13_1:RecordAudio("320251003", var_16_17)
						arg_13_1:RecordAudio("320251003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_320251", "320251003", "story_v_out_320251.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_320251", "320251003", "story_v_out_320251.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_18 and arg_13_1.time_ < var_16_10 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play320251004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320251004
		arg_17_1.duration_ = 3.37

		local var_17_0 = {
			zh = 3.366,
			ja = 3.066
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play320251005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1089ui_story = arg_17_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1089ui_story"].transform.position).z)
				arg_17_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1089ui_story"].transform.localEulerAngles = arg_17_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_17_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1089ui_story"].transform.position).z)
				arg_17_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1089ui_story"].transform.localEulerAngles = arg_17_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1089ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1089ui_story == nil then
				arg_17_1.var_.characterEffect1089ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1089ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1089ui_story then
				arg_17_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action6_2")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_20_4 = arg_17_1.actors_["1056ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1056ui_story = var_20_4.localPosition
			end

			local var_20_5 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 then
				var_20_4.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1056ui_story, Vector3.New(0.7, -1, -5.75), (arg_17_1.time_ - 0) / var_20_5)
				var_20_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_4.position).x, (manager.ui.mainCamera.transform.position - var_20_4.position).y, (manager.ui.mainCamera.transform.position - var_20_4.position).z)
				var_20_4.localEulerAngles.z = 0
				var_20_4.localEulerAngles.x = 0
				var_20_4.localEulerAngles = var_20_4.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 then
				var_20_4.localPosition = Vector3.New(0.7, -1, -5.75)
				var_20_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_4.position).x, (manager.ui.mainCamera.transform.position - var_20_4.position).y, (manager.ui.mainCamera.transform.position - var_20_4.position).z)
				var_20_4.localEulerAngles.z = 0
				var_20_4.localEulerAngles.x = 0
				var_20_4.localEulerAngles = var_20_4.localEulerAngles
			end

			local var_20_6 = arg_17_1.actors_["1056ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect1056ui_story == nil then
				arg_17_1.var_.characterEffect1056ui_story = var_20_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_7 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 and not isNil(var_20_6) then
				if arg_17_1.var_.characterEffect1056ui_story and not isNil(var_20_6) then
					arg_17_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_7)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect1056ui_story then
				arg_17_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_20_8 = 0
			local var_20_9 = 0.15

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(320251004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 6 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 6)

				if (6 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 6)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251004", "story_v_out_320251.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_320251", "320251004", "story_v_out_320251.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_320251", "320251004", "story_v_out_320251.awb")

						arg_17_1:RecordAudio("320251004", var_20_15)
						arg_17_1:RecordAudio("320251004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_320251", "320251004", "story_v_out_320251.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_320251", "320251004", "story_v_out_320251.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play320251005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320251005
		arg_21_1.duration_ = 8.27

		local var_21_0 = {
			zh = 8.266,
			ja = 6.466
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play320251006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.925

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(320251005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 37 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 37)

				if (37 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 37)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251005", "story_v_out_320251.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251005", "story_v_out_320251.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_320251", "320251005", "story_v_out_320251.awb")

						arg_21_1:RecordAudio("320251005", var_24_6)
						arg_21_1:RecordAudio("320251005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320251", "320251005", "story_v_out_320251.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320251", "320251005", "story_v_out_320251.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play320251006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320251006
		arg_25_1.duration_ = 8.1

		local var_25_0 = {
			zh = 7.1,
			ja = 8.1
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play320251007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.8

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(320251006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 32 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 32)

				if (32 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 32)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251006", "story_v_out_320251.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251006", "story_v_out_320251.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_320251", "320251006", "story_v_out_320251.awb")

						arg_25_1:RecordAudio("320251006", var_28_6)
						arg_25_1:RecordAudio("320251006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_320251", "320251006", "story_v_out_320251.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_320251", "320251006", "story_v_out_320251.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play320251007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320251007
		arg_29_1.duration_ = 4.07

		local var_29_0 = {
			zh = 2.8,
			ja = 4.066
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play320251008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1056ui_story = arg_29_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1056ui_story, Vector3.New(0.7, -1, -5.75), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1056ui_story"].transform.position).z)
				arg_29_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1056ui_story"].transform.localEulerAngles = arg_29_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.75)
				arg_29_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1056ui_story"].transform.position).z)
				arg_29_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1056ui_story"].transform.localEulerAngles = arg_29_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1056ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1056ui_story == nil then
				arg_29_1.var_.characterEffect1056ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1056ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1056ui_story then
				arg_29_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action5_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_4 = arg_29_1.actors_["1089ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect1089ui_story == nil then
				arg_29_1.var_.characterEffect1089ui_story = var_32_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_5 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 and not isNil(var_32_4) then
				if arg_29_1.var_.characterEffect1089ui_story and not isNil(var_32_4) then
					arg_29_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_5)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect1089ui_story then
				arg_29_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_32_6 = 0
			local var_32_7 = 0.225

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(320251007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 9 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 9)

				if (9 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 9)) > 0 and var_32_7 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251007", "story_v_out_320251.awb") ~= 0 then
					local var_32_12 = manager.audio:GetVoiceLength("story_v_out_320251", "320251007", "story_v_out_320251.awb") / 1000

					if var_32_12 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_6
					end

					if var_32_8.prefab_name ~= "" and arg_29_1.actors_[var_32_8.prefab_name] ~= nil then
						local var_32_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_8.prefab_name].transform, "story_v_out_320251", "320251007", "story_v_out_320251.awb")

						arg_29_1:RecordAudio("320251007", var_32_13)
						arg_29_1:RecordAudio("320251007", var_32_13)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_320251", "320251007", "story_v_out_320251.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_320251", "320251007", "story_v_out_320251.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_14 and arg_29_1.time_ < var_32_6 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play320251008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320251008
		arg_33_1.duration_ = 7.1

		local var_33_0 = {
			zh = 7.1,
			ja = 6.833
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play320251009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1089ui_story = arg_33_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).z)
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles = arg_33_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_33_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).z)
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles = arg_33_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1089ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1089ui_story == nil then
				arg_33_1.var_.characterEffect1089ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1089ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1089ui_story then
				arg_33_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_36_4 = arg_33_1.actors_["1056ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1056ui_story == nil then
				arg_33_1.var_.characterEffect1056ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_5 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 and not isNil(var_36_4) then
				if arg_33_1.var_.characterEffect1056ui_story and not isNil(var_36_4) then
					arg_33_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_5)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1056ui_story then
				arg_33_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_36_6 = 0
			local var_36_7 = 0.6

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(320251008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 24 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 24)

				if (24 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 24)) > 0 and var_36_7 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251008", "story_v_out_320251.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_320251", "320251008", "story_v_out_320251.awb") / 1000

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_320251", "320251008", "story_v_out_320251.awb")

						arg_33_1:RecordAudio("320251008", var_36_13)
						arg_33_1:RecordAudio("320251008", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_320251", "320251008", "story_v_out_320251.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_320251", "320251008", "story_v_out_320251.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play320251009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320251009
		arg_37_1.duration_ = 7.9

		local var_37_0 = {
			zh = 7.9,
			ja = 6.533
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play320251010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.75

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(320251009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 30 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 30)

				if (30 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 30)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251009", "story_v_out_320251.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251009", "story_v_out_320251.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_320251", "320251009", "story_v_out_320251.awb")

						arg_37_1:RecordAudio("320251009", var_40_6)
						arg_37_1:RecordAudio("320251009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_320251", "320251009", "story_v_out_320251.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_320251", "320251009", "story_v_out_320251.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play320251010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320251010
		arg_41_1.duration_ = 2.97

		local var_41_0 = {
			zh = 2.666,
			ja = 2.966
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play320251011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1056ui_story"]) and arg_41_1.var_.characterEffect1056ui_story == nil then
				arg_41_1.var_.characterEffect1056ui_story = arg_41_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1056ui_story"]) then
				if arg_41_1.var_.characterEffect1056ui_story and not isNil(arg_41_1.actors_["1056ui_story"]) then
					arg_41_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1056ui_story"]) and arg_41_1.var_.characterEffect1056ui_story then
				arg_41_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action5_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_44_2 = arg_41_1.actors_["1089ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1089ui_story == nil then
				arg_41_1.var_.characterEffect1089ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect1089ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_3)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1089ui_story then
				arg_41_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_44_4 = 0
			local var_44_5 = 0.325

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(320251010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 13 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 13)

				if (13 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 13)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251010", "story_v_out_320251.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251010", "story_v_out_320251.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_320251", "320251010", "story_v_out_320251.awb")

						arg_41_1:RecordAudio("320251010", var_44_11)
						arg_41_1:RecordAudio("320251010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_320251", "320251010", "story_v_out_320251.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_320251", "320251010", "story_v_out_320251.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play320251011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320251011
		arg_45_1.duration_ = 11.67

		local var_45_0 = {
			zh = 11.5,
			ja = 11.666
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play320251012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.575

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(320251011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 63 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 63)

				if (63 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 63)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251011", "story_v_out_320251.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251011", "story_v_out_320251.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_320251", "320251011", "story_v_out_320251.awb")

						arg_45_1:RecordAudio("320251011", var_48_6)
						arg_45_1:RecordAudio("320251011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_320251", "320251011", "story_v_out_320251.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_320251", "320251011", "story_v_out_320251.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play320251012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320251012
		arg_49_1.duration_ = 11.4

		local var_49_0 = {
			zh = 11.4,
			ja = 7.1
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play320251013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.45

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(320251012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 58 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 58)

				if (58 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 58)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251012", "story_v_out_320251.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251012", "story_v_out_320251.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_320251", "320251012", "story_v_out_320251.awb")

						arg_49_1:RecordAudio("320251012", var_52_6)
						arg_49_1:RecordAudio("320251012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_320251", "320251012", "story_v_out_320251.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_320251", "320251012", "story_v_out_320251.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play320251013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320251013
		arg_53_1.duration_ = 7.43

		local var_53_0 = {
			zh = 5.933,
			ja = 7.433
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play320251014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action10_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_56_0 = 0
			local var_56_1 = 0.8

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(320251013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 32 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 32)

				if (32 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 32)) > 0 and var_56_1 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251013", "story_v_out_320251.awb") ~= 0 then
					local var_56_6 = manager.audio:GetVoiceLength("story_v_out_320251", "320251013", "story_v_out_320251.awb") / 1000

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end

					if var_56_2.prefab_name ~= "" and arg_53_1.actors_[var_56_2.prefab_name] ~= nil then
						local var_56_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_2.prefab_name].transform, "story_v_out_320251", "320251013", "story_v_out_320251.awb")

						arg_53_1:RecordAudio("320251013", var_56_7)
						arg_53_1:RecordAudio("320251013", var_56_7)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_320251", "320251013", "story_v_out_320251.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_320251", "320251013", "story_v_out_320251.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_8 and arg_53_1.time_ < var_56_0 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play320251014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320251014
		arg_57_1.duration_ = 7.5

		local var_57_0 = {
			zh = 7.5,
			ja = 6.833
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play320251015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1089ui_story"]) and arg_57_1.var_.characterEffect1089ui_story == nil then
				arg_57_1.var_.characterEffect1089ui_story = arg_57_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1089ui_story"]) then
				if arg_57_1.var_.characterEffect1089ui_story and not isNil(arg_57_1.actors_["1089ui_story"]) then
					arg_57_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1089ui_story"]) and arg_57_1.var_.characterEffect1089ui_story then
				arg_57_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_60_2 = arg_57_1.actors_["1056ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1056ui_story == nil then
				arg_57_1.var_.characterEffect1056ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect1056ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1056ui_story then
				arg_57_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_60_4 = 0
			local var_60_5 = 0.775

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(320251014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 31 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 31)

				if (31 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 31)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251014", "story_v_out_320251.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251014", "story_v_out_320251.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_320251", "320251014", "story_v_out_320251.awb")

						arg_57_1:RecordAudio("320251014", var_60_11)
						arg_57_1:RecordAudio("320251014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_320251", "320251014", "story_v_out_320251.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_320251", "320251014", "story_v_out_320251.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play320251015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320251015
		arg_61_1.duration_ = 5.23

		local var_61_0 = {
			zh = 3.6,
			ja = 5.233
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play320251016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1056ui_story"]) and arg_61_1.var_.characterEffect1056ui_story == nil then
				arg_61_1.var_.characterEffect1056ui_story = arg_61_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1056ui_story"]) then
				if arg_61_1.var_.characterEffect1056ui_story and not isNil(arg_61_1.actors_["1056ui_story"]) then
					arg_61_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1056ui_story"]) and arg_61_1.var_.characterEffect1056ui_story then
				arg_61_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action10_2")
			end

			local var_64_2 = arg_61_1.actors_["1089ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1089ui_story == nil then
				arg_61_1.var_.characterEffect1089ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect1089ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1089ui_story then
				arg_61_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_64_4 = 0
			local var_64_5 = 0.45

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(320251015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 18 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 18)

				if (18 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 18)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251015", "story_v_out_320251.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251015", "story_v_out_320251.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_320251", "320251015", "story_v_out_320251.awb")

						arg_61_1:RecordAudio("320251015", var_64_11)
						arg_61_1:RecordAudio("320251015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_320251", "320251015", "story_v_out_320251.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_320251", "320251015", "story_v_out_320251.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play320251016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320251016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play320251017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1056ui_story = arg_65_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1056ui_story"].transform.position).z)
				arg_65_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1056ui_story"].transform.localEulerAngles = arg_65_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1056ui_story"].transform.position).z)
				arg_65_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1056ui_story"].transform.localEulerAngles = arg_65_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1056ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1056ui_story == nil then
				arg_65_1.var_.characterEffect1056ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1056ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_2)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1056ui_story then
				arg_65_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_68_3 = arg_65_1.actors_["1089ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1089ui_story = var_68_3.localPosition
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_3.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_4)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_3.localPosition = Vector3.New(0, 100, 0)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			local var_68_5 = arg_65_1.actors_["1089ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1089ui_story == nil then
				arg_65_1.var_.characterEffect1089ui_story = var_68_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.characterEffect1089ui_story and not isNil(var_68_5) then
					arg_65_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_6)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1089ui_story then
				arg_65_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_68_7 = 0
			local var_68_8 = 1.35

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_9 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(320251016).content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 54 <= 0 and var_68_8 or var_68_8 * (utf8.len(var_68_9) / 54)

				if (54 <= 0 and var_68_8 or var_68_8 * (utf8.len(var_68_9) / 54)) > 0 and var_68_8 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_7 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_7
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_8, arg_65_1.talkMaxDuration)

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_7) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_7 + var_68_12 and arg_65_1.time_ < var_68_7 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play320251017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320251017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play320251018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.375

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(320251017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 55 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 55)

				if (55 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 55)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play320251018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320251018
		arg_73_1.duration_ = 6.4

		local var_73_0 = {
			zh = 4.766,
			ja = 6.4
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play320251019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1089ui_story"]) and arg_73_1.var_.characterEffect1089ui_story == nil then
				arg_73_1.var_.characterEffect1089ui_story = arg_73_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1089ui_story"]) then
				if arg_73_1.var_.characterEffect1089ui_story and not isNil(arg_73_1.actors_["1089ui_story"]) then
					arg_73_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1089ui_story"]) and arg_73_1.var_.characterEffect1089ui_story then
				arg_73_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_76_2 = arg_73_1.actors_["1089ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1089ui_story = var_76_2.localPosition
			end

			local var_76_3 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 then
				var_76_2.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_73_1.time_ - 0) / var_76_3)
				var_76_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_2.position).x, (manager.ui.mainCamera.transform.position - var_76_2.position).y, (manager.ui.mainCamera.transform.position - var_76_2.position).z)
				var_76_2.localEulerAngles.z = 0
				var_76_2.localEulerAngles.x = 0
				var_76_2.localEulerAngles = var_76_2.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 then
				var_76_2.localPosition = Vector3.New(0, -1.1, -6.17)
				var_76_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_2.position).x, (manager.ui.mainCamera.transform.position - var_76_2.position).y, (manager.ui.mainCamera.transform.position - var_76_2.position).z)
				var_76_2.localEulerAngles.z = 0
				var_76_2.localEulerAngles.x = 0
				var_76_2.localEulerAngles = var_76_2.localEulerAngles
			end

			local var_76_4 = 0
			local var_76_5 = 0.5

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(320251018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 20 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 20)

				if (20 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 20)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251018", "story_v_out_320251.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251018", "story_v_out_320251.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_320251", "320251018", "story_v_out_320251.awb")

						arg_73_1:RecordAudio("320251018", var_76_11)
						arg_73_1:RecordAudio("320251018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_320251", "320251018", "story_v_out_320251.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_320251", "320251018", "story_v_out_320251.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play320251019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 320251019
		arg_77_1.duration_ = 8.03

		local var_77_0 = {
			zh = 6.13266666666667,
			ja = 8.03266666666667
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play320251020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if arg_77_1.bgs_.L02f == nil then
				local var_80_0 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L02f")
				var_80_0.name = "L02f"
				var_80_0.transform.parent = arg_77_1.stage_.transform
				var_80_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_.L02f = var_80_0
			end

			if 1.9 < arg_77_1.time_ and arg_77_1.time_ <= 1.9 + arg_80_0 then
				local var_80_1 = arg_77_1.bgs_.L02f

				arg_77_1.bgs_.L02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_80_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_2 = var_80_1:GetComponent("SpriteRenderer")

				if var_80_2 and var_80_2.sprite then
					local var_80_3 = 2 * (var_80_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_80_1.transform.localScale = Vector3.New(var_80_3 / var_80_2.sprite.bounds.size.y < var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x and var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x or var_80_3 / var_80_2.sprite.bounds.size.y, var_80_3 / var_80_2.sprite.bounds.size.y < var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x and var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x or var_80_3 / var_80_2.sprite.bounds.size.y, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "L02f" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_4 = 0

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_5 = 1.93400000184774

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_5 then
				local var_80_6 = Color.New(0, 0, 0)

				var_80_6.a = Mathf.Lerp(0, 1, (arg_77_1.time_ - var_80_4) / var_80_5)
				arg_77_1.mask_.color = var_80_6
			end

			if arg_77_1.time_ >= var_80_4 + var_80_5 and arg_77_1.time_ < var_80_4 + var_80_5 + arg_80_0 then
				local var_80_7 = Color.New(0, 0, 0)

				var_80_7.a = 1
				arg_77_1.mask_.color = var_80_7
			end

			local var_80_8 = 1.93400000184774

			if 1.93400000184774 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_9 = 1.43266666481892

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 then
				local var_80_10 = Color.New(0, 0, 0)

				var_80_10.a = Mathf.Lerp(1, 0, (arg_77_1.time_ - var_80_8) / var_80_9)
				arg_77_1.mask_.color = var_80_10
			end

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 then
				local var_80_11 = Color.New(0, 0, 0)

				arg_77_1.mask_.enabled = false
				var_80_11.a = 0
				arg_77_1.mask_.color = var_80_11
			end

			local var_80_12 = arg_77_1.actors_["1089ui_story"].transform

			if 1.9 < arg_77_1.time_ and arg_77_1.time_ <= 1.9 + arg_80_0 then
				arg_77_1.var_.moveOldPos1089ui_story = var_80_12.localPosition
			end

			local var_80_13 = 0.001

			if 1.9 <= arg_77_1.time_ and arg_77_1.time_ < 1.9 + var_80_13 then
				var_80_12.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 1.9) / var_80_13)
				var_80_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_12.position).x, (manager.ui.mainCamera.transform.position - var_80_12.position).y, (manager.ui.mainCamera.transform.position - var_80_12.position).z)
				var_80_12.localEulerAngles.z = 0
				var_80_12.localEulerAngles.x = 0
				var_80_12.localEulerAngles = var_80_12.localEulerAngles
			end

			if arg_77_1.time_ >= 1.9 + var_80_13 and arg_77_1.time_ < 1.9 + var_80_13 + arg_80_0 then
				var_80_12.localPosition = Vector3.New(0, 100, 0)
				var_80_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_12.position).x, (manager.ui.mainCamera.transform.position - var_80_12.position).y, (manager.ui.mainCamera.transform.position - var_80_12.position).z)
				var_80_12.localEulerAngles.z = 0
				var_80_12.localEulerAngles.x = 0
				var_80_12.localEulerAngles = var_80_12.localEulerAngles
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_80_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_77_1.bgmTxt_.text ~= var_80_16 and arg_77_1.bgmTxt_.text ~= "" then
						if arg_77_1.bgmTxt2_.text ~= "" then
							arg_77_1.bgmTxt_.text = arg_77_1.bgmTxt2_.text
						end

						arg_77_1.bgmTxt2_.text = var_80_16

						arg_77_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_77_1.bgmTxt_.text = var_80_16
						arg_77_1.bgmTxt2_.text = var_80_16
					end

					if arg_77_1.bgmTimer then
						arg_77_1.bgmTimer:Stop()

						arg_77_1.bgmTimer = nil
					end

					if arg_77_1.settingData.show_music_name == 1 then
						arg_77_1.musicController:SetSelectedState("show")
						arg_77_1.musicAnimator_:Play("open", 0, 0)

						if arg_77_1.settingData.music_time ~= 0 then
							arg_77_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_77_1.settingData.music_time), function()
								if arg_77_1 == nil or isNil(arg_77_1.bgmTxt_) then
									return
								end

								arg_77_1.musicController:SetSelectedState("hide")
								arg_77_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.36666666666667 < arg_77_1.time_ and arg_77_1.time_ <= 1.36666666666667 + arg_80_0 then
				arg_77_1:AudioAction("play", "music", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_80_19 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if "" ~= "" then
					if arg_77_1.bgmTxt_.text ~= var_80_19 and arg_77_1.bgmTxt_.text ~= "" then
						if arg_77_1.bgmTxt2_.text ~= "" then
							arg_77_1.bgmTxt_.text = arg_77_1.bgmTxt2_.text
						end

						arg_77_1.bgmTxt2_.text = var_80_19

						arg_77_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_77_1.bgmTxt_.text = var_80_19
						arg_77_1.bgmTxt2_.text = var_80_19
					end

					if arg_77_1.bgmTimer then
						arg_77_1.bgmTimer:Stop()

						arg_77_1.bgmTimer = nil
					end

					if arg_77_1.settingData.show_music_name == 1 then
						arg_77_1.musicController:SetSelectedState("show")
						arg_77_1.musicAnimator_:Play("open", 0, 0)

						if arg_77_1.settingData.music_time ~= 0 then
							arg_77_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_77_1.settingData.music_time), function()
								if arg_77_1 == nil or isNil(arg_77_1.bgmTxt_) then
									return
								end

								arg_77_1.musicController:SetSelectedState("hide")
								arg_77_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_20 = 3.36666666666667
			local var_80_21 = 0.3

			if 3.36666666666667 < arg_77_1.time_ and arg_77_1.time_ <= var_80_20 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_22 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_22:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_77_1.dialogCg_.alpha = arg_83_0
				end))
				var_80_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1044].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_23 = arg_77_1:GetWordFromCfg(320251019)
				local var_80_24 = arg_77_1:FormatText(var_80_23.content)

				arg_77_1.text_.text = var_80_24

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_26 = 12 <= 0 and var_80_21 or var_80_21 * (utf8.len(var_80_24) / 12)

				if (12 <= 0 and var_80_21 or var_80_21 * (utf8.len(var_80_24) / 12)) > 0 and var_80_21 < var_80_26 then
					arg_77_1.talkMaxDuration = var_80_26
					var_80_20 = var_80_20 + 0.3

					if var_80_26 + var_80_20 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_26 + var_80_20
					end
				end

				arg_77_1.text_.text = var_80_24
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251019", "story_v_out_320251.awb") ~= 0 then
					local var_80_27 = manager.audio:GetVoiceLength("story_v_out_320251", "320251019", "story_v_out_320251.awb") / 1000

					if var_80_27 + var_80_20 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_27 + var_80_20
					end

					if var_80_23.prefab_name ~= "" and arg_77_1.actors_[var_80_23.prefab_name] ~= nil then
						local var_80_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_23.prefab_name].transform, "story_v_out_320251", "320251019", "story_v_out_320251.awb")

						arg_77_1:RecordAudio("320251019", var_80_28)
						arg_77_1:RecordAudio("320251019", var_80_28)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_320251", "320251019", "story_v_out_320251.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_320251", "320251019", "story_v_out_320251.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_29 = var_80_20 + 0.3
			local var_80_30 = math.max(var_80_21, arg_77_1.talkMaxDuration)

			if var_80_20 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_29 + var_80_30 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_29) / var_80_30

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_29 + var_80_30 and arg_77_1.time_ < var_80_29 + var_80_30 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play320251020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 320251020
		arg_85_1.duration_ = 6.7

		local var_85_0 = {
			zh = 5,
			ja = 6.7
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play320251021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if arg_85_1.actors_["10100ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10100ui_story"))) then
				local var_88_0 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_85_1.stage_.transform)

				var_88_0.name = "10100ui_story"
				var_88_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["10100ui_story"] = var_88_0

				local var_88_1 = var_88_0:GetComponentInChildren(typeof(CharacterEffect))

				var_88_1.enabled = true

				local var_88_2 = GameObjectTools.GetOrAddComponent(var_88_0, typeof(DynamicBoneHelper))

				if var_88_2 then
					var_88_2:EnableDynamicBone(false)
				end

				arg_85_1:ShowWeapon(var_88_1.transform, false)

				arg_85_1.var_["10100ui_story" .. "Animator"] = var_88_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_85_1.var_["10100ui_story" .. "Animator"].applyRootMotion = true
				arg_85_1.var_["10100ui_story" .. "LipSync"] = var_88_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_88_3 = arg_85_1.actors_["10100ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10100ui_story = var_88_3.localPosition
			end

			local var_88_4 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				var_88_3.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_85_1.time_ - 0) / var_88_4)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				var_88_3.localPosition = Vector3.New(0, -1.16, -6.25)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			local var_88_5 = arg_85_1.actors_["10100ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect10100ui_story == nil then
				arg_85_1.var_.characterEffect10100ui_story = var_88_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_6 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_6 and not isNil(var_88_5) then
				if arg_85_1.var_.characterEffect10100ui_story and not isNil(var_88_5) then
					arg_85_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_6 and arg_85_1.time_ < 0 + var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect10100ui_story then
				arg_85_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_88_8 = 0
			local var_88_9 = 0.675

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(320251020)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 27 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 27)

				if (27 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 27)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251020", "story_v_out_320251.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_320251", "320251020", "story_v_out_320251.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_320251", "320251020", "story_v_out_320251.awb")

						arg_85_1:RecordAudio("320251020", var_88_15)
						arg_85_1:RecordAudio("320251020", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_320251", "320251020", "story_v_out_320251.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_320251", "320251020", "story_v_out_320251.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play320251021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 320251021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play320251022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["10100ui_story"]) and arg_89_1.var_.characterEffect10100ui_story == nil then
				arg_89_1.var_.characterEffect10100ui_story = arg_89_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["10100ui_story"]) then
				if arg_89_1.var_.characterEffect10100ui_story and not isNil(arg_89_1.actors_["10100ui_story"]) then
					arg_89_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["10100ui_story"]) and arg_89_1.var_.characterEffect10100ui_story then
				arg_89_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_92_1 = arg_89_1.actors_["10100ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10100ui_story = var_92_1.localPosition
			end

			local var_92_2 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 then
				var_92_1.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_2)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 then
				var_92_1.localPosition = Vector3.New(0, 100, 0)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			local var_92_3 = 0
			local var_92_4 = 0.9

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_5 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(320251021).content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 36 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 36)

				if (36 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 36)) > 0 and var_92_4 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_3 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_3
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_4, arg_89_1.talkMaxDuration)

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_3) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_3 + var_92_8 and arg_89_1.time_ < var_92_3 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play320251022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320251022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play320251023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.325

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(320251022).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 53 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 53)

				if (53 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 53)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play320251023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320251023
		arg_97_1.duration_ = 10.33

		local var_97_0 = {
			zh = 8.766,
			ja = 10.333
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play320251024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10100ui_story = arg_97_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10100ui_story"].transform.position).z)
				arg_97_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10100ui_story"].transform.localEulerAngles = arg_97_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_97_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10100ui_story"].transform.position).z)
				arg_97_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10100ui_story"].transform.localEulerAngles = arg_97_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10100ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10100ui_story == nil then
				arg_97_1.var_.characterEffect10100ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10100ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10100ui_story then
				arg_97_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_2")
			end

			local var_100_4 = 0
			local var_100_5 = 1.25

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(320251023)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 50 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 50)

				if (50 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 50)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251023", "story_v_out_320251.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251023", "story_v_out_320251.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_320251", "320251023", "story_v_out_320251.awb")

						arg_97_1:RecordAudio("320251023", var_100_11)
						arg_97_1:RecordAudio("320251023", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_320251", "320251023", "story_v_out_320251.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_320251", "320251023", "story_v_out_320251.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play320251024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320251024
		arg_101_1.duration_ = 10.63

		local var_101_0 = {
			zh = 6.933,
			ja = 10.633
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play320251025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10100ui_story"]) and arg_101_1.var_.characterEffect10100ui_story == nil then
				arg_101_1.var_.characterEffect10100ui_story = arg_101_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10100ui_story"]) then
				if arg_101_1.var_.characterEffect10100ui_story and not isNil(arg_101_1.actors_["10100ui_story"]) then
					arg_101_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10100ui_story"]) and arg_101_1.var_.characterEffect10100ui_story then
				arg_101_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.925

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1044].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(320251024)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_6 = 37 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_4) / 37)

				if (37 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_4) / 37)) > 0 and var_104_2 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251024", "story_v_out_320251.awb") ~= 0 then
					local var_104_7 = manager.audio:GetVoiceLength("story_v_out_320251", "320251024", "story_v_out_320251.awb") / 1000

					if var_104_7 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_1
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_320251", "320251024", "story_v_out_320251.awb")

						arg_101_1:RecordAudio("320251024", var_104_8)
						arg_101_1:RecordAudio("320251024", var_104_8)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_320251", "320251024", "story_v_out_320251.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_320251", "320251024", "story_v_out_320251.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_9 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_9 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_9

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_9 and arg_101_1.time_ < var_104_1 + var_104_9 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play320251025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320251025
		arg_105_1.duration_ = 9.57

		local var_105_0 = {
			zh = 2.6,
			ja = 9.566
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play320251026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10100ui_story"]) and arg_105_1.var_.characterEffect10100ui_story == nil then
				arg_105_1.var_.characterEffect10100ui_story = arg_105_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10100ui_story"]) then
				if arg_105_1.var_.characterEffect10100ui_story and not isNil(arg_105_1.actors_["10100ui_story"]) then
					arg_105_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10100ui_story"]) and arg_105_1.var_.characterEffect10100ui_story then
				arg_105_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_108_2 = 0
			local var_108_3 = 0.275

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(320251025)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 11 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 11)

				if (11 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 11)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251025", "story_v_out_320251.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251025", "story_v_out_320251.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_out_320251", "320251025", "story_v_out_320251.awb")

						arg_105_1:RecordAudio("320251025", var_108_9)
						arg_105_1:RecordAudio("320251025", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_320251", "320251025", "story_v_out_320251.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_320251", "320251025", "story_v_out_320251.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_10 and arg_105_1.time_ < var_108_2 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play320251026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320251026
		arg_109_1.duration_ = 2.93

		local var_109_0 = {
			zh = 1.366,
			ja = 2.933
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play320251027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10100ui_story"]) and arg_109_1.var_.characterEffect10100ui_story == nil then
				arg_109_1.var_.characterEffect10100ui_story = arg_109_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10100ui_story"]) then
				if arg_109_1.var_.characterEffect10100ui_story and not isNil(arg_109_1.actors_["10100ui_story"]) then
					arg_109_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10100ui_story"]) and arg_109_1.var_.characterEffect10100ui_story then
				arg_109_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.125

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1044].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:GetWordFromCfg(320251026)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 5 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 5)

				if (5 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 5)) > 0 and var_112_2 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251026", "story_v_out_320251.awb") ~= 0 then
					local var_112_7 = manager.audio:GetVoiceLength("story_v_out_320251", "320251026", "story_v_out_320251.awb") / 1000

					if var_112_7 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_1
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_320251", "320251026", "story_v_out_320251.awb")

						arg_109_1:RecordAudio("320251026", var_112_8)
						arg_109_1:RecordAudio("320251026", var_112_8)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_320251", "320251026", "story_v_out_320251.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_320251", "320251026", "story_v_out_320251.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_9 and arg_109_1.time_ < var_112_1 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play320251027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 320251027
		arg_113_1.duration_ = 7.4

		local var_113_0 = {
			zh = 4.3,
			ja = 7.4
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play320251028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10100ui_story"]) and arg_113_1.var_.characterEffect10100ui_story == nil then
				arg_113_1.var_.characterEffect10100ui_story = arg_113_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10100ui_story"]) then
				if arg_113_1.var_.characterEffect10100ui_story and not isNil(arg_113_1.actors_["10100ui_story"]) then
					arg_113_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10100ui_story"]) and arg_113_1.var_.characterEffect10100ui_story then
				arg_113_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_116_2 = 0
			local var_116_3 = 0.6

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_4 = arg_113_1:GetWordFromCfg(320251027)
				local var_116_5 = arg_113_1:FormatText(var_116_4.content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 24 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 24)

				if (24 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 24)) > 0 and var_116_3 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251027", "story_v_out_320251.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251027", "story_v_out_320251.awb") / 1000

					if var_116_8 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_2
					end

					if var_116_4.prefab_name ~= "" and arg_113_1.actors_[var_116_4.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_4.prefab_name].transform, "story_v_out_320251", "320251027", "story_v_out_320251.awb")

						arg_113_1:RecordAudio("320251027", var_116_9)
						arg_113_1:RecordAudio("320251027", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_320251", "320251027", "story_v_out_320251.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_320251", "320251027", "story_v_out_320251.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_10 and arg_113_1.time_ < var_116_2 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play320251028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 320251028
		arg_117_1.duration_ = 4.07

		local var_117_0 = {
			zh = 3.166,
			ja = 4.066
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play320251029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10100ui_story"]) and arg_117_1.var_.characterEffect10100ui_story == nil then
				arg_117_1.var_.characterEffect10100ui_story = arg_117_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10100ui_story"]) then
				if arg_117_1.var_.characterEffect10100ui_story and not isNil(arg_117_1.actors_["10100ui_story"]) then
					arg_117_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10100ui_story"]) and arg_117_1.var_.characterEffect10100ui_story then
				arg_117_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 0.325

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1044].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:GetWordFromCfg(320251028)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_6 = 13 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_4) / 13)

				if (13 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_4) / 13)) > 0 and var_120_2 < var_120_6 then
					arg_117_1.talkMaxDuration = var_120_6

					if var_120_6 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251028", "story_v_out_320251.awb") ~= 0 then
					local var_120_7 = manager.audio:GetVoiceLength("story_v_out_320251", "320251028", "story_v_out_320251.awb") / 1000

					if var_120_7 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_1
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_320251", "320251028", "story_v_out_320251.awb")

						arg_117_1:RecordAudio("320251028", var_120_8)
						arg_117_1:RecordAudio("320251028", var_120_8)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_320251", "320251028", "story_v_out_320251.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_320251", "320251028", "story_v_out_320251.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_9 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_9 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_9

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_9 and arg_117_1.time_ < var_120_1 + var_120_9 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play320251029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 320251029
		arg_121_1.duration_ = 6.9

		local var_121_0 = {
			zh = 6.9,
			ja = 4.966
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play320251030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10100ui_story = arg_121_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10100ui_story"].transform.position).z)
				arg_121_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10100ui_story"].transform.localEulerAngles = arg_121_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_121_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10100ui_story"].transform.position).z)
				arg_121_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10100ui_story"].transform.localEulerAngles = arg_121_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["10100ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10100ui_story == nil then
				arg_121_1.var_.characterEffect10100ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect10100ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10100ui_story then
				arg_121_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action5_1")
			end

			local var_124_4 = 0
			local var_124_5 = 0.9

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(320251029)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 36 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 36)

				if (36 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 36)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251029", "story_v_out_320251.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251029", "story_v_out_320251.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_320251", "320251029", "story_v_out_320251.awb")

						arg_121_1:RecordAudio("320251029", var_124_11)
						arg_121_1:RecordAudio("320251029", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_320251", "320251029", "story_v_out_320251.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_320251", "320251029", "story_v_out_320251.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play320251030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 320251030
		arg_125_1.duration_ = 10.73

		local var_125_0 = {
			zh = 10.733,
			ja = 10.333
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play320251031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_128_0 = 0
			local var_128_1 = 1.375

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(320251030)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 55 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 55)

				if (55 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 55)) > 0 and var_128_1 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251030", "story_v_out_320251.awb") ~= 0 then
					local var_128_6 = manager.audio:GetVoiceLength("story_v_out_320251", "320251030", "story_v_out_320251.awb") / 1000

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end

					if var_128_2.prefab_name ~= "" and arg_125_1.actors_[var_128_2.prefab_name] ~= nil then
						local var_128_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_2.prefab_name].transform, "story_v_out_320251", "320251030", "story_v_out_320251.awb")

						arg_125_1:RecordAudio("320251030", var_128_7)
						arg_125_1:RecordAudio("320251030", var_128_7)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_320251", "320251030", "story_v_out_320251.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_320251", "320251030", "story_v_out_320251.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play320251031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 320251031
		arg_129_1.duration_ = 13.83

		local var_129_0 = {
			zh = 8.8,
			ja = 13.833
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play320251032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.975

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(320251031)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 39 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 39)

				if (39 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 39)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251031", "story_v_out_320251.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251031", "story_v_out_320251.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_320251", "320251031", "story_v_out_320251.awb")

						arg_129_1:RecordAudio("320251031", var_132_6)
						arg_129_1:RecordAudio("320251031", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_320251", "320251031", "story_v_out_320251.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_320251", "320251031", "story_v_out_320251.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play320251032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 320251032
		arg_133_1.duration_ = 2.33

		local var_133_0 = {
			zh = 1.8,
			ja = 2.333
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play320251033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10100ui_story"]) and arg_133_1.var_.characterEffect10100ui_story == nil then
				arg_133_1.var_.characterEffect10100ui_story = arg_133_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10100ui_story"]) then
				if arg_133_1.var_.characterEffect10100ui_story and not isNil(arg_133_1.actors_["10100ui_story"]) then
					arg_133_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10100ui_story"]) and arg_133_1.var_.characterEffect10100ui_story then
				arg_133_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 0.125

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1066].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:GetWordFromCfg(320251032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 5 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_4) / 5)

				if (5 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_4) / 5)) > 0 and var_136_2 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251032", "story_v_out_320251.awb") ~= 0 then
					local var_136_7 = manager.audio:GetVoiceLength("story_v_out_320251", "320251032", "story_v_out_320251.awb") / 1000

					if var_136_7 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_1
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_320251", "320251032", "story_v_out_320251.awb")

						arg_133_1:RecordAudio("320251032", var_136_8)
						arg_133_1:RecordAudio("320251032", var_136_8)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_320251", "320251032", "story_v_out_320251.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_320251", "320251032", "story_v_out_320251.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_9 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_9 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_9

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_9 and arg_133_1.time_ < var_136_1 + var_136_9 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play320251033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 320251033
		arg_137_1.duration_ = 12

		local var_137_0 = {
			zh = 9.8,
			ja = 12
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play320251034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["10100ui_story"]) and arg_137_1.var_.characterEffect10100ui_story == nil then
				arg_137_1.var_.characterEffect10100ui_story = arg_137_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["10100ui_story"]) then
				if arg_137_1.var_.characterEffect10100ui_story and not isNil(arg_137_1.actors_["10100ui_story"]) then
					arg_137_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["10100ui_story"]) and arg_137_1.var_.characterEffect10100ui_story then
				arg_137_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_140_2 = 0
			local var_140_3 = 1

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:GetWordFromCfg(320251033)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 40 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 40)

				if (40 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 40)) > 0 and var_140_3 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251033", "story_v_out_320251.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251033", "story_v_out_320251.awb") / 1000

					if var_140_8 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_2
					end

					if var_140_4.prefab_name ~= "" and arg_137_1.actors_[var_140_4.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_4.prefab_name].transform, "story_v_out_320251", "320251033", "story_v_out_320251.awb")

						arg_137_1:RecordAudio("320251033", var_140_9)
						arg_137_1:RecordAudio("320251033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_320251", "320251033", "story_v_out_320251.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_320251", "320251033", "story_v_out_320251.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_10 and arg_137_1.time_ < var_140_2 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play320251034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 320251034
		arg_141_1.duration_ = 9.57

		local var_141_0 = {
			zh = 8.6,
			ja = 9.566
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play320251035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10100ui_story"]) and arg_141_1.var_.characterEffect10100ui_story == nil then
				arg_141_1.var_.characterEffect10100ui_story = arg_141_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10100ui_story"]) then
				if arg_141_1.var_.characterEffect10100ui_story and not isNil(arg_141_1.actors_["10100ui_story"]) then
					arg_141_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10100ui_story"]) and arg_141_1.var_.characterEffect10100ui_story then
				arg_141_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action5_2")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_144_2 = 0
			local var_144_3 = 1.225

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:GetWordFromCfg(320251034)
				local var_144_5 = arg_141_1:FormatText(var_144_4.content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 49 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 49)

				if (49 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 49)) > 0 and var_144_3 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251034", "story_v_out_320251.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251034", "story_v_out_320251.awb") / 1000

					if var_144_8 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_2
					end

					if var_144_4.prefab_name ~= "" and arg_141_1.actors_[var_144_4.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_4.prefab_name].transform, "story_v_out_320251", "320251034", "story_v_out_320251.awb")

						arg_141_1:RecordAudio("320251034", var_144_9)
						arg_141_1:RecordAudio("320251034", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_320251", "320251034", "story_v_out_320251.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_320251", "320251034", "story_v_out_320251.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_10 and arg_141_1.time_ < var_144_2 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play320251035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 320251035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play320251036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["10100ui_story"]) and arg_145_1.var_.characterEffect10100ui_story == nil then
				arg_145_1.var_.characterEffect10100ui_story = arg_145_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["10100ui_story"]) then
				if arg_145_1.var_.characterEffect10100ui_story and not isNil(arg_145_1.actors_["10100ui_story"]) then
					arg_145_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["10100ui_story"]) and arg_145_1.var_.characterEffect10100ui_story then
				arg_145_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 0.775

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(320251035).content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 31 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 31)

				if (31 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 31)) > 0 and var_148_2 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_6 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_6 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_6

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_6 and arg_145_1.time_ < var_148_1 + var_148_6 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play320251036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 320251036
		arg_149_1.duration_ = 14.13

		local var_149_0 = {
			zh = 14.133,
			ja = 12.866
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play320251037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10100ui_story"]) and arg_149_1.var_.characterEffect10100ui_story == nil then
				arg_149_1.var_.characterEffect10100ui_story = arg_149_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10100ui_story"]) then
				if arg_149_1.var_.characterEffect10100ui_story and not isNil(arg_149_1.actors_["10100ui_story"]) then
					arg_149_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10100ui_story"]) and arg_149_1.var_.characterEffect10100ui_story then
				arg_149_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_152_2 = 0
			local var_152_3 = 1.35

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_4 = arg_149_1:GetWordFromCfg(320251036)
				local var_152_5 = arg_149_1:FormatText(var_152_4.content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 54 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 54)

				if (54 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 54)) > 0 and var_152_3 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251036", "story_v_out_320251.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251036", "story_v_out_320251.awb") / 1000

					if var_152_8 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_2
					end

					if var_152_4.prefab_name ~= "" and arg_149_1.actors_[var_152_4.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_4.prefab_name].transform, "story_v_out_320251", "320251036", "story_v_out_320251.awb")

						arg_149_1:RecordAudio("320251036", var_152_9)
						arg_149_1:RecordAudio("320251036", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_320251", "320251036", "story_v_out_320251.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_320251", "320251036", "story_v_out_320251.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_10 and arg_149_1.time_ < var_152_2 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play320251037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 320251037
		arg_153_1.duration_ = 9.4

		local var_153_0 = {
			zh = 8.766,
			ja = 9.4
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play320251038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.925

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(320251037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 37 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 37)

				if (37 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 37)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251037", "story_v_out_320251.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251037", "story_v_out_320251.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_320251", "320251037", "story_v_out_320251.awb")

						arg_153_1:RecordAudio("320251037", var_156_6)
						arg_153_1:RecordAudio("320251037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_320251", "320251037", "story_v_out_320251.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_320251", "320251037", "story_v_out_320251.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play320251038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 320251038
		arg_157_1.duration_ = 15.17

		local var_157_0 = {
			zh = 10.7,
			ja = 15.166
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play320251039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action18_1")
			end

			local var_160_0 = 0
			local var_160_1 = 1.15

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(320251038)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 46 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 46)

				if (46 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 46)) > 0 and var_160_1 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251038", "story_v_out_320251.awb") ~= 0 then
					local var_160_6 = manager.audio:GetVoiceLength("story_v_out_320251", "320251038", "story_v_out_320251.awb") / 1000

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end

					if var_160_2.prefab_name ~= "" and arg_157_1.actors_[var_160_2.prefab_name] ~= nil then
						local var_160_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_2.prefab_name].transform, "story_v_out_320251", "320251038", "story_v_out_320251.awb")

						arg_157_1:RecordAudio("320251038", var_160_7)
						arg_157_1:RecordAudio("320251038", var_160_7)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_320251", "320251038", "story_v_out_320251.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_320251", "320251038", "story_v_out_320251.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_8 and arg_157_1.time_ < var_160_0 + var_160_8 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play320251039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 320251039
		arg_161_1.duration_ = 14.7

		local var_161_0 = {
			zh = 13.033,
			ja = 14.7
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play320251040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.55

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(320251039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 62 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 62)

				if (62 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 62)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251039", "story_v_out_320251.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251039", "story_v_out_320251.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_320251", "320251039", "story_v_out_320251.awb")

						arg_161_1:RecordAudio("320251039", var_164_6)
						arg_161_1:RecordAudio("320251039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_320251", "320251039", "story_v_out_320251.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_320251", "320251039", "story_v_out_320251.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play320251040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 320251040
		arg_165_1.duration_ = 13.87

		local var_165_0 = {
			zh = 9.1,
			ja = 13.866
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play320251041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.25

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(320251040)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 50 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 50)

				if (50 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 50)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251040", "story_v_out_320251.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251040", "story_v_out_320251.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_320251", "320251040", "story_v_out_320251.awb")

						arg_165_1:RecordAudio("320251040", var_168_6)
						arg_165_1:RecordAudio("320251040", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_320251", "320251040", "story_v_out_320251.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_320251", "320251040", "story_v_out_320251.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play320251041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 320251041
		arg_169_1.duration_ = 14.3

		local var_169_0 = {
			zh = 11.5,
			ja = 14.3
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play320251042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action41821")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_0 = 0
			local var_172_1 = 1.275

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:GetWordFromCfg(320251041)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 52 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_3) / 52)

				if (52 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_3) / 52)) > 0 and var_172_1 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251041", "story_v_out_320251.awb") ~= 0 then
					local var_172_6 = manager.audio:GetVoiceLength("story_v_out_320251", "320251041", "story_v_out_320251.awb") / 1000

					if var_172_6 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_0
					end

					if var_172_2.prefab_name ~= "" and arg_169_1.actors_[var_172_2.prefab_name] ~= nil then
						local var_172_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_2.prefab_name].transform, "story_v_out_320251", "320251041", "story_v_out_320251.awb")

						arg_169_1:RecordAudio("320251041", var_172_7)
						arg_169_1:RecordAudio("320251041", var_172_7)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_320251", "320251041", "story_v_out_320251.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_320251", "320251041", "story_v_out_320251.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_8 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_8 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_8

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_8 and arg_169_1.time_ < var_172_0 + var_172_8 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play320251042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 320251042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play320251043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["10100ui_story"]) and arg_173_1.var_.characterEffect10100ui_story == nil then
				arg_173_1.var_.characterEffect10100ui_story = arg_173_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["10100ui_story"]) then
				if arg_173_1.var_.characterEffect10100ui_story and not isNil(arg_173_1.actors_["10100ui_story"]) then
					arg_173_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["10100ui_story"]) and arg_173_1.var_.characterEffect10100ui_story then
				arg_173_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 0.333333333333333 < arg_173_1.time_ and arg_173_1.time_ <= 0.333333333333333 + arg_176_0 then
				arg_173_1:AudioAction("play", "effect", "se_story_122_battle", "se_story_122_battle_adminshoot_hit", "")
			end

			if 0.333333333333333 < arg_173_1.time_ and arg_173_1.time_ <= 0.333333333333333 + arg_176_0 then
				arg_173_1:AudioAction("play", "effect", "se_story_127", "se_story_127_noise", "")
			end

			local var_176_3 = 0
			local var_176_4 = 1.35

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_3 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_5 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(320251042).content)

				arg_173_1.text_.text = var_176_5

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 54 <= 0 and var_176_4 or var_176_4 * (utf8.len(var_176_5) / 54)

				if (54 <= 0 and var_176_4 or var_176_4 * (utf8.len(var_176_5) / 54)) > 0 and var_176_4 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_3 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_3
					end
				end

				arg_173_1.text_.text = var_176_5
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_4, arg_173_1.talkMaxDuration)

			if var_176_3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_3 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_3) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_3 + var_176_8 and arg_173_1.time_ < var_176_3 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play320251043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 320251043
		arg_177_1.duration_ = 8.43

		local var_177_0 = {
			zh = 8.433,
			ja = 7.533
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play320251044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10100ui_story"]) and arg_177_1.var_.characterEffect10100ui_story == nil then
				arg_177_1.var_.characterEffect10100ui_story = arg_177_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10100ui_story"]) then
				if arg_177_1.var_.characterEffect10100ui_story and not isNil(arg_177_1.actors_["10100ui_story"]) then
					arg_177_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10100ui_story"]) and arg_177_1.var_.characterEffect10100ui_story then
				arg_177_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action21_2")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:AudioAction("stop", "effect", "se_story_127", "se_story_127_noise", "")
			end

			local var_180_3 = 0
			local var_180_4 = 1.175

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_3 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_5 = arg_177_1:GetWordFromCfg(320251043)
				local var_180_6 = arg_177_1:FormatText(var_180_5.content)

				arg_177_1.text_.text = var_180_6

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_8 = 47 <= 0 and var_180_4 or var_180_4 * (utf8.len(var_180_6) / 47)

				if (47 <= 0 and var_180_4 or var_180_4 * (utf8.len(var_180_6) / 47)) > 0 and var_180_4 < var_180_8 then
					arg_177_1.talkMaxDuration = var_180_8

					if var_180_8 + var_180_3 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_3
					end
				end

				arg_177_1.text_.text = var_180_6
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251043", "story_v_out_320251.awb") ~= 0 then
					local var_180_9 = manager.audio:GetVoiceLength("story_v_out_320251", "320251043", "story_v_out_320251.awb") / 1000

					if var_180_9 + var_180_3 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_3
					end

					if var_180_5.prefab_name ~= "" and arg_177_1.actors_[var_180_5.prefab_name] ~= nil then
						local var_180_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_5.prefab_name].transform, "story_v_out_320251", "320251043", "story_v_out_320251.awb")

						arg_177_1:RecordAudio("320251043", var_180_10)
						arg_177_1:RecordAudio("320251043", var_180_10)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_320251", "320251043", "story_v_out_320251.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_320251", "320251043", "story_v_out_320251.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_11 = math.max(var_180_4, arg_177_1.talkMaxDuration)

			if var_180_3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_3 + var_180_11 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_3) / var_180_11

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_3 + var_180_11 and arg_177_1.time_ < var_180_3 + var_180_11 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play320251044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 320251044
		arg_181_1.duration_ = 5.57

		local var_181_0 = {
			zh = 3.833,
			ja = 5.566
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play320251045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.45

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(320251044)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 18 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 18)

				if (18 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 18)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251044", "story_v_out_320251.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251044", "story_v_out_320251.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_320251", "320251044", "story_v_out_320251.awb")

						arg_181_1:RecordAudio("320251044", var_184_6)
						arg_181_1:RecordAudio("320251044", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_320251", "320251044", "story_v_out_320251.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_320251", "320251044", "story_v_out_320251.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play320251045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 320251045
		arg_185_1.duration_ = 7.87

		local var_185_0 = {
			zh = 6.46733333518108,
			ja = 7.86733333518108
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play320251046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 then
				local var_188_0 = arg_185_1.bgs_.ST61

				arg_185_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_188_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_1 = var_188_0:GetComponent("SpriteRenderer")

				if var_188_1 and var_188_1.sprite then
					local var_188_2 = 2 * (var_188_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_188_0.transform.localScale = Vector3.New(var_188_2 / var_188_1.sprite.bounds.size.y < var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x and var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x or var_188_2 / var_188_1.sprite.bounds.size.y, var_188_2 / var_188_1.sprite.bounds.size.y < var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x and var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x or var_188_2 / var_188_1.sprite.bounds.size.y, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "ST61" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_3 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_4 = 2

			if var_188_3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_3 + var_188_4 then
				local var_188_5 = Color.New(0, 0, 0)

				var_188_5.a = Mathf.Lerp(0, 1, (arg_185_1.time_ - var_188_3) / var_188_4)
				arg_185_1.mask_.color = var_188_5
			end

			if arg_185_1.time_ >= var_188_3 + var_188_4 and arg_185_1.time_ < var_188_3 + var_188_4 + arg_188_0 then
				local var_188_6 = Color.New(0, 0, 0)

				var_188_6.a = 1
				arg_185_1.mask_.color = var_188_6
			end

			local var_188_7 = 2

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_8 = 2

			if var_188_7 <= arg_185_1.time_ and arg_185_1.time_ < var_188_7 + var_188_8 then
				local var_188_9 = Color.New(0, 0, 0)

				var_188_9.a = Mathf.Lerp(1, 0, (arg_185_1.time_ - var_188_7) / var_188_8)
				arg_185_1.mask_.color = var_188_9
			end

			if arg_185_1.time_ >= var_188_7 + var_188_8 and arg_185_1.time_ < var_188_7 + var_188_8 + arg_188_0 then
				local var_188_10 = Color.New(0, 0, 0)

				arg_185_1.mask_.enabled = false
				var_188_10.a = 0
				arg_185_1.mask_.color = var_188_10
			end

			local var_188_11 = arg_185_1.actors_["10100ui_story"].transform

			if 1.96666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 1.96666666666667 + arg_188_0 then
				arg_185_1.var_.moveOldPos10100ui_story = var_188_11.localPosition
			end

			local var_188_12 = 0.001

			if 1.96666666666667 <= arg_185_1.time_ and arg_185_1.time_ < 1.96666666666667 + var_188_12 then
				var_188_11.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 1.96666666666667) / var_188_12)
				var_188_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_11.position).x, (manager.ui.mainCamera.transform.position - var_188_11.position).y, (manager.ui.mainCamera.transform.position - var_188_11.position).z)
				var_188_11.localEulerAngles.z = 0
				var_188_11.localEulerAngles.x = 0
				var_188_11.localEulerAngles = var_188_11.localEulerAngles
			end

			if arg_185_1.time_ >= 1.96666666666667 + var_188_12 and arg_185_1.time_ < 1.96666666666667 + var_188_12 + arg_188_0 then
				var_188_11.localPosition = Vector3.New(0, 100, 0)
				var_188_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_11.position).x, (manager.ui.mainCamera.transform.position - var_188_11.position).y, (manager.ui.mainCamera.transform.position - var_188_11.position).z)
				var_188_11.localEulerAngles.z = 0
				var_188_11.localEulerAngles.x = 0
				var_188_11.localEulerAngles = var_188_11.localEulerAngles
			end

			local var_188_13 = arg_185_1.actors_["1089ui_story"].transform

			if 3.73333333333333 < arg_185_1.time_ and arg_185_1.time_ <= 3.73333333333333 + arg_188_0 then
				arg_185_1.var_.moveOldPos1089ui_story = var_188_13.localPosition
			end

			local var_188_14 = 0.001

			if 3.73333333333333 <= arg_185_1.time_ and arg_185_1.time_ < 3.73333333333333 + var_188_14 then
				var_188_13.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_185_1.time_ - 3.73333333333333) / var_188_14)
				var_188_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_13.position).x, (manager.ui.mainCamera.transform.position - var_188_13.position).y, (manager.ui.mainCamera.transform.position - var_188_13.position).z)
				var_188_13.localEulerAngles.z = 0
				var_188_13.localEulerAngles.x = 0
				var_188_13.localEulerAngles = var_188_13.localEulerAngles
			end

			if arg_185_1.time_ >= 3.73333333333333 + var_188_14 and arg_185_1.time_ < 3.73333333333333 + var_188_14 + arg_188_0 then
				var_188_13.localPosition = Vector3.New(0, -1.1, -6.17)
				var_188_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_13.position).x, (manager.ui.mainCamera.transform.position - var_188_13.position).y, (manager.ui.mainCamera.transform.position - var_188_13.position).z)
				var_188_13.localEulerAngles.z = 0
				var_188_13.localEulerAngles.x = 0
				var_188_13.localEulerAngles = var_188_13.localEulerAngles
			end

			local var_188_15 = arg_185_1.actors_["1089ui_story"]

			if 3.73333333333333 < arg_185_1.time_ and arg_185_1.time_ <= 3.73333333333333 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.characterEffect1089ui_story == nil then
				arg_185_1.var_.characterEffect1089ui_story = var_188_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_16 = 0.200000002980232

			if 3.73333333333333 <= arg_185_1.time_ and arg_185_1.time_ < 3.73333333333333 + var_188_16 and not isNil(var_188_15) then
				if arg_185_1.var_.characterEffect1089ui_story and not isNil(var_188_15) then
					arg_185_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 3.73333333333333 + var_188_16 and arg_185_1.time_ < 3.73333333333333 + var_188_16 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.characterEffect1089ui_story then
				arg_185_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 3.73333333333333 < arg_185_1.time_ and arg_185_1.time_ <= 3.73333333333333 + arg_188_0 then
				arg_185_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 3.73333333333333 < arg_185_1.time_ and arg_185_1.time_ <= 3.73333333333333 + arg_188_0 then
				arg_185_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_18 = 3.76733333518108
			local var_188_19 = 0.325

			if 3.76733333518108 < arg_185_1.time_ and arg_185_1.time_ <= var_188_18 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_20 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_20:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_21 = arg_185_1:GetWordFromCfg(320251045)
				local var_188_22 = arg_185_1:FormatText(var_188_21.content)

				arg_185_1.text_.text = var_188_22

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_24 = 13 <= 0 and var_188_19 or var_188_19 * (utf8.len(var_188_22) / 13)

				if (13 <= 0 and var_188_19 or var_188_19 * (utf8.len(var_188_22) / 13)) > 0 and var_188_19 < var_188_24 then
					arg_185_1.talkMaxDuration = var_188_24
					var_188_18 = var_188_18 + 0.3

					if var_188_24 + var_188_18 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_24 + var_188_18
					end
				end

				arg_185_1.text_.text = var_188_22
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251045", "story_v_out_320251.awb") ~= 0 then
					local var_188_25 = manager.audio:GetVoiceLength("story_v_out_320251", "320251045", "story_v_out_320251.awb") / 1000

					if var_188_25 + var_188_18 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_25 + var_188_18
					end

					if var_188_21.prefab_name ~= "" and arg_185_1.actors_[var_188_21.prefab_name] ~= nil then
						local var_188_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_21.prefab_name].transform, "story_v_out_320251", "320251045", "story_v_out_320251.awb")

						arg_185_1:RecordAudio("320251045", var_188_26)
						arg_185_1:RecordAudio("320251045", var_188_26)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_320251", "320251045", "story_v_out_320251.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_320251", "320251045", "story_v_out_320251.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_27 = var_188_18 + 0.3
			local var_188_28 = math.max(var_188_19, arg_185_1.talkMaxDuration)

			if var_188_18 + 0.3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_27 + var_188_28 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_27) / var_188_28

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_27 + var_188_28 and arg_185_1.time_ < var_188_27 + var_188_28 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play320251046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 320251046
		arg_191_1.duration_ = 12.53

		local var_191_0 = {
			zh = 7.9,
			ja = 12.533
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play320251047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.85

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(320251046)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 34 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 34)

				if (34 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 34)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251046", "story_v_out_320251.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251046", "story_v_out_320251.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_320251", "320251046", "story_v_out_320251.awb")

						arg_191_1:RecordAudio("320251046", var_194_6)
						arg_191_1:RecordAudio("320251046", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_320251", "320251046", "story_v_out_320251.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_320251", "320251046", "story_v_out_320251.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play320251047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 320251047
		arg_195_1.duration_ = 12.93

		local var_195_0 = {
			zh = 11.533,
			ja = 12.933
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play320251048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			local var_198_0 = 0
			local var_198_1 = 1.4

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_2 = arg_195_1:GetWordFromCfg(320251047)
				local var_198_3 = arg_195_1:FormatText(var_198_2.content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 56 <= 0 and var_198_1 or var_198_1 * (utf8.len(var_198_3) / 56)

				if (56 <= 0 and var_198_1 or var_198_1 * (utf8.len(var_198_3) / 56)) > 0 and var_198_1 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251047", "story_v_out_320251.awb") ~= 0 then
					local var_198_6 = manager.audio:GetVoiceLength("story_v_out_320251", "320251047", "story_v_out_320251.awb") / 1000

					if var_198_6 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_0
					end

					if var_198_2.prefab_name ~= "" and arg_195_1.actors_[var_198_2.prefab_name] ~= nil then
						local var_198_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_2.prefab_name].transform, "story_v_out_320251", "320251047", "story_v_out_320251.awb")

						arg_195_1:RecordAudio("320251047", var_198_7)
						arg_195_1:RecordAudio("320251047", var_198_7)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_320251", "320251047", "story_v_out_320251.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_320251", "320251047", "story_v_out_320251.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_8 and arg_195_1.time_ < var_198_0 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play320251048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 320251048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play320251049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1089ui_story = arg_199_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1089ui_story"].transform.position).z)
				arg_199_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1089ui_story"].transform.localEulerAngles = arg_199_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1089ui_story"].transform.position).z)
				arg_199_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1089ui_story"].transform.localEulerAngles = arg_199_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["1089ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1089ui_story == nil then
				arg_199_1.var_.characterEffect1089ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect1089ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_2)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1089ui_story then
				arg_199_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_202_3 = 0
			local var_202_4 = 0.975

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_3 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_5 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(320251048).content)

				arg_199_1.text_.text = var_202_5

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_7 = 39 <= 0 and var_202_4 or var_202_4 * (utf8.len(var_202_5) / 39)

				if (39 <= 0 and var_202_4 or var_202_4 * (utf8.len(var_202_5) / 39)) > 0 and var_202_4 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_3 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_3
					end
				end

				arg_199_1.text_.text = var_202_5
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_8 = math.max(var_202_4, arg_199_1.talkMaxDuration)

			if var_202_3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_3 + var_202_8 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_3) / var_202_8

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_3 + var_202_8 and arg_199_1.time_ < var_202_3 + var_202_8 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play320251049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 320251049
		arg_203_1.duration_ = 5.1

		local var_203_0 = {
			zh = 3.833,
			ja = 5.1
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play320251050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1056ui_story = arg_203_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1056ui_story"].transform.position).z)
				arg_203_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1056ui_story"].transform.localEulerAngles = arg_203_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, -1, -5.75)
				arg_203_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1056ui_story"].transform.position).z)
				arg_203_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1056ui_story"].transform.localEulerAngles = arg_203_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1056ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1056ui_story == nil then
				arg_203_1.var_.characterEffect1056ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1056ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1056ui_story then
				arg_203_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_4 = 0
			local var_206_5 = 0.475

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(320251049)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 19 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 19)

				if (19 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 19)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251049", "story_v_out_320251.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251049", "story_v_out_320251.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_320251", "320251049", "story_v_out_320251.awb")

						arg_203_1:RecordAudio("320251049", var_206_11)
						arg_203_1:RecordAudio("320251049", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_320251", "320251049", "story_v_out_320251.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_320251", "320251049", "story_v_out_320251.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play320251050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 320251050
		arg_207_1.duration_ = 12.8

		local var_207_0 = {
			zh = 12.8,
			ja = 9.533
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play320251051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1089ui_story = arg_207_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1089ui_story"].transform.position).z)
				arg_207_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1089ui_story"].transform.localEulerAngles = arg_207_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_207_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1089ui_story"].transform.position).z)
				arg_207_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1089ui_story"].transform.localEulerAngles = arg_207_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1089ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1089ui_story == nil then
				arg_207_1.var_.characterEffect1089ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1089ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1089ui_story then
				arg_207_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action432")
			end

			local var_210_4 = arg_207_1.actors_["1056ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1056ui_story = var_210_4.localPosition
			end

			local var_210_5 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_5 then
				var_210_4.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1056ui_story, Vector3.New(0.7, -1, -5.75), (arg_207_1.time_ - 0) / var_210_5)
				var_210_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_4.position).x, (manager.ui.mainCamera.transform.position - var_210_4.position).y, (manager.ui.mainCamera.transform.position - var_210_4.position).z)
				var_210_4.localEulerAngles.z = 0
				var_210_4.localEulerAngles.x = 0
				var_210_4.localEulerAngles = var_210_4.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_5 and arg_207_1.time_ < 0 + var_210_5 + arg_210_0 then
				var_210_4.localPosition = Vector3.New(0.7, -1, -5.75)
				var_210_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_4.position).x, (manager.ui.mainCamera.transform.position - var_210_4.position).y, (manager.ui.mainCamera.transform.position - var_210_4.position).z)
				var_210_4.localEulerAngles.z = 0
				var_210_4.localEulerAngles.x = 0
				var_210_4.localEulerAngles = var_210_4.localEulerAngles
			end

			local var_210_6 = arg_207_1.actors_["1056ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect1056ui_story == nil then
				arg_207_1.var_.characterEffect1056ui_story = var_210_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_7 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 and not isNil(var_210_6) then
				if arg_207_1.var_.characterEffect1056ui_story and not isNil(var_210_6) then
					arg_207_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_7)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect1056ui_story then
				arg_207_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_210_8 = 0
			local var_210_9 = 1.15

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_10 = arg_207_1:GetWordFromCfg(320251050)
				local var_210_11 = arg_207_1:FormatText(var_210_10.content)

				arg_207_1.text_.text = var_210_11

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_13 = 46 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 46)

				if (46 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 46)) > 0 and var_210_9 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_11
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251050", "story_v_out_320251.awb") ~= 0 then
					local var_210_14 = manager.audio:GetVoiceLength("story_v_out_320251", "320251050", "story_v_out_320251.awb") / 1000

					if var_210_14 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_8
					end

					if var_210_10.prefab_name ~= "" and arg_207_1.actors_[var_210_10.prefab_name] ~= nil then
						local var_210_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_10.prefab_name].transform, "story_v_out_320251", "320251050", "story_v_out_320251.awb")

						arg_207_1:RecordAudio("320251050", var_210_15)
						arg_207_1:RecordAudio("320251050", var_210_15)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_320251", "320251050", "story_v_out_320251.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_320251", "320251050", "story_v_out_320251.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_16 = math.max(var_210_9, arg_207_1.talkMaxDuration)

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_16 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_8) / var_210_16

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_8 + var_210_16 and arg_207_1.time_ < var_210_8 + var_210_16 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play320251051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 320251051
		arg_211_1.duration_ = 3.9

		local var_211_0 = {
			zh = 3.9,
			ja = 2.366
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play320251052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1056ui_story"]) and arg_211_1.var_.characterEffect1056ui_story == nil then
				arg_211_1.var_.characterEffect1056ui_story = arg_211_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1056ui_story"]) then
				if arg_211_1.var_.characterEffect1056ui_story and not isNil(arg_211_1.actors_["1056ui_story"]) then
					arg_211_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1056ui_story"]) and arg_211_1.var_.characterEffect1056ui_story then
				arg_211_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action2_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_214_2 = arg_211_1.actors_["1089ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.characterEffect1089ui_story == nil then
				arg_211_1.var_.characterEffect1089ui_story = var_214_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_3 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_3 and not isNil(var_214_2) then
				if arg_211_1.var_.characterEffect1089ui_story and not isNil(var_214_2) then
					arg_211_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_3)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_3 and arg_211_1.time_ < 0 + var_214_3 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.characterEffect1089ui_story then
				arg_211_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_214_4 = 0
			local var_214_5 = 0.275

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(320251051)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 11 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 11)

				if (11 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 11)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251051", "story_v_out_320251.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251051", "story_v_out_320251.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_out_320251", "320251051", "story_v_out_320251.awb")

						arg_211_1:RecordAudio("320251051", var_214_11)
						arg_211_1:RecordAudio("320251051", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_320251", "320251051", "story_v_out_320251.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_320251", "320251051", "story_v_out_320251.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_12 and arg_211_1.time_ < var_214_4 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play320251052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 320251052
		arg_215_1.duration_ = 13.3

		local var_215_0 = {
			zh = 11.5,
			ja = 13.3
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play320251053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1056ui_story"]) and arg_215_1.var_.characterEffect1056ui_story == nil then
				arg_215_1.var_.characterEffect1056ui_story = arg_215_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1056ui_story"]) then
				if arg_215_1.var_.characterEffect1056ui_story and not isNil(arg_215_1.actors_["1056ui_story"]) then
					arg_215_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1056ui_story"]) and arg_215_1.var_.characterEffect1056ui_story then
				arg_215_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_218_1 = arg_215_1.actors_["1089ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1089ui_story == nil then
				arg_215_1.var_.characterEffect1089ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1089ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1089ui_story then
				arg_215_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_218_4 = 0
			local var_218_5 = 1.15

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(320251052)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 46 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 46)

				if (46 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 46)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251052", "story_v_out_320251.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251052", "story_v_out_320251.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_320251", "320251052", "story_v_out_320251.awb")

						arg_215_1:RecordAudio("320251052", var_218_11)
						arg_215_1:RecordAudio("320251052", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_320251", "320251052", "story_v_out_320251.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_320251", "320251052", "story_v_out_320251.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play320251053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 320251053
		arg_219_1.duration_ = 11.37

		local var_219_0 = {
			zh = 8.4,
			ja = 11.366
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play320251054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_222_0 = 0
			local var_222_1 = 0.825

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(320251053)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 33 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 33)

				if (33 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 33)) > 0 and var_222_1 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251053", "story_v_out_320251.awb") ~= 0 then
					local var_222_6 = manager.audio:GetVoiceLength("story_v_out_320251", "320251053", "story_v_out_320251.awb") / 1000

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end

					if var_222_2.prefab_name ~= "" and arg_219_1.actors_[var_222_2.prefab_name] ~= nil then
						local var_222_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_2.prefab_name].transform, "story_v_out_320251", "320251053", "story_v_out_320251.awb")

						arg_219_1:RecordAudio("320251053", var_222_7)
						arg_219_1:RecordAudio("320251053", var_222_7)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_320251", "320251053", "story_v_out_320251.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_320251", "320251053", "story_v_out_320251.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_8 and arg_219_1.time_ < var_222_0 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play320251054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 320251054
		arg_223_1.duration_ = 5.73

		local var_223_0 = {
			zh = 5.69933333333333,
			ja = 5.73333333333333
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play320251055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 2 < arg_223_1.time_ and arg_223_1.time_ <= 2 + arg_226_0 then
				local var_226_0 = arg_223_1.bgs_.L02f

				arg_223_1.bgs_.L02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_226_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_226_1 = var_226_0:GetComponent("SpriteRenderer")

				if var_226_1 and var_226_1.sprite then
					local var_226_2 = 2 * (var_226_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_226_0.transform.localScale = Vector3.New(var_226_2 / var_226_1.sprite.bounds.size.y < var_226_2 * manager.ui.mainCameraCom_.aspect / var_226_1.sprite.bounds.size.x and var_226_2 * manager.ui.mainCameraCom_.aspect / var_226_1.sprite.bounds.size.x or var_226_2 / var_226_1.sprite.bounds.size.y, var_226_2 / var_226_1.sprite.bounds.size.y < var_226_2 * manager.ui.mainCameraCom_.aspect / var_226_1.sprite.bounds.size.x and var_226_2 * manager.ui.mainCameraCom_.aspect / var_226_1.sprite.bounds.size.x or var_226_2 / var_226_1.sprite.bounds.size.y, 0)
				end

				for iter_226_0, iter_226_1 in pairs(arg_223_1.bgs_) do
					if iter_226_0 ~= "L02f" then
						iter_226_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_226_3 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_3 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			if arg_223_1.time_ >= var_226_3 + 0.3 and arg_223_1.time_ < var_226_3 + 0.3 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			local var_226_4 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_5 = 2

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_5 then
				local var_226_6 = Color.New(0, 0, 0)

				var_226_6.a = Mathf.Lerp(0, 1, (arg_223_1.time_ - var_226_4) / var_226_5)
				arg_223_1.mask_.color = var_226_6
			end

			if arg_223_1.time_ >= var_226_4 + var_226_5 and arg_223_1.time_ < var_226_4 + var_226_5 + arg_226_0 then
				local var_226_7 = Color.New(0, 0, 0)

				var_226_7.a = 1
				arg_223_1.mask_.color = var_226_7
			end

			local var_226_8 = 2

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_9 = 1.43333333333333

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_9 then
				local var_226_10 = Color.New(0, 0, 0)

				var_226_10.a = Mathf.Lerp(1, 0, (arg_223_1.time_ - var_226_8) / var_226_9)
				arg_223_1.mask_.color = var_226_10
			end

			if arg_223_1.time_ >= var_226_8 + var_226_9 and arg_223_1.time_ < var_226_8 + var_226_9 + arg_226_0 then
				local var_226_11 = Color.New(0, 0, 0)

				arg_223_1.mask_.enabled = false
				var_226_11.a = 0
				arg_223_1.mask_.color = var_226_11
			end

			local var_226_12 = arg_223_1.actors_["1056ui_story"].transform

			if 1.96666666666667 < arg_223_1.time_ and arg_223_1.time_ <= 1.96666666666667 + arg_226_0 then
				arg_223_1.var_.moveOldPos1056ui_story = var_226_12.localPosition
			end

			local var_226_13 = 0.001

			if 1.96666666666667 <= arg_223_1.time_ and arg_223_1.time_ < 1.96666666666667 + var_226_13 then
				var_226_12.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 1.96666666666667) / var_226_13)
				var_226_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_12.position).x, (manager.ui.mainCamera.transform.position - var_226_12.position).y, (manager.ui.mainCamera.transform.position - var_226_12.position).z)
				var_226_12.localEulerAngles.z = 0
				var_226_12.localEulerAngles.x = 0
				var_226_12.localEulerAngles = var_226_12.localEulerAngles
			end

			if arg_223_1.time_ >= 1.96666666666667 + var_226_13 and arg_223_1.time_ < 1.96666666666667 + var_226_13 + arg_226_0 then
				var_226_12.localPosition = Vector3.New(0, 100, 0)
				var_226_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_12.position).x, (manager.ui.mainCamera.transform.position - var_226_12.position).y, (manager.ui.mainCamera.transform.position - var_226_12.position).z)
				var_226_12.localEulerAngles.z = 0
				var_226_12.localEulerAngles.x = 0
				var_226_12.localEulerAngles = var_226_12.localEulerAngles
			end

			local var_226_14 = arg_223_1.actors_["1089ui_story"].transform

			if 1.96666666666667 < arg_223_1.time_ and arg_223_1.time_ <= 1.96666666666667 + arg_226_0 then
				arg_223_1.var_.moveOldPos1089ui_story = var_226_14.localPosition
			end

			local var_226_15 = 0.001

			if 1.96666666666667 <= arg_223_1.time_ and arg_223_1.time_ < 1.96666666666667 + var_226_15 then
				var_226_14.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 1.96666666666667) / var_226_15)
				var_226_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_14.position).x, (manager.ui.mainCamera.transform.position - var_226_14.position).y, (manager.ui.mainCamera.transform.position - var_226_14.position).z)
				var_226_14.localEulerAngles.z = 0
				var_226_14.localEulerAngles.x = 0
				var_226_14.localEulerAngles = var_226_14.localEulerAngles
			end

			if arg_223_1.time_ >= 1.96666666666667 + var_226_15 and arg_223_1.time_ < 1.96666666666667 + var_226_15 + arg_226_0 then
				var_226_14.localPosition = Vector3.New(0, 100, 0)
				var_226_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_14.position).x, (manager.ui.mainCamera.transform.position - var_226_14.position).y, (manager.ui.mainCamera.transform.position - var_226_14.position).z)
				var_226_14.localEulerAngles.z = 0
				var_226_14.localEulerAngles.x = 0
				var_226_14.localEulerAngles = var_226_14.localEulerAngles
			end

			if 1.76666666666667 < arg_223_1.time_ and arg_223_1.time_ <= 1.76666666666667 + arg_226_0 then
				arg_223_1:AudioAction("play", "music", "se_story_15", "se_story_15_gun07", "")

				local var_226_18 = manager.audio:GetAudioName("se_story_15", "se_story_15_gun07")

				if "" ~= "" then
					if arg_223_1.bgmTxt_.text ~= var_226_18 and arg_223_1.bgmTxt_.text ~= "" then
						if arg_223_1.bgmTxt2_.text ~= "" then
							arg_223_1.bgmTxt_.text = arg_223_1.bgmTxt2_.text
						end

						arg_223_1.bgmTxt2_.text = var_226_18

						arg_223_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_223_1.bgmTxt_.text = var_226_18
						arg_223_1.bgmTxt2_.text = var_226_18
					end

					if arg_223_1.bgmTimer then
						arg_223_1.bgmTimer:Stop()

						arg_223_1.bgmTimer = nil
					end

					if arg_223_1.settingData.show_music_name == 1 then
						arg_223_1.musicController:SetSelectedState("show")
						arg_223_1.musicAnimator_:Play("open", 0, 0)

						if arg_223_1.settingData.music_time ~= 0 then
							arg_223_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_223_1.settingData.music_time), function()
								if arg_223_1 == nil or isNil(arg_223_1.bgmTxt_) then
									return
								end

								arg_223_1.musicController:SetSelectedState("hide")
								arg_223_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_226_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_223_1.bgmTxt_.text ~= var_226_21 and arg_223_1.bgmTxt_.text ~= "" then
						if arg_223_1.bgmTxt2_.text ~= "" then
							arg_223_1.bgmTxt_.text = arg_223_1.bgmTxt2_.text
						end

						arg_223_1.bgmTxt2_.text = var_226_21

						arg_223_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_223_1.bgmTxt_.text = var_226_21
						arg_223_1.bgmTxt2_.text = var_226_21
					end

					if arg_223_1.bgmTimer then
						arg_223_1.bgmTimer:Stop()

						arg_223_1.bgmTimer = nil
					end

					if arg_223_1.settingData.show_music_name == 1 then
						arg_223_1.musicController:SetSelectedState("show")
						arg_223_1.musicAnimator_:Play("open", 0, 0)

						if arg_223_1.settingData.music_time ~= 0 then
							arg_223_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_223_1.settingData.music_time), function()
								if arg_223_1 == nil or isNil(arg_223_1.bgmTxt_) then
									return
								end

								arg_223_1.musicController:SetSelectedState("hide")
								arg_223_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.33333333333333 < arg_223_1.time_ and arg_223_1.time_ <= 1.33333333333333 + arg_226_0 then
				arg_223_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_226_24 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_223_1.bgmTxt_.text ~= var_226_24 and arg_223_1.bgmTxt_.text ~= "" then
						if arg_223_1.bgmTxt2_.text ~= "" then
							arg_223_1.bgmTxt_.text = arg_223_1.bgmTxt2_.text
						end

						arg_223_1.bgmTxt2_.text = var_226_24

						arg_223_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_223_1.bgmTxt_.text = var_226_24
						arg_223_1.bgmTxt2_.text = var_226_24
					end

					if arg_223_1.bgmTimer then
						arg_223_1.bgmTimer:Stop()

						arg_223_1.bgmTimer = nil
					end

					if arg_223_1.settingData.show_music_name == 1 then
						arg_223_1.musicController:SetSelectedState("show")
						arg_223_1.musicAnimator_:Play("open", 0, 0)

						if arg_223_1.settingData.music_time ~= 0 then
							arg_223_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_223_1.settingData.music_time), function()
								if arg_223_1 == nil or isNil(arg_223_1.bgmTxt_) then
									return
								end

								arg_223_1.musicController:SetSelectedState("hide")
								arg_223_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_25 = 3.43333333333333
			local var_226_26 = 0.3

			if 3.43333333333333 < arg_223_1.time_ and arg_223_1.time_ <= var_226_25 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_27 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_27:setOnUpdate(LuaHelper.FloatAction(function(arg_230_0)
					arg_223_1.dialogCg_.alpha = arg_230_0
				end))
				var_226_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1066].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_28 = arg_223_1:GetWordFromCfg(320251054)
				local var_226_29 = arg_223_1:FormatText(var_226_28.content)

				arg_223_1.text_.text = var_226_29

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_31 = 12 <= 0 and var_226_26 or var_226_26 * (utf8.len(var_226_29) / 12)

				if (12 <= 0 and var_226_26 or var_226_26 * (utf8.len(var_226_29) / 12)) > 0 and var_226_26 < var_226_31 then
					arg_223_1.talkMaxDuration = var_226_31
					var_226_25 = var_226_25 + 0.3

					if var_226_31 + var_226_25 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_31 + var_226_25
					end
				end

				arg_223_1.text_.text = var_226_29
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251054", "story_v_out_320251.awb") ~= 0 then
					local var_226_32 = manager.audio:GetVoiceLength("story_v_out_320251", "320251054", "story_v_out_320251.awb") / 1000

					if var_226_32 + var_226_25 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_32 + var_226_25
					end

					if var_226_28.prefab_name ~= "" and arg_223_1.actors_[var_226_28.prefab_name] ~= nil then
						local var_226_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_28.prefab_name].transform, "story_v_out_320251", "320251054", "story_v_out_320251.awb")

						arg_223_1:RecordAudio("320251054", var_226_33)
						arg_223_1:RecordAudio("320251054", var_226_33)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_320251", "320251054", "story_v_out_320251.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_320251", "320251054", "story_v_out_320251.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_34 = var_226_25 + 0.3
			local var_226_35 = math.max(var_226_26, arg_223_1.talkMaxDuration)

			if var_226_25 + 0.3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_34 + var_226_35 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_34) / var_226_35

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_34 + var_226_35 and arg_223_1.time_ < var_226_34 + var_226_35 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play320251055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 320251055
		arg_232_1.duration_ = 4.3

		local var_232_0 = {
			zh = 4.233,
			ja = 4.3
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play320251056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0.6

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[1035].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_1 = arg_232_1:GetWordFromCfg(320251055)
				local var_235_2 = arg_232_1:FormatText(var_235_1.content)

				arg_232_1.text_.text = var_235_2

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_4 = 24 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 24)

				if (24 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 24)) > 0 and var_235_0 < var_235_4 then
					arg_232_1.talkMaxDuration = var_235_4

					if var_235_4 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_4 + 0
					end
				end

				arg_232_1.text_.text = var_235_2
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251055", "story_v_out_320251.awb") ~= 0 then
					local var_235_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251055", "story_v_out_320251.awb") / 1000

					if var_235_5 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + 0
					end

					if var_235_1.prefab_name ~= "" and arg_232_1.actors_[var_235_1.prefab_name] ~= nil then
						local var_235_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_1.prefab_name].transform, "story_v_out_320251", "320251055", "story_v_out_320251.awb")

						arg_232_1:RecordAudio("320251055", var_235_6)
						arg_232_1:RecordAudio("320251055", var_235_6)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_320251", "320251055", "story_v_out_320251.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_320251", "320251055", "story_v_out_320251.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_7 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_7 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_7

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_7 and arg_232_1.time_ < 0 + var_235_7 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play320251056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 320251056
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play320251057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 1.3

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_1 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(320251056).content)

				arg_236_1.text_.text = var_239_1

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_3 = 52 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 52)

				if (52 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 52)) > 0 and var_239_0 < var_239_3 then
					arg_236_1.talkMaxDuration = var_239_3

					if var_239_3 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_3 + 0
					end
				end

				arg_236_1.text_.text = var_239_1
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_4 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_4

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play320251057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 320251057
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play320251058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 1.025

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_1 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(320251057).content)

				arg_240_1.text_.text = var_243_1

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_3 = 41 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 41)

				if (41 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 41)) > 0 and var_243_0 < var_243_3 then
					arg_240_1.talkMaxDuration = var_243_3

					if var_243_3 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_3 + 0
					end
				end

				arg_240_1.text_.text = var_243_1
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_4 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_4

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play320251058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 320251058
		arg_244_1.duration_ = 2.93

		local var_244_0 = {
			zh = 2.8,
			ja = 2.933
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play320251059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.275

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[1035].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_1 = arg_244_1:GetWordFromCfg(320251058)
				local var_247_2 = arg_244_1:FormatText(var_247_1.content)

				arg_244_1.text_.text = var_247_2

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 11 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 11)

				if (11 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 11)) > 0 and var_247_0 < var_247_4 then
					arg_244_1.talkMaxDuration = var_247_4

					if var_247_4 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_4 + 0
					end
				end

				arg_244_1.text_.text = var_247_2
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251058", "story_v_out_320251.awb") ~= 0 then
					local var_247_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251058", "story_v_out_320251.awb") / 1000

					if var_247_5 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + 0
					end

					if var_247_1.prefab_name ~= "" and arg_244_1.actors_[var_247_1.prefab_name] ~= nil then
						local var_247_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_1.prefab_name].transform, "story_v_out_320251", "320251058", "story_v_out_320251.awb")

						arg_244_1:RecordAudio("320251058", var_247_6)
						arg_244_1:RecordAudio("320251058", var_247_6)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_320251", "320251058", "story_v_out_320251.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_320251", "320251058", "story_v_out_320251.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play320251059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 320251059
		arg_248_1.duration_ = 4.23

		local var_248_0 = {
			zh = 3.533,
			ja = 4.233
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play320251060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.175

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4043")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_1 = arg_248_1:GetWordFromCfg(320251059)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 7 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 7)

				if (7 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 7)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251059", "story_v_out_320251.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251059", "story_v_out_320251.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_320251", "320251059", "story_v_out_320251.awb")

						arg_248_1:RecordAudio("320251059", var_251_6)
						arg_248_1:RecordAudio("320251059", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_320251", "320251059", "story_v_out_320251.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_320251", "320251059", "story_v_out_320251.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play320251060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 320251060
		arg_252_1.duration_ = 6.37

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play320251061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_0 = 1

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 then
				local var_255_1 = Color.New(1, 1, 1)

				var_255_1.a = Mathf.Lerp(1, 0, (arg_252_1.time_ - 0) / var_255_0)
				arg_252_1.mask_.color = var_255_1
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 then
				local var_255_2 = Color.New(1, 1, 1)

				arg_252_1.mask_.enabled = false
				var_255_2.a = 0
				arg_252_1.mask_.color = var_255_2
			end

			if 0.333333333333333 < arg_252_1.time_ and arg_252_1.time_ <= 0.333333333333333 + arg_255_0 then
				arg_252_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_gun", "")
			end

			if arg_252_1.frameCnt_ <= 1 then
				arg_252_1.dialog_:SetActive(false)
			end

			local var_255_4 = 1.36666666666667
			local var_255_5 = 1.05

			if 1.36666666666667 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				arg_252_1.dialog_:SetActive(true)

				arg_252_1.dialogCg_.alpha = 0

				local var_255_6 = LeanTween.value(arg_252_1.dialog_, 0, 1, 0.3)

				var_255_6:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_252_1.dialogCg_.alpha = arg_256_0
				end))
				var_255_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_252_1.dialog_)
					var_255_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_252_1.duration_ = arg_252_1.duration_ + 0.3

				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_7 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(320251060).content)

				arg_252_1.text_.text = var_255_7

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_9 = 42 <= 0 and var_255_5 or var_255_5 * (utf8.len(var_255_7) / 42)

				if (42 <= 0 and var_255_5 or var_255_5 * (utf8.len(var_255_7) / 42)) > 0 and var_255_5 < var_255_9 then
					arg_252_1.talkMaxDuration = var_255_9
					var_255_4 = var_255_4 + 0.3

					if var_255_9 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_9 + var_255_4
					end
				end

				arg_252_1.text_.text = var_255_7
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_10 = var_255_4 + 0.3
			local var_255_11 = math.max(var_255_5, arg_252_1.talkMaxDuration)

			if var_255_4 + 0.3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_10 + var_255_11 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_10) / var_255_11

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_10 + var_255_11 and arg_252_1.time_ < var_255_10 + var_255_11 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play320251061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 320251061
		arg_258_1.duration_ = 4.1

		local var_258_0 = {
			zh = 3.8,
			ja = 4.1
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
				arg_258_0:Play320251062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.45

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1066].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_1 = arg_258_1:GetWordFromCfg(320251061)
				local var_261_2 = arg_258_1:FormatText(var_261_1.content)

				arg_258_1.text_.text = var_261_2

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 18 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 18)

				if (18 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 18)) > 0 and var_261_0 < var_261_4 then
					arg_258_1.talkMaxDuration = var_261_4

					if var_261_4 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_4 + 0
					end
				end

				arg_258_1.text_.text = var_261_2
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251061", "story_v_out_320251.awb") ~= 0 then
					local var_261_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251061", "story_v_out_320251.awb") / 1000

					if var_261_5 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + 0
					end

					if var_261_1.prefab_name ~= "" and arg_258_1.actors_[var_261_1.prefab_name] ~= nil then
						local var_261_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_1.prefab_name].transform, "story_v_out_320251", "320251061", "story_v_out_320251.awb")

						arg_258_1:RecordAudio("320251061", var_261_6)
						arg_258_1:RecordAudio("320251061", var_261_6)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_320251", "320251061", "story_v_out_320251.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_320251", "320251061", "story_v_out_320251.awb")
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
	Play320251062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 320251062
		arg_262_1.duration_ = 6.13

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play320251063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_9000

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				local var_265_0 = arg_262_1.var_.effect777

				if not arg_262_1.var_.effect777 then
					var_265_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning"), manager.ui.mainCamera.transform)
					var_265_0.name = "777"
					arg_262_1.var_.effect777 = var_265_0
				else
					var_265_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_265_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_265_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				local var_265_2 = arg_262_1.var_.effect888

				if not arg_262_1.var_.effect888 then
					var_265_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), manager.ui.mainCamera.transform)
					var_265_2.name = "888"
					arg_262_1.var_.effect888 = var_265_2
				else
					var_265_2.transform:SetParent(var_265_9000)
				end

				var_265_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_265_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_265_4 = 0

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1.mask_.enabled = true
				arg_262_1.mask_.raycastTarget = true

				arg_262_1:SetGaussion(false)
			end

			local var_265_5 = 1

			if var_265_4 <= arg_262_1.time_ and arg_262_1.time_ < var_265_4 + var_265_5 then
				local var_265_6 = Color.New(0.4433962, 0.04392132, 0.04392132)

				var_265_6.a = Mathf.Lerp(1, 0, (arg_262_1.time_ - var_265_4) / var_265_5)
				arg_262_1.mask_.color = var_265_6
			end

			if arg_262_1.time_ >= var_265_4 + var_265_5 and arg_262_1.time_ < var_265_4 + var_265_5 + arg_265_0 then
				local var_265_7 = Color.New(0.4433962, 0.04392132, 0.04392132)

				arg_262_1.mask_.enabled = false
				var_265_7.a = 0
				arg_262_1.mask_.color = var_265_7
			end

			local var_265_8 = 0

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_8 + arg_265_0 then
				arg_262_1.allBtn_.enabled = false
			end

			if arg_262_1.time_ >= var_265_8 + 1.5 and arg_262_1.time_ < var_265_8 + 1.5 + arg_265_0 then
				arg_262_1.allBtn_.enabled = true
			end

			if 0.266666666666667 < arg_262_1.time_ and arg_262_1.time_ <= 0.266666666666667 + arg_265_0 then
				arg_262_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun02", "")
			end

			if arg_262_1.frameCnt_ <= 1 then
				arg_262_1.dialog_:SetActive(false)
			end

			local var_265_10 = 1.13333333333333
			local var_265_11 = 1.5

			if 1.13333333333333 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0

				arg_262_1.dialog_:SetActive(true)

				arg_262_1.dialogCg_.alpha = 0

				local var_265_12 = LeanTween.value(arg_262_1.dialog_, 0, 1, 0.3)

				var_265_12:setOnUpdate(LuaHelper.FloatAction(function(arg_266_0)
					arg_262_1.dialogCg_.alpha = arg_266_0
				end))
				var_265_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_262_1.dialog_)
					var_265_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_262_1.duration_ = arg_262_1.duration_ + 0.3

				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_13 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(320251062).content)

				arg_262_1.text_.text = var_265_13

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_15 = 60 <= 0 and var_265_11 or var_265_11 * (utf8.len(var_265_13) / 60)

				if (60 <= 0 and var_265_11 or var_265_11 * (utf8.len(var_265_13) / 60)) > 0 and var_265_11 < var_265_15 then
					arg_262_1.talkMaxDuration = var_265_15
					var_265_10 = var_265_10 + 0.3

					if var_265_15 + var_265_10 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_15 + var_265_10
					end
				end

				arg_262_1.text_.text = var_265_13
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_16 = var_265_10 + 0.3
			local var_265_17 = math.max(var_265_11, arg_262_1.talkMaxDuration)

			if var_265_10 + 0.3 <= arg_262_1.time_ and arg_262_1.time_ < var_265_16 + var_265_17 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_16) / var_265_17

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_16 + var_265_17 and arg_262_1.time_ < var_265_16 + var_265_17 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play320251063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 320251063
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play320251064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 1.375

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(320251063).content)

				arg_268_1.text_.text = var_271_1

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_3 = 55 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 55)

				if (55 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 55)) > 0 and var_271_0 < var_271_3 then
					arg_268_1.talkMaxDuration = var_271_3

					if var_271_3 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_3 + 0
					end
				end

				arg_268_1.text_.text = var_271_1
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_4 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_4 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_4

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_4 and arg_268_1.time_ < 0 + var_271_4 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play320251064 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 320251064
		arg_272_1.duration_ = 1.43

		local var_272_0 = {
			zh = 1.433,
			ja = 1.2
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play320251065(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.075

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1066].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_1 = arg_272_1:GetWordFromCfg(320251064)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.text_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 3 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 3)

				if (3 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 3)) > 0 and var_275_0 < var_275_4 then
					arg_272_1.talkMaxDuration = var_275_4

					if var_275_4 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_4 + 0
					end
				end

				arg_272_1.text_.text = var_275_2
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251064", "story_v_out_320251.awb") ~= 0 then
					local var_275_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251064", "story_v_out_320251.awb") / 1000

					if var_275_5 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + 0
					end

					if var_275_1.prefab_name ~= "" and arg_272_1.actors_[var_275_1.prefab_name] ~= nil then
						local var_275_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_1.prefab_name].transform, "story_v_out_320251", "320251064", "story_v_out_320251.awb")

						arg_272_1:RecordAudio("320251064", var_275_6)
						arg_272_1:RecordAudio("320251064", var_275_6)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_320251", "320251064", "story_v_out_320251.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_320251", "320251064", "story_v_out_320251.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_7 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_7

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play320251065 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 320251065
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play320251066(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:AudioAction("play", "music", "se_story_side_1148", "se_story_1148_explosion", "")

				local var_279_2 = manager.audio:GetAudioName("se_story_side_1148", "se_story_1148_explosion")

				if "" ~= "" then
					if arg_276_1.bgmTxt_.text ~= var_279_2 and arg_276_1.bgmTxt_.text ~= "" then
						if arg_276_1.bgmTxt2_.text ~= "" then
							arg_276_1.bgmTxt_.text = arg_276_1.bgmTxt2_.text
						end

						arg_276_1.bgmTxt2_.text = var_279_2

						arg_276_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_276_1.bgmTxt_.text = var_279_2
						arg_276_1.bgmTxt2_.text = var_279_2
					end

					if arg_276_1.bgmTimer then
						arg_276_1.bgmTimer:Stop()

						arg_276_1.bgmTimer = nil
					end

					if arg_276_1.settingData.show_music_name == 1 then
						arg_276_1.musicController:SetSelectedState("show")
						arg_276_1.musicAnimator_:Play("open", 0, 0)

						if arg_276_1.settingData.music_time ~= 0 then
							arg_276_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_276_1.settingData.music_time), function()
								if arg_276_1 == nil or isNil(arg_276_1.bgmTxt_) then
									return
								end

								arg_276_1.musicController:SetSelectedState("hide")
								arg_276_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_279_3 = 0
			local var_279_4 = 0.8

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_3 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_5 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(320251065).content)

				arg_276_1.text_.text = var_279_5

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_7 = 32 <= 0 and var_279_4 or var_279_4 * (utf8.len(var_279_5) / 32)

				if (32 <= 0 and var_279_4 or var_279_4 * (utf8.len(var_279_5) / 32)) > 0 and var_279_4 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_3 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_3
					end
				end

				arg_276_1.text_.text = var_279_5
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_8 = math.max(var_279_4, arg_276_1.talkMaxDuration)

			if var_279_3 <= arg_276_1.time_ and arg_276_1.time_ < var_279_3 + var_279_8 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_3) / var_279_8

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_3 + var_279_8 and arg_276_1.time_ < var_279_3 + var_279_8 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play320251066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 320251066
		arg_281_1.duration_ = 3.03

		local var_281_0 = {
			zh = 2.133,
			ja = 3.033
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play320251067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.175

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1035].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_1 = arg_281_1:GetWordFromCfg(320251066)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 7 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 7)

				if (7 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 7)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251066", "story_v_out_320251.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251066", "story_v_out_320251.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_320251", "320251066", "story_v_out_320251.awb")

						arg_281_1:RecordAudio("320251066", var_284_6)
						arg_281_1:RecordAudio("320251066", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_320251", "320251066", "story_v_out_320251.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_320251", "320251066", "story_v_out_320251.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play320251067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 320251067
		arg_285_1.duration_ = 5.57

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play320251068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.mask_.enabled = true
				arg_285_1.mask_.raycastTarget = true

				arg_285_1:SetGaussion(false)
			end

			local var_288_0 = 0.166666666666667

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				local var_288_1 = Color.New(1, 1, 1)

				var_288_1.a = Mathf.Lerp(1, 0, (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.mask_.color = var_288_1
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				local var_288_2 = Color.New(1, 1, 1)

				arg_285_1.mask_.enabled = false
				var_288_2.a = 0
				arg_285_1.mask_.color = var_288_2
			end

			local var_288_3 = manager.ui.mainCamera.transform

			if 0.166666666666667 < arg_285_1.time_ and arg_285_1.time_ <= 0.166666666666667 + arg_288_0 then
				arg_285_1.var_.shakeOldPos = var_288_3.localPosition
			end

			local var_288_4 = 0.566666666666667

			if 0.166666666666667 <= arg_285_1.time_ and arg_285_1.time_ < 0.166666666666667 + var_288_4 then
				local var_288_5, var_288_6 = math.modf((arg_285_1.time_ - 0.166666666666667) / 0.066)

				var_288_3.localPosition = Vector3.New(var_288_6 * 0.13, var_288_6 * 0.13, var_288_6 * 0.13) + arg_285_1.var_.shakeOldPos
			end

			if arg_285_1.time_ >= 0.166666666666667 + var_288_4 and arg_285_1.time_ < 0.166666666666667 + var_288_4 + arg_288_0 then
				var_288_3.localPosition = arg_285_1.var_.shakeOldPos
			end

			if 0.166666666666667 < arg_285_1.time_ and arg_285_1.time_ <= 0.166666666666667 + arg_288_0 then
				arg_285_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_signal", "")
			end

			local var_288_8 = 0

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				arg_285_1.allBtn_.enabled = false
			end

			if arg_285_1.time_ >= var_288_8 + 0.733333333333333 and arg_285_1.time_ < var_288_8 + 0.733333333333333 + arg_288_0 then
				arg_285_1.allBtn_.enabled = true
			end

			if arg_285_1.frameCnt_ <= 1 then
				arg_285_1.dialog_:SetActive(false)
			end

			local var_288_9 = 0.566666666666667
			local var_288_10 = 0.9

			if 0.566666666666667 < arg_285_1.time_ and arg_285_1.time_ <= var_288_9 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0

				arg_285_1.dialog_:SetActive(true)

				arg_285_1.dialogCg_.alpha = 0

				local var_288_11 = LeanTween.value(arg_285_1.dialog_, 0, 1, 0.3)

				var_288_11:setOnUpdate(LuaHelper.FloatAction(function(arg_289_0)
					arg_285_1.dialogCg_.alpha = arg_289_0
				end))
				var_288_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_285_1.dialog_)
					var_288_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_285_1.duration_ = arg_285_1.duration_ + 0.3

				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_12 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(320251067).content)

				arg_285_1.text_.text = var_288_12

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_14 = 36 <= 0 and var_288_10 or var_288_10 * (utf8.len(var_288_12) / 36)

				if (36 <= 0 and var_288_10 or var_288_10 * (utf8.len(var_288_12) / 36)) > 0 and var_288_10 < var_288_14 then
					arg_285_1.talkMaxDuration = var_288_14
					var_288_9 = var_288_9 + 0.3

					if var_288_14 + var_288_9 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_9
					end
				end

				arg_285_1.text_.text = var_288_12
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_15 = var_288_9 + 0.3
			local var_288_16 = math.max(var_288_10, arg_285_1.talkMaxDuration)

			if var_288_9 + 0.3 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_16 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_15) / var_288_16

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_15 + var_288_16 and arg_285_1.time_ < var_288_15 + var_288_16 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play320251068 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 320251068
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play320251069(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 1.7

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(320251068).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 68 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 68)

				if (68 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 68)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play320251069 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 320251069
		arg_295_1.duration_ = 3.9

		local var_295_0 = {
			zh = 3.266,
			ja = 3.9
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play320251070(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.175

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4043")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:GetWordFromCfg(320251069)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 7 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 7)

				if (7 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 7)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251069", "story_v_out_320251.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251069", "story_v_out_320251.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_320251", "320251069", "story_v_out_320251.awb")

						arg_295_1:RecordAudio("320251069", var_298_6)
						arg_295_1:RecordAudio("320251069", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_320251", "320251069", "story_v_out_320251.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_320251", "320251069", "story_v_out_320251.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play320251070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 320251070
		arg_299_1.duration_ = 3.2

		local var_299_0 = {
			zh = 2.033,
			ja = 3.2
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play320251071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.25

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1066].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_1 = arg_299_1:GetWordFromCfg(320251070)
				local var_302_2 = arg_299_1:FormatText(var_302_1.content)

				arg_299_1.text_.text = var_302_2

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 10 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 10)

				if (10 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 10)) > 0 and var_302_0 < var_302_4 then
					arg_299_1.talkMaxDuration = var_302_4

					if var_302_4 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_4 + 0
					end
				end

				arg_299_1.text_.text = var_302_2
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251070", "story_v_out_320251.awb") ~= 0 then
					local var_302_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251070", "story_v_out_320251.awb") / 1000

					if var_302_5 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + 0
					end

					if var_302_1.prefab_name ~= "" and arg_299_1.actors_[var_302_1.prefab_name] ~= nil then
						local var_302_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_1.prefab_name].transform, "story_v_out_320251", "320251070", "story_v_out_320251.awb")

						arg_299_1:RecordAudio("320251070", var_302_6)
						arg_299_1:RecordAudio("320251070", var_302_6)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_320251", "320251070", "story_v_out_320251.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_320251", "320251070", "story_v_out_320251.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play320251071 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 320251071
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play320251072(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1.425

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(320251071).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 57 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 57)

				if (57 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 57)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play320251072 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 320251072
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play320251073(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 1.5

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(320251072).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 60 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 60)

				if (60 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 60)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play320251073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 320251073
		arg_311_1.duration_ = 3.43

		local var_311_0 = {
			zh = 3.433,
			ja = 1.833
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play320251074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.15

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[1066].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_1 = arg_311_1:GetWordFromCfg(320251073)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.text_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 6 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 6)

				if (6 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 6)) > 0 and var_314_0 < var_314_4 then
					arg_311_1.talkMaxDuration = var_314_4

					if var_314_4 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_4 + 0
					end
				end

				arg_311_1.text_.text = var_314_2
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251073", "story_v_out_320251.awb") ~= 0 then
					local var_314_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251073", "story_v_out_320251.awb") / 1000

					if var_314_5 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + 0
					end

					if var_314_1.prefab_name ~= "" and arg_311_1.actors_[var_314_1.prefab_name] ~= nil then
						local var_314_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_1.prefab_name].transform, "story_v_out_320251", "320251073", "story_v_out_320251.awb")

						arg_311_1:RecordAudio("320251073", var_314_6)
						arg_311_1:RecordAudio("320251073", var_314_6)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_320251", "320251073", "story_v_out_320251.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_320251", "320251073", "story_v_out_320251.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play320251074 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 320251074
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play320251075(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.925

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_1 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(320251074).content)

				arg_315_1.text_.text = var_318_1

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_3 = 37 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 37)

				if (37 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 37)) > 0 and var_318_0 < var_318_3 then
					arg_315_1.talkMaxDuration = var_318_3

					if var_318_3 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_3 + 0
					end
				end

				arg_315_1.text_.text = var_318_1
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_4 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_4

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play320251075 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 320251075
		arg_319_1.duration_ = 6

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play320251076(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0.366666666666667 < arg_319_1.time_ and arg_319_1.time_ <= 0.366666666666667 + arg_322_0 then
				arg_319_1.mask_.enabled = true
				arg_319_1.mask_.raycastTarget = true

				arg_319_1:SetGaussion(false)
			end

			local var_322_0 = 0.633333333333333

			if 0.366666666666667 <= arg_319_1.time_ and arg_319_1.time_ < 0.366666666666667 + var_322_0 then
				local var_322_1 = Color.New(1, 1, 1)

				var_322_1.a = Mathf.Lerp(1, 0, (arg_319_1.time_ - 0.366666666666667) / var_322_0)
				arg_319_1.mask_.color = var_322_1
			end

			if arg_319_1.time_ >= 0.366666666666667 + var_322_0 and arg_319_1.time_ < 0.366666666666667 + var_322_0 + arg_322_0 then
				local var_322_2 = Color.New(1, 1, 1)

				arg_319_1.mask_.enabled = false
				var_322_2.a = 0
				arg_319_1.mask_.color = var_322_2
			end

			local var_322_3 = manager.ui.mainCamera.transform

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.shakeOldPos = var_322_3.localPosition
			end

			local var_322_4 = 0.666666666666667

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				local var_322_5, var_322_6 = math.modf((arg_319_1.time_ - 0) / 0.066)

				var_322_3.localPosition = Vector3.New(var_322_6 * 0.13, var_322_6 * 0.13, var_322_6 * 0.13) + arg_319_1.var_.shakeOldPos
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				var_322_3.localPosition = arg_319_1.var_.shakeOldPos
			end

			if 0.366666666666667 < arg_319_1.time_ and arg_319_1.time_ <= 0.366666666666667 + arg_322_0 then
				if arg_319_1.var_.effect777 then
					Object.Destroy(arg_319_1.var_.effect777)

					arg_319_1.var_.effect777 = nil
				end
			end

			if 0.366666666666667 < arg_319_1.time_ and arg_319_1.time_ <= 0.366666666666667 + arg_322_0 then
				if arg_319_1.var_.effect888 then
					Object.Destroy(arg_319_1.var_.effect888)

					arg_319_1.var_.effect888 = nil
				end
			end

			if 0.2 < arg_319_1.time_ and arg_319_1.time_ <= 0.2 + arg_322_0 then
				arg_319_1:AudioAction("play", "effect", "se_story_137", "se_story_137_carbrake", "")
			end

			if arg_319_1.frameCnt_ <= 1 then
				arg_319_1.dialog_:SetActive(false)
			end

			local var_322_10 = 1
			local var_322_11 = 1.475

			if 1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_10 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0

				arg_319_1.dialog_:SetActive(true)

				arg_319_1.dialogCg_.alpha = 0

				local var_322_12 = LeanTween.value(arg_319_1.dialog_, 0, 1, 0.3)

				var_322_12:setOnUpdate(LuaHelper.FloatAction(function(arg_323_0)
					arg_319_1.dialogCg_.alpha = arg_323_0
				end))
				var_322_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_319_1.dialog_)
					var_322_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_319_1.duration_ = arg_319_1.duration_ + 0.3

				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_13 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(320251075).content)

				arg_319_1.text_.text = var_322_13

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_15 = 59 <= 0 and var_322_11 or var_322_11 * (utf8.len(var_322_13) / 59)

				if (59 <= 0 and var_322_11 or var_322_11 * (utf8.len(var_322_13) / 59)) > 0 and var_322_11 < var_322_15 then
					arg_319_1.talkMaxDuration = var_322_15
					var_322_10 = var_322_10 + 0.3

					if var_322_15 + var_322_10 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_15 + var_322_10
					end
				end

				arg_319_1.text_.text = var_322_13
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = var_322_10 + 0.3
			local var_322_17 = math.max(var_322_11, arg_319_1.talkMaxDuration)

			if var_322_10 + 0.3 <= arg_319_1.time_ and arg_319_1.time_ < var_322_16 + var_322_17 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_16) / var_322_17

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_16 + var_322_17 and arg_319_1.time_ < var_322_16 + var_322_17 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play320251076 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 320251076
		arg_325_1.duration_ = 3.07

		local var_325_0 = {
			zh = 1.066,
			ja = 3.066
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play320251077(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.175

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1035].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_1 = arg_325_1:GetWordFromCfg(320251076)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 7 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 7)

				if (7 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 7)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251076", "story_v_out_320251.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251076", "story_v_out_320251.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_out_320251", "320251076", "story_v_out_320251.awb")

						arg_325_1:RecordAudio("320251076", var_328_6)
						arg_325_1:RecordAudio("320251076", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_320251", "320251076", "story_v_out_320251.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_320251", "320251076", "story_v_out_320251.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play320251077 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 320251077
		arg_329_1.duration_ = 3.2

		local var_329_0 = {
			zh = 2.433,
			ja = 3.2
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play320251078(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if arg_329_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_332_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_329_1.stage_.transform)

				var_332_0.name = "1156ui_story"
				var_332_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.actors_["1156ui_story"] = var_332_0

				local var_332_1 = var_332_0:GetComponentInChildren(typeof(CharacterEffect))

				var_332_1.enabled = true

				local var_332_2 = GameObjectTools.GetOrAddComponent(var_332_0, typeof(DynamicBoneHelper))

				if var_332_2 then
					var_332_2:EnableDynamicBone(false)
				end

				arg_329_1:ShowWeapon(var_332_1.transform, false)

				arg_329_1.var_["1156ui_story" .. "Animator"] = var_332_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_329_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_329_1.var_["1156ui_story" .. "LipSync"] = var_332_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_332_3 = arg_329_1.actors_["1156ui_story"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1156ui_story = var_332_3.localPosition
			end

			local var_332_4 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				var_332_3.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_329_1.time_ - 0) / var_332_4)
				var_332_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_3.position).x, (manager.ui.mainCamera.transform.position - var_332_3.position).y, (manager.ui.mainCamera.transform.position - var_332_3.position).z)
				var_332_3.localEulerAngles.z = 0
				var_332_3.localEulerAngles.x = 0
				var_332_3.localEulerAngles = var_332_3.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				var_332_3.localPosition = Vector3.New(0, -1.1, -6.18)
				var_332_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_3.position).x, (manager.ui.mainCamera.transform.position - var_332_3.position).y, (manager.ui.mainCamera.transform.position - var_332_3.position).z)
				var_332_3.localEulerAngles.z = 0
				var_332_3.localEulerAngles.x = 0
				var_332_3.localEulerAngles = var_332_3.localEulerAngles
			end

			local var_332_5 = arg_329_1.actors_["1156ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_5) and arg_329_1.var_.characterEffect1156ui_story == nil then
				arg_329_1.var_.characterEffect1156ui_story = var_332_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_6 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_6 and not isNil(var_332_5) then
				if arg_329_1.var_.characterEffect1156ui_story and not isNil(var_332_5) then
					arg_329_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_6 and arg_329_1.time_ < 0 + var_332_6 + arg_332_0 and not isNil(var_332_5) and arg_329_1.var_.characterEffect1156ui_story then
				arg_329_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action3_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_332_8 = 0
			local var_332_9 = 0.325

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_10 = arg_329_1:GetWordFromCfg(320251077)
				local var_332_11 = arg_329_1:FormatText(var_332_10.content)

				arg_329_1.text_.text = var_332_11

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_13 = 13 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_11) / 13)

				if (13 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_11) / 13)) > 0 and var_332_9 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_8
					end
				end

				arg_329_1.text_.text = var_332_11
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251077", "story_v_out_320251.awb") ~= 0 then
					local var_332_14 = manager.audio:GetVoiceLength("story_v_out_320251", "320251077", "story_v_out_320251.awb") / 1000

					if var_332_14 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_14 + var_332_8
					end

					if var_332_10.prefab_name ~= "" and arg_329_1.actors_[var_332_10.prefab_name] ~= nil then
						local var_332_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_10.prefab_name].transform, "story_v_out_320251", "320251077", "story_v_out_320251.awb")

						arg_329_1:RecordAudio("320251077", var_332_15)
						arg_329_1:RecordAudio("320251077", var_332_15)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_320251", "320251077", "story_v_out_320251.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_320251", "320251077", "story_v_out_320251.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_16 = math.max(var_332_9, arg_329_1.talkMaxDuration)

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_16 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_8) / var_332_16

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_8 + var_332_16 and arg_329_1.time_ < var_332_8 + var_332_16 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play320251078 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 320251078
		arg_333_1.duration_ = 2.67

		local var_333_0 = {
			zh = 2.4,
			ja = 2.666
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play320251079(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1156ui_story = arg_333_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1156ui_story"].transform.position).z)
				arg_333_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1156ui_story"].transform.localEulerAngles = arg_333_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_333_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1156ui_story"].transform.position).z)
				arg_333_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1156ui_story"].transform.localEulerAngles = arg_333_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_336_1 = arg_333_1.actors_["1156ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1156ui_story == nil then
				arg_333_1.var_.characterEffect1156ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_2 and not isNil(var_336_1) then
				if arg_333_1.var_.characterEffect1156ui_story and not isNil(var_336_1) then
					arg_333_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_2)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_2 and arg_333_1.time_ < 0 + var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1156ui_story then
				arg_333_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_336_3 = arg_333_1.actors_["1089ui_story"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1089ui_story = var_336_3.localPosition
			end

			local var_336_4 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 then
				var_336_3.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_333_1.time_ - 0) / var_336_4)
				var_336_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_3.position).x, (manager.ui.mainCamera.transform.position - var_336_3.position).y, (manager.ui.mainCamera.transform.position - var_336_3.position).z)
				var_336_3.localEulerAngles.z = 0
				var_336_3.localEulerAngles.x = 0
				var_336_3.localEulerAngles = var_336_3.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 then
				var_336_3.localPosition = Vector3.New(0, -1.1, -6.17)
				var_336_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_3.position).x, (manager.ui.mainCamera.transform.position - var_336_3.position).y, (manager.ui.mainCamera.transform.position - var_336_3.position).z)
				var_336_3.localEulerAngles.z = 0
				var_336_3.localEulerAngles.x = 0
				var_336_3.localEulerAngles = var_336_3.localEulerAngles
			end

			local var_336_5 = arg_333_1.actors_["1089ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_5) and arg_333_1.var_.characterEffect1089ui_story == nil then
				arg_333_1.var_.characterEffect1089ui_story = var_336_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_6 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_6 and not isNil(var_336_5) then
				if arg_333_1.var_.characterEffect1089ui_story and not isNil(var_336_5) then
					arg_333_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_6 and arg_333_1.time_ < 0 + var_336_6 + arg_336_0 and not isNil(var_336_5) and arg_333_1.var_.characterEffect1089ui_story then
				arg_333_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_336_8 = 0
			local var_336_9 = 0.125

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_8 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_10 = arg_333_1:GetWordFromCfg(320251078)
				local var_336_11 = arg_333_1:FormatText(var_336_10.content)

				arg_333_1.text_.text = var_336_11

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_13 = 5 <= 0 and var_336_9 or var_336_9 * (utf8.len(var_336_11) / 5)

				if (5 <= 0 and var_336_9 or var_336_9 * (utf8.len(var_336_11) / 5)) > 0 and var_336_9 < var_336_13 then
					arg_333_1.talkMaxDuration = var_336_13

					if var_336_13 + var_336_8 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_8
					end
				end

				arg_333_1.text_.text = var_336_11
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251078", "story_v_out_320251.awb") ~= 0 then
					local var_336_14 = manager.audio:GetVoiceLength("story_v_out_320251", "320251078", "story_v_out_320251.awb") / 1000

					if var_336_14 + var_336_8 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_14 + var_336_8
					end

					if var_336_10.prefab_name ~= "" and arg_333_1.actors_[var_336_10.prefab_name] ~= nil then
						local var_336_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_10.prefab_name].transform, "story_v_out_320251", "320251078", "story_v_out_320251.awb")

						arg_333_1:RecordAudio("320251078", var_336_15)
						arg_333_1:RecordAudio("320251078", var_336_15)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_320251", "320251078", "story_v_out_320251.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_320251", "320251078", "story_v_out_320251.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_16 = math.max(var_336_9, arg_333_1.talkMaxDuration)

			if var_336_8 <= arg_333_1.time_ and arg_333_1.time_ < var_336_8 + var_336_16 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_8) / var_336_16

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_8 + var_336_16 and arg_333_1.time_ < var_336_8 + var_336_16 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play320251079 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 320251079
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play320251080(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1089ui_story = arg_337_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1089ui_story"].transform.position).z)
				arg_337_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1089ui_story"].transform.localEulerAngles = arg_337_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_337_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1089ui_story"].transform.position).z)
				arg_337_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1089ui_story"].transform.localEulerAngles = arg_337_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_340_1 = arg_337_1.actors_["1089ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1089ui_story == nil then
				arg_337_1.var_.characterEffect1089ui_story = var_340_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 and not isNil(var_340_1) then
				if arg_337_1.var_.characterEffect1089ui_story and not isNil(var_340_1) then
					arg_337_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_2)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1089ui_story then
				arg_337_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0.45 < arg_337_1.time_ and arg_337_1.time_ <= 0.45 + arg_340_0 then
				arg_337_1:AudioAction("play", "effect", "se_story_130", "se_story_130_gun", "")
			end

			local var_340_4 = 0
			local var_340_5 = 1.45

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_6 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(320251079).content)

				arg_337_1.text_.text = var_340_6

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_8 = 58 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_6) / 58)

				if (58 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_6) / 58)) > 0 and var_340_5 < var_340_8 then
					arg_337_1.talkMaxDuration = var_340_8

					if var_340_8 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_6
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_9 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_9 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_9

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_9 and arg_337_1.time_ < var_340_4 + var_340_9 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play320251080 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 320251080
		arg_341_1.duration_ = 5.8

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play320251081(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.mask_.enabled = true
				arg_341_1.mask_.raycastTarget = true

				arg_341_1:SetGaussion(false)
			end

			local var_344_0 = 0.333333333333333

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				local var_344_1 = Color.New(0.2169811, 0.04161461, 0.02354041)

				var_344_1.a = Mathf.Lerp(1, 0, (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.mask_.color = var_344_1
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				local var_344_2 = Color.New(0.2169811, 0.04161461, 0.02354041)

				arg_341_1.mask_.enabled = false
				var_344_2.a = 0
				arg_341_1.mask_.color = var_344_2
			end

			local var_344_3 = 0.333333333333333

			if 0.333333333333333 < arg_341_1.time_ and arg_341_1.time_ <= var_344_3 + arg_344_0 then
				arg_341_1.mask_.enabled = true
				arg_341_1.mask_.raycastTarget = true

				arg_341_1:SetGaussion(false)
			end

			local var_344_4 = 0.333333333333333

			if var_344_3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_3 + var_344_4 then
				local var_344_5 = Color.New(0.2169811, 0.04161461, 0.02354041)

				var_344_5.a = Mathf.Lerp(1, 0, (arg_341_1.time_ - var_344_3) / var_344_4)
				arg_341_1.mask_.color = var_344_5
			end

			if arg_341_1.time_ >= var_344_3 + var_344_4 and arg_341_1.time_ < var_344_3 + var_344_4 + arg_344_0 then
				local var_344_6 = Color.New(0.2169811, 0.04161461, 0.02354041)

				arg_341_1.mask_.enabled = false
				var_344_6.a = 0
				arg_341_1.mask_.color = var_344_6
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:AudioAction("play", "effect", "se_story_130", "se_story_130_gun", "")
			end

			if arg_341_1.frameCnt_ <= 1 then
				arg_341_1.dialog_:SetActive(false)
			end

			local var_344_8 = 0.8
			local var_344_9 = 1.4

			if 0.8 < arg_341_1.time_ and arg_341_1.time_ <= var_344_8 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0

				arg_341_1.dialog_:SetActive(true)

				arg_341_1.dialogCg_.alpha = 0

				local var_344_10 = LeanTween.value(arg_341_1.dialog_, 0, 1, 0.3)

				var_344_10:setOnUpdate(LuaHelper.FloatAction(function(arg_345_0)
					arg_341_1.dialogCg_.alpha = arg_345_0
				end))
				var_344_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_341_1.dialog_)
					var_344_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_341_1.duration_ = arg_341_1.duration_ + 0.3

				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_11 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(320251080).content)

				arg_341_1.text_.text = var_344_11

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_13 = 56 <= 0 and var_344_9 or var_344_9 * (utf8.len(var_344_11) / 56)

				if (56 <= 0 and var_344_9 or var_344_9 * (utf8.len(var_344_11) / 56)) > 0 and var_344_9 < var_344_13 then
					arg_341_1.talkMaxDuration = var_344_13
					var_344_8 = var_344_8 + 0.3

					if var_344_13 + var_344_8 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_8
					end
				end

				arg_341_1.text_.text = var_344_11
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_14 = var_344_8 + 0.3
			local var_344_15 = math.max(var_344_9, arg_341_1.talkMaxDuration)

			if var_344_8 + 0.3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_14 + var_344_15 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_14) / var_344_15

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_14 + var_344_15 and arg_341_1.time_ < var_344_14 + var_344_15 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play320251081 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 320251081
		arg_347_1.duration_ = 4.23

		local var_347_0 = {
			zh = 2.533,
			ja = 4.233
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play320251082(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.3

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_1 = arg_347_1:GetWordFromCfg(320251081)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 12 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 12)

				if (12 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 12)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251081", "story_v_out_320251.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251081", "story_v_out_320251.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_out_320251", "320251081", "story_v_out_320251.awb")

						arg_347_1:RecordAudio("320251081", var_350_6)
						arg_347_1:RecordAudio("320251081", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_320251", "320251081", "story_v_out_320251.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_320251", "320251081", "story_v_out_320251.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play320251082 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 320251082
		arg_351_1.duration_ = 4.17

		local var_351_0 = {
			zh = 2.333,
			ja = 4.166
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play320251083(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.275

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_1 = arg_351_1:GetWordFromCfg(320251082)
				local var_354_2 = arg_351_1:FormatText(var_354_1.content)

				arg_351_1.text_.text = var_354_2

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 11 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 11)

				if (11 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 11)) > 0 and var_354_0 < var_354_4 then
					arg_351_1.talkMaxDuration = var_354_4

					if var_354_4 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_4 + 0
					end
				end

				arg_351_1.text_.text = var_354_2
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251082", "story_v_out_320251.awb") ~= 0 then
					local var_354_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251082", "story_v_out_320251.awb") / 1000

					if var_354_5 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + 0
					end

					if var_354_1.prefab_name ~= "" and arg_351_1.actors_[var_354_1.prefab_name] ~= nil then
						local var_354_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_1.prefab_name].transform, "story_v_out_320251", "320251082", "story_v_out_320251.awb")

						arg_351_1:RecordAudio("320251082", var_354_6)
						arg_351_1:RecordAudio("320251082", var_354_6)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_320251", "320251082", "story_v_out_320251.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_320251", "320251082", "story_v_out_320251.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_7 and arg_351_1.time_ < 0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play320251083 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 320251083
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play320251084(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.375

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(320251083).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 55 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 55)

				if (55 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 55)) > 0 and var_358_0 < var_358_3 then
					arg_355_1.talkMaxDuration = var_358_3

					if var_358_3 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_3 + 0
					end
				end

				arg_355_1.text_.text = var_358_1
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_4 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_4

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play320251084 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 320251084
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play320251085(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0.333333333333333 < arg_359_1.time_ and arg_359_1.time_ <= 0.333333333333333 + arg_362_0 then
				arg_359_1:AudioAction("play", "effect", "se_story_16", "se_story_16_smash02", "")
			end

			local var_362_1 = 0
			local var_362_2 = 1.55

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_3 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(320251084).content)

				arg_359_1.text_.text = var_362_3

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 62 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 62)

				if (62 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 62)) > 0 and var_362_2 < var_362_5 then
					arg_359_1.talkMaxDuration = var_362_5

					if var_362_5 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + var_362_1
					end
				end

				arg_359_1.text_.text = var_362_3
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_6 = math.max(var_362_2, arg_359_1.talkMaxDuration)

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_6 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_1) / var_362_6

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_1 + var_362_6 and arg_359_1.time_ < var_362_1 + var_362_6 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play320251085 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 320251085
		arg_363_1.duration_ = 6.57

		local var_363_0 = {
			zh = 3.9,
			ja = 6.566
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play320251086(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.175

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4043")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_1 = arg_363_1:GetWordFromCfg(320251085)
				local var_366_2 = arg_363_1:FormatText(var_366_1.content)

				arg_363_1.text_.text = var_366_2

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 7 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 7)

				if (7 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 7)) > 0 and var_366_0 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end

				arg_363_1.text_.text = var_366_2
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251085", "story_v_out_320251.awb") ~= 0 then
					local var_366_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251085", "story_v_out_320251.awb") / 1000

					if var_366_5 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + 0
					end

					if var_366_1.prefab_name ~= "" and arg_363_1.actors_[var_366_1.prefab_name] ~= nil then
						local var_366_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_1.prefab_name].transform, "story_v_out_320251", "320251085", "story_v_out_320251.awb")

						arg_363_1:RecordAudio("320251085", var_366_6)
						arg_363_1:RecordAudio("320251085", var_366_6)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_320251", "320251085", "story_v_out_320251.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_320251", "320251085", "story_v_out_320251.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play320251086 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 320251086
		arg_367_1.duration_ = 6.23

		local var_367_0 = {
			zh = 4.266,
			ja = 6.233
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play320251087(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.65

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_1 = arg_367_1:GetWordFromCfg(320251086)
				local var_370_2 = arg_367_1:FormatText(var_370_1.content)

				arg_367_1.text_.text = var_370_2

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 26 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 26)

				if (26 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 26)) > 0 and var_370_0 < var_370_4 then
					arg_367_1.talkMaxDuration = var_370_4

					if var_370_4 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_4 + 0
					end
				end

				arg_367_1.text_.text = var_370_2
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251086", "story_v_out_320251.awb") ~= 0 then
					local var_370_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251086", "story_v_out_320251.awb") / 1000

					if var_370_5 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + 0
					end

					if var_370_1.prefab_name ~= "" and arg_367_1.actors_[var_370_1.prefab_name] ~= nil then
						local var_370_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_1.prefab_name].transform, "story_v_out_320251", "320251086", "story_v_out_320251.awb")

						arg_367_1:RecordAudio("320251086", var_370_6)
						arg_367_1:RecordAudio("320251086", var_370_6)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_320251", "320251086", "story_v_out_320251.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_320251", "320251086", "story_v_out_320251.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_7 and arg_367_1.time_ < 0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play320251087 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 320251087
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play320251088(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 1.4

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(320251087).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 56 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 56)

				if (56 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 56)) > 0 and var_374_0 < var_374_3 then
					arg_371_1.talkMaxDuration = var_374_3

					if var_374_3 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_3 + 0
					end
				end

				arg_371_1.text_.text = var_374_1
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_4 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_4

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play320251088 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 320251088
		arg_375_1.duration_ = 5.73

		local var_375_0 = {
			zh = 4.4,
			ja = 5.733
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play320251089(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1156ui_story = arg_375_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1156ui_story"].transform.position).z)
				arg_375_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1156ui_story"].transform.localEulerAngles = arg_375_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_375_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1156ui_story"].transform.position).z)
				arg_375_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1156ui_story"].transform.localEulerAngles = arg_375_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_378_1 = arg_375_1.actors_["1156ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1156ui_story == nil then
				arg_375_1.var_.characterEffect1156ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1156ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1156ui_story then
				arg_375_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action11_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_378_4 = 0
			local var_378_5 = 0.65

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:GetWordFromCfg(320251088)
				local var_378_7 = arg_375_1:FormatText(var_378_6.content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 26 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 26)

				if (26 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 26)) > 0 and var_378_5 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251088", "story_v_out_320251.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251088", "story_v_out_320251.awb") / 1000

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end

					if var_378_6.prefab_name ~= "" and arg_375_1.actors_[var_378_6.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_6.prefab_name].transform, "story_v_out_320251", "320251088", "story_v_out_320251.awb")

						arg_375_1:RecordAudio("320251088", var_378_11)
						arg_375_1:RecordAudio("320251088", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_320251", "320251088", "story_v_out_320251.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_320251", "320251088", "story_v_out_320251.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_4) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_4 + var_378_12 and arg_375_1.time_ < var_378_4 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play320251089 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 320251089
		arg_379_1.duration_ = 10.3

		local var_379_0 = {
			zh = 6.8,
			ja = 10.3
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play320251090(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1156ui_story = arg_379_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1156ui_story"].transform.position).z)
				arg_379_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1156ui_story"].transform.localEulerAngles = arg_379_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_379_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1156ui_story"].transform.position).z)
				arg_379_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1156ui_story"].transform.localEulerAngles = arg_379_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["1156ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1156ui_story == nil then
				arg_379_1.var_.characterEffect1156ui_story = var_382_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 and not isNil(var_382_1) then
				if arg_379_1.var_.characterEffect1156ui_story and not isNil(var_382_1) then
					arg_379_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_2)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1156ui_story then
				arg_379_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_382_3 = arg_379_1.actors_["1089ui_story"].transform

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1089ui_story = var_382_3.localPosition
			end

			local var_382_4 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_4 then
				var_382_3.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_379_1.time_ - 0) / var_382_4)
				var_382_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_3.position).x, (manager.ui.mainCamera.transform.position - var_382_3.position).y, (manager.ui.mainCamera.transform.position - var_382_3.position).z)
				var_382_3.localEulerAngles.z = 0
				var_382_3.localEulerAngles.x = 0
				var_382_3.localEulerAngles = var_382_3.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_4 and arg_379_1.time_ < 0 + var_382_4 + arg_382_0 then
				var_382_3.localPosition = Vector3.New(0, -1.1, -6.17)
				var_382_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_3.position).x, (manager.ui.mainCamera.transform.position - var_382_3.position).y, (manager.ui.mainCamera.transform.position - var_382_3.position).z)
				var_382_3.localEulerAngles.z = 0
				var_382_3.localEulerAngles.x = 0
				var_382_3.localEulerAngles = var_382_3.localEulerAngles
			end

			local var_382_5 = arg_379_1.actors_["1089ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_5) and arg_379_1.var_.characterEffect1089ui_story == nil then
				arg_379_1.var_.characterEffect1089ui_story = var_382_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_6 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_6 and not isNil(var_382_5) then
				if arg_379_1.var_.characterEffect1089ui_story and not isNil(var_382_5) then
					arg_379_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_6 and arg_379_1.time_ < 0 + var_382_6 + arg_382_0 and not isNil(var_382_5) and arg_379_1.var_.characterEffect1089ui_story then
				arg_379_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_382_8 = 0
			local var_382_9 = 0.675

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_8 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_10 = arg_379_1:GetWordFromCfg(320251089)
				local var_382_11 = arg_379_1:FormatText(var_382_10.content)

				arg_379_1.text_.text = var_382_11

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_13 = 27 <= 0 and var_382_9 or var_382_9 * (utf8.len(var_382_11) / 27)

				if (27 <= 0 and var_382_9 or var_382_9 * (utf8.len(var_382_11) / 27)) > 0 and var_382_9 < var_382_13 then
					arg_379_1.talkMaxDuration = var_382_13

					if var_382_13 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_13 + var_382_8
					end
				end

				arg_379_1.text_.text = var_382_11
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251089", "story_v_out_320251.awb") ~= 0 then
					local var_382_14 = manager.audio:GetVoiceLength("story_v_out_320251", "320251089", "story_v_out_320251.awb") / 1000

					if var_382_14 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_14 + var_382_8
					end

					if var_382_10.prefab_name ~= "" and arg_379_1.actors_[var_382_10.prefab_name] ~= nil then
						local var_382_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_10.prefab_name].transform, "story_v_out_320251", "320251089", "story_v_out_320251.awb")

						arg_379_1:RecordAudio("320251089", var_382_15)
						arg_379_1:RecordAudio("320251089", var_382_15)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_320251", "320251089", "story_v_out_320251.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_320251", "320251089", "story_v_out_320251.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_16 = math.max(var_382_9, arg_379_1.talkMaxDuration)

			if var_382_8 <= arg_379_1.time_ and arg_379_1.time_ < var_382_8 + var_382_16 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_8) / var_382_16

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_8 + var_382_16 and arg_379_1.time_ < var_382_8 + var_382_16 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play320251090 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 320251090
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play320251091(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1089ui_story = arg_383_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_386_0 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 then
				arg_383_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_383_1.time_ - 0) / var_386_0)
				arg_383_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1089ui_story"].transform.position).z)
				arg_383_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1089ui_story"].transform.localEulerAngles = arg_383_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 then
				arg_383_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_383_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1089ui_story"].transform.position).z)
				arg_383_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1089ui_story"].transform.localEulerAngles = arg_383_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_386_1 = arg_383_1.actors_["1089ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1089ui_story == nil then
				arg_383_1.var_.characterEffect1089ui_story = var_386_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_2 and not isNil(var_386_1) then
				if arg_383_1.var_.characterEffect1089ui_story and not isNil(var_386_1) then
					arg_383_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_2)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_2 and arg_383_1.time_ < 0 + var_386_2 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1089ui_story then
				arg_383_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_386_3 = 0
			local var_386_4 = 1.225

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_3 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_5 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(320251090).content)

				arg_383_1.text_.text = var_386_5

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_7 = 49 <= 0 and var_386_4 or var_386_4 * (utf8.len(var_386_5) / 49)

				if (49 <= 0 and var_386_4 or var_386_4 * (utf8.len(var_386_5) / 49)) > 0 and var_386_4 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_3 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_3
					end
				end

				arg_383_1.text_.text = var_386_5
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_8 = math.max(var_386_4, arg_383_1.talkMaxDuration)

			if var_386_3 <= arg_383_1.time_ and arg_383_1.time_ < var_386_3 + var_386_8 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_3) / var_386_8

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_3 + var_386_8 and arg_383_1.time_ < var_386_3 + var_386_8 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play320251091 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 320251091
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play320251092(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 1.175

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(320251091).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 47 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 47)

				if (47 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 47)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play320251092 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 320251092
		arg_391_1.duration_ = 3.7

		local var_391_0 = {
			zh = 2.5,
			ja = 3.7
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play320251093(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.225

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_1 = arg_391_1:GetWordFromCfg(320251092)
				local var_394_2 = arg_391_1:FormatText(var_394_1.content)

				arg_391_1.text_.text = var_394_2

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 9 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 9)

				if (9 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 9)) > 0 and var_394_0 < var_394_4 then
					arg_391_1.talkMaxDuration = var_394_4

					if var_394_4 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_4 + 0
					end
				end

				arg_391_1.text_.text = var_394_2
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251092", "story_v_out_320251.awb") ~= 0 then
					local var_394_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251092", "story_v_out_320251.awb") / 1000

					if var_394_5 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + 0
					end

					if var_394_1.prefab_name ~= "" and arg_391_1.actors_[var_394_1.prefab_name] ~= nil then
						local var_394_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_1.prefab_name].transform, "story_v_out_320251", "320251092", "story_v_out_320251.awb")

						arg_391_1:RecordAudio("320251092", var_394_6)
						arg_391_1:RecordAudio("320251092", var_394_6)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_320251", "320251092", "story_v_out_320251.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_320251", "320251092", "story_v_out_320251.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_7 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_7 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_7

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_7 and arg_391_1.time_ < 0 + var_394_7 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play320251093 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 320251093
		arg_395_1.duration_ = 5.95

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play320251094(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_9000

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.mask_.enabled = true
				arg_395_1.mask_.raycastTarget = true

				arg_395_1:SetGaussion(false)
			end

			local var_398_0 = 0.333333333333333

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				local var_398_1 = Color.New(1, 1, 1)

				var_398_1.a = Mathf.Lerp(1, 0, (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.mask_.color = var_398_1
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				local var_398_2 = Color.New(1, 1, 1)

				arg_395_1.mask_.enabled = false
				var_398_2.a = 0
				arg_395_1.mask_.color = var_398_2
			end

			if 0.166666666666667 < arg_395_1.time_ and arg_395_1.time_ <= 0.166666666666667 + arg_398_0 then
				local var_398_3 = arg_395_1.var_.effect775

				if not arg_395_1.var_.effect775 then
					var_398_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_398_3.name = "775"
					arg_395_1.var_.effect775 = var_398_3
				else
					var_398_3.transform:SetParent(var_398_9000)
				end

				var_398_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_398_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_398_5 = manager.ui.mainCamera.transform

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.shakeOldPos = var_398_5.localPosition
			end

			local var_398_6 = 0.733333333333333

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_6 then
				local var_398_7, var_398_8 = math.modf((arg_395_1.time_ - 0) / 0.066)

				var_398_5.localPosition = Vector3.New(var_398_8 * 0.13, var_398_8 * 0.13, var_398_8 * 0.13) + arg_395_1.var_.shakeOldPos
			end

			if arg_395_1.time_ >= 0 + var_398_6 and arg_395_1.time_ < 0 + var_398_6 + arg_398_0 then
				var_398_5.localPosition = arg_395_1.var_.shakeOldPos
			end

			if 0.566666666666667 < arg_395_1.time_ and arg_395_1.time_ <= 0.566666666666667 + arg_398_0 then
				arg_395_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_gun", "")
			end

			if arg_395_1.frameCnt_ <= 1 then
				arg_395_1.dialog_:SetActive(false)
			end

			local var_398_10 = 0.954727101372555
			local var_398_11 = 1.075

			if 0.954727101372555 < arg_395_1.time_ and arg_395_1.time_ <= var_398_10 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0

				arg_395_1.dialog_:SetActive(true)

				arg_395_1.dialogCg_.alpha = 0

				local var_398_12 = LeanTween.value(arg_395_1.dialog_, 0, 1, 0.3)

				var_398_12:setOnUpdate(LuaHelper.FloatAction(function(arg_399_0)
					arg_395_1.dialogCg_.alpha = arg_399_0
				end))
				var_398_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_395_1.dialog_)
					var_398_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_395_1.duration_ = arg_395_1.duration_ + 0.3

				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_13 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(320251093).content)

				arg_395_1.text_.text = var_398_13

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_15 = 43 <= 0 and var_398_11 or var_398_11 * (utf8.len(var_398_13) / 43)

				if (43 <= 0 and var_398_11 or var_398_11 * (utf8.len(var_398_13) / 43)) > 0 and var_398_11 < var_398_15 then
					arg_395_1.talkMaxDuration = var_398_15
					var_398_10 = var_398_10 + 0.3

					if var_398_15 + var_398_10 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_15 + var_398_10
					end
				end

				arg_395_1.text_.text = var_398_13
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_16 = var_398_10 + 0.3
			local var_398_17 = math.max(var_398_11, arg_395_1.talkMaxDuration)

			if var_398_10 + 0.3 <= arg_395_1.time_ and arg_395_1.time_ < var_398_16 + var_398_17 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_16) / var_398_17

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_16 + var_398_17 and arg_395_1.time_ < var_398_16 + var_398_17 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play320251094 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 320251094
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play320251095(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 1.775

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(320251094).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 71 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 71)

				if (71 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 71)) > 0 and var_404_0 < var_404_3 then
					arg_401_1.talkMaxDuration = var_404_3

					if var_404_3 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_3 + 0
					end
				end

				arg_401_1.text_.text = var_404_1
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_4 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_4 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_4

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_4 and arg_401_1.time_ < 0 + var_404_4 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play320251095 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 320251095
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play320251096(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:AudioAction("play", "effect", "se_story_1", "se_story_1_gun_load", "")
			end

			local var_408_1 = 0
			local var_408_2 = 1.3

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_3 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(320251095).content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 52 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 52)

				if (52 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 52)) > 0 and var_408_2 < var_408_5 then
					arg_405_1.talkMaxDuration = var_408_5

					if var_408_5 + var_408_1 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + var_408_1
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_6 = math.max(var_408_2, arg_405_1.talkMaxDuration)

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_6 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_1) / var_408_6

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_1 + var_408_6 and arg_405_1.time_ < var_408_1 + var_408_6 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play320251096 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 320251096
		arg_409_1.duration_ = 6.1

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play320251097(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				local var_412_0 = arg_409_1.var_.effect321

				if not arg_409_1.var_.effect321 then
					var_412_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in_ui"), manager.ui.mainCamera.transform)
					var_412_0.name = "321"
					arg_409_1.var_.effect321 = var_412_0
				else
					var_412_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_412_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_412_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_412_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_412_0, iter_412_1 in ipairs((var_412_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_412_1.transform.localScale = Vector3.New(iter_412_1.transform.localScale.x / var_412_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_412_1.transform.localScale.y / var_412_2, iter_412_1.transform.localScale.z)
				end
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				if arg_409_1.var_.effect772 then
					Object.Destroy(arg_409_1.var_.effect772)

					arg_409_1.var_.effect772 = nil
				end
			end

			local var_412_5 = 0

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_5 + arg_412_0 then
				arg_409_1.mask_.enabled = true
				arg_409_1.mask_.raycastTarget = true

				arg_409_1:SetGaussion(false)
			end

			local var_412_6 = 0.866666666666667

			if var_412_5 <= arg_409_1.time_ and arg_409_1.time_ < var_412_5 + var_412_6 then
				local var_412_7 = Color.New(1, 1, 1)

				var_412_7.a = Mathf.Lerp(1, 0, (arg_409_1.time_ - var_412_5) / var_412_6)
				arg_409_1.mask_.color = var_412_7
			end

			if arg_409_1.time_ >= var_412_5 + var_412_6 and arg_409_1.time_ < var_412_5 + var_412_6 + arg_412_0 then
				local var_412_8 = Color.New(1, 1, 1)

				arg_409_1.mask_.enabled = false
				var_412_8.a = 0
				arg_409_1.mask_.color = var_412_8
			end

			if 0.866666666666667 < arg_409_1.time_ and arg_409_1.time_ <= 0.866666666666667 + arg_412_0 then
				arg_409_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun03", "")
			end

			if arg_409_1.frameCnt_ <= 1 then
				arg_409_1.dialog_:SetActive(false)
			end

			local var_412_10 = 1.1
			local var_412_11 = 1.6

			if 1.1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0

				arg_409_1.dialog_:SetActive(true)

				arg_409_1.dialogCg_.alpha = 0

				local var_412_12 = LeanTween.value(arg_409_1.dialog_, 0, 1, 0.3)

				var_412_12:setOnUpdate(LuaHelper.FloatAction(function(arg_413_0)
					arg_409_1.dialogCg_.alpha = arg_413_0
				end))
				var_412_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_409_1.dialog_)
					var_412_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_409_1.duration_ = arg_409_1.duration_ + 0.3

				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_13 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(320251096).content)

				arg_409_1.text_.text = var_412_13

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_15 = 64 <= 0 and var_412_11 or var_412_11 * (utf8.len(var_412_13) / 64)

				if (64 <= 0 and var_412_11 or var_412_11 * (utf8.len(var_412_13) / 64)) > 0 and var_412_11 < var_412_15 then
					arg_409_1.talkMaxDuration = var_412_15
					var_412_10 = var_412_10 + 0.3

					if var_412_15 + var_412_10 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_15 + var_412_10
					end
				end

				arg_409_1.text_.text = var_412_13
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_16 = var_412_10 + 0.3
			local var_412_17 = math.max(var_412_11, arg_409_1.talkMaxDuration)

			if var_412_10 + 0.3 <= arg_409_1.time_ and arg_409_1.time_ < var_412_16 + var_412_17 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_16) / var_412_17

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_16 + var_412_17 and arg_409_1.time_ < var_412_16 + var_412_17 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play320251097 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 320251097
		arg_415_1.duration_ = 5.33

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play320251098(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 1.7 < arg_415_1.time_ and arg_415_1.time_ <= 1.7 + arg_418_0 then
				local var_418_0 = arg_415_1.bgs_.L02f

				arg_415_1.bgs_.L02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_418_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_418_1 = var_418_0:GetComponent("SpriteRenderer")

				if var_418_1 and var_418_1.sprite then
					local var_418_2 = 2 * (var_418_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_418_0.transform.localScale = Vector3.New(var_418_2 / var_418_1.sprite.bounds.size.y < var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x and var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x or var_418_2 / var_418_1.sprite.bounds.size.y, var_418_2 / var_418_1.sprite.bounds.size.y < var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x and var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x or var_418_2 / var_418_1.sprite.bounds.size.y, 0)
				end

				for iter_418_0, iter_418_1 in pairs(arg_415_1.bgs_) do
					if iter_418_0 ~= "L02f" then
						iter_418_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_418_3 = 0

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_3 + arg_418_0 then
				arg_415_1.allBtn_.enabled = false
			end

			if arg_415_1.time_ >= var_418_3 + 0.3 and arg_415_1.time_ < var_418_3 + 0.3 + arg_418_0 then
				arg_415_1.allBtn_.enabled = true
			end

			local var_418_4 = 0

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_5 = 1.7

			if var_418_4 <= arg_415_1.time_ and arg_415_1.time_ < var_418_4 + var_418_5 then
				local var_418_6 = Color.New(0, 0, 0)

				var_418_6.a = Mathf.Lerp(0, 1, (arg_415_1.time_ - var_418_4) / var_418_5)
				arg_415_1.mask_.color = var_418_6
			end

			if arg_415_1.time_ >= var_418_4 + var_418_5 and arg_415_1.time_ < var_418_4 + var_418_5 + arg_418_0 then
				local var_418_7 = Color.New(0, 0, 0)

				var_418_7.a = 1
				arg_415_1.mask_.color = var_418_7
			end

			local var_418_8 = 1.7

			if 1.7 < arg_415_1.time_ and arg_415_1.time_ <= var_418_8 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_9 = 2

			if var_418_8 <= arg_415_1.time_ and arg_415_1.time_ < var_418_8 + var_418_9 then
				local var_418_10 = Color.New(0, 0, 0)

				var_418_10.a = Mathf.Lerp(1, 0, (arg_415_1.time_ - var_418_8) / var_418_9)
				arg_415_1.mask_.color = var_418_10
			end

			if arg_415_1.time_ >= var_418_8 + var_418_9 and arg_415_1.time_ < var_418_8 + var_418_9 + arg_418_0 then
				local var_418_11 = Color.New(0, 0, 0)

				arg_415_1.mask_.enabled = false
				var_418_11.a = 0
				arg_415_1.mask_.color = var_418_11
			end

			local var_418_12 = arg_415_1.actors_["1156ui_story"].transform

			if 3.33333333333333 < arg_415_1.time_ and arg_415_1.time_ <= 3.33333333333333 + arg_418_0 then
				arg_415_1.var_.moveOldPos1156ui_story = var_418_12.localPosition
			end

			local var_418_13 = 0.001

			if 3.33333333333333 <= arg_415_1.time_ and arg_415_1.time_ < 3.33333333333333 + var_418_13 then
				var_418_12.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_415_1.time_ - 3.33333333333333) / var_418_13)
				var_418_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_12.position).x, (manager.ui.mainCamera.transform.position - var_418_12.position).y, (manager.ui.mainCamera.transform.position - var_418_12.position).z)
				var_418_12.localEulerAngles.z = 0
				var_418_12.localEulerAngles.x = 0
				var_418_12.localEulerAngles = var_418_12.localEulerAngles
			end

			if arg_415_1.time_ >= 3.33333333333333 + var_418_13 and arg_415_1.time_ < 3.33333333333333 + var_418_13 + arg_418_0 then
				var_418_12.localPosition = Vector3.New(0, -1.1, -6.18)
				var_418_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_12.position).x, (manager.ui.mainCamera.transform.position - var_418_12.position).y, (manager.ui.mainCamera.transform.position - var_418_12.position).z)
				var_418_12.localEulerAngles.z = 0
				var_418_12.localEulerAngles.x = 0
				var_418_12.localEulerAngles = var_418_12.localEulerAngles
			end

			local var_418_14 = arg_415_1.actors_["1156ui_story"]

			if 3.33333333333333 < arg_415_1.time_ and arg_415_1.time_ <= 3.33333333333333 + arg_418_0 and not isNil(var_418_14) and arg_415_1.var_.characterEffect1156ui_story == nil then
				arg_415_1.var_.characterEffect1156ui_story = var_418_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_15 = 0.200000002980232

			if 3.33333333333333 <= arg_415_1.time_ and arg_415_1.time_ < 3.33333333333333 + var_418_15 and not isNil(var_418_14) then
				if arg_415_1.var_.characterEffect1156ui_story and not isNil(var_418_14) then
					arg_415_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= 3.33333333333333 + var_418_15 and arg_415_1.time_ < 3.33333333333333 + var_418_15 + arg_418_0 and not isNil(var_418_14) and arg_415_1.var_.characterEffect1156ui_story then
				arg_415_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 3.33333333333333 < arg_415_1.time_ and arg_415_1.time_ <= 3.33333333333333 + arg_418_0 then
				arg_415_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action12_1")
			end

			if 3.33333333333333 < arg_415_1.time_ and arg_415_1.time_ <= 3.33333333333333 + arg_418_0 then
				arg_415_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if 1.7 < arg_415_1.time_ and arg_415_1.time_ <= 1.7 + arg_418_0 then
				if arg_415_1.var_.effect321 then
					Object.Destroy(arg_415_1.var_.effect321)

					arg_415_1.var_.effect321 = nil
				end
			end

			if arg_415_1.frameCnt_ <= 1 then
				arg_415_1.dialog_:SetActive(false)
			end

			local var_418_18 = 3.575
			local var_418_19 = 0.125

			if 3.575 < arg_415_1.time_ and arg_415_1.time_ <= var_418_18 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				arg_415_1.dialog_:SetActive(true)

				arg_415_1.dialogCg_.alpha = 0

				local var_418_20 = LeanTween.value(arg_415_1.dialog_, 0, 1, 0.3)

				var_418_20:setOnUpdate(LuaHelper.FloatAction(function(arg_419_0)
					arg_415_1.dialogCg_.alpha = arg_419_0
				end))
				var_418_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_415_1.dialog_)
					var_418_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_415_1.duration_ = arg_415_1.duration_ + 0.3

				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_21 = arg_415_1:GetWordFromCfg(320251097)
				local var_418_22 = arg_415_1:FormatText(var_418_21.content)

				arg_415_1.text_.text = var_418_22

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_24 = 5 <= 0 and var_418_19 or var_418_19 * (utf8.len(var_418_22) / 5)

				if (5 <= 0 and var_418_19 or var_418_19 * (utf8.len(var_418_22) / 5)) > 0 and var_418_19 < var_418_24 then
					arg_415_1.talkMaxDuration = var_418_24
					var_418_18 = var_418_18 + 0.3

					if var_418_24 + var_418_18 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_24 + var_418_18
					end
				end

				arg_415_1.text_.text = var_418_22
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251097", "story_v_out_320251.awb") ~= 0 then
					local var_418_25 = manager.audio:GetVoiceLength("story_v_out_320251", "320251097", "story_v_out_320251.awb") / 1000

					if var_418_25 + var_418_18 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_25 + var_418_18
					end

					if var_418_21.prefab_name ~= "" and arg_415_1.actors_[var_418_21.prefab_name] ~= nil then
						local var_418_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_21.prefab_name].transform, "story_v_out_320251", "320251097", "story_v_out_320251.awb")

						arg_415_1:RecordAudio("320251097", var_418_26)
						arg_415_1:RecordAudio("320251097", var_418_26)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_320251", "320251097", "story_v_out_320251.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_320251", "320251097", "story_v_out_320251.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_27 = var_418_18 + 0.3
			local var_418_28 = math.max(var_418_19, arg_415_1.talkMaxDuration)

			if var_418_18 + 0.3 <= arg_415_1.time_ and arg_415_1.time_ < var_418_27 + var_418_28 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_27) / var_418_28

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_27 + var_418_28 and arg_415_1.time_ < var_418_27 + var_418_28 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play320251098 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 320251098
		arg_421_1.duration_ = 3.7

		local var_421_0 = {
			zh = 3.7,
			ja = 3.633
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play320251099(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1156ui_story = arg_421_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_424_0 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 then
				arg_421_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_421_1.time_ - 0) / var_424_0)
				arg_421_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1156ui_story"].transform.position).z)
				arg_421_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1156ui_story"].transform.localEulerAngles = arg_421_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 then
				arg_421_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_421_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1156ui_story"].transform.position).z)
				arg_421_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1156ui_story"].transform.localEulerAngles = arg_421_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_424_1 = arg_421_1.actors_["1156ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1156ui_story == nil then
				arg_421_1.var_.characterEffect1156ui_story = var_424_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_2 and not isNil(var_424_1) then
				if arg_421_1.var_.characterEffect1156ui_story and not isNil(var_424_1) then
					arg_421_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 0) / var_424_2)
				end
			end

			if arg_421_1.time_ >= 0 + var_424_2 and arg_421_1.time_ < 0 + var_424_2 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1156ui_story then
				arg_421_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_424_3 = arg_421_1.actors_["1089ui_story"].transform

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1089ui_story = var_424_3.localPosition
			end

			local var_424_4 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_4 then
				var_424_3.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_421_1.time_ - 0) / var_424_4)
				var_424_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_3.position).x, (manager.ui.mainCamera.transform.position - var_424_3.position).y, (manager.ui.mainCamera.transform.position - var_424_3.position).z)
				var_424_3.localEulerAngles.z = 0
				var_424_3.localEulerAngles.x = 0
				var_424_3.localEulerAngles = var_424_3.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_4 and arg_421_1.time_ < 0 + var_424_4 + arg_424_0 then
				var_424_3.localPosition = Vector3.New(0, -1.1, -6.17)
				var_424_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_3.position).x, (manager.ui.mainCamera.transform.position - var_424_3.position).y, (manager.ui.mainCamera.transform.position - var_424_3.position).z)
				var_424_3.localEulerAngles.z = 0
				var_424_3.localEulerAngles.x = 0
				var_424_3.localEulerAngles = var_424_3.localEulerAngles
			end

			local var_424_5 = arg_421_1.actors_["1089ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_5) and arg_421_1.var_.characterEffect1089ui_story == nil then
				arg_421_1.var_.characterEffect1089ui_story = var_424_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_6 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_6 and not isNil(var_424_5) then
				if arg_421_1.var_.characterEffect1089ui_story and not isNil(var_424_5) then
					arg_421_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 0 + var_424_6 and arg_421_1.time_ < 0 + var_424_6 + arg_424_0 and not isNil(var_424_5) and arg_421_1.var_.characterEffect1089ui_story then
				arg_421_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_2")
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_424_8 = 0
			local var_424_9 = 0.325

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_8 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_10 = arg_421_1:GetWordFromCfg(320251098)
				local var_424_11 = arg_421_1:FormatText(var_424_10.content)

				arg_421_1.text_.text = var_424_11

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_13 = 13 <= 0 and var_424_9 or var_424_9 * (utf8.len(var_424_11) / 13)

				if (13 <= 0 and var_424_9 or var_424_9 * (utf8.len(var_424_11) / 13)) > 0 and var_424_9 < var_424_13 then
					arg_421_1.talkMaxDuration = var_424_13

					if var_424_13 + var_424_8 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_13 + var_424_8
					end
				end

				arg_421_1.text_.text = var_424_11
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251098", "story_v_out_320251.awb") ~= 0 then
					local var_424_14 = manager.audio:GetVoiceLength("story_v_out_320251", "320251098", "story_v_out_320251.awb") / 1000

					if var_424_14 + var_424_8 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_14 + var_424_8
					end

					if var_424_10.prefab_name ~= "" and arg_421_1.actors_[var_424_10.prefab_name] ~= nil then
						local var_424_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_10.prefab_name].transform, "story_v_out_320251", "320251098", "story_v_out_320251.awb")

						arg_421_1:RecordAudio("320251098", var_424_15)
						arg_421_1:RecordAudio("320251098", var_424_15)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_320251", "320251098", "story_v_out_320251.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_320251", "320251098", "story_v_out_320251.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_16 = math.max(var_424_9, arg_421_1.talkMaxDuration)

			if var_424_8 <= arg_421_1.time_ and arg_421_1.time_ < var_424_8 + var_424_16 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_8) / var_424_16

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_8 + var_424_16 and arg_421_1.time_ < var_424_8 + var_424_16 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play320251099 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 320251099
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play320251100(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos1089ui_story = arg_425_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_428_0 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 then
				arg_425_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_425_1.time_ - 0) / var_428_0)
				arg_425_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1089ui_story"].transform.position).z)
				arg_425_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1089ui_story"].transform.localEulerAngles = arg_425_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 then
				arg_425_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_425_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1089ui_story"].transform.position).z)
				arg_425_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1089ui_story"].transform.localEulerAngles = arg_425_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_428_1 = arg_425_1.actors_["1089ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1089ui_story == nil then
				arg_425_1.var_.characterEffect1089ui_story = var_428_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_2 and not isNil(var_428_1) then
				if arg_425_1.var_.characterEffect1089ui_story and not isNil(var_428_1) then
					arg_425_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_2)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_2 and arg_425_1.time_ < 0 + var_428_2 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1089ui_story then
				arg_425_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_428_3 = 0
			local var_428_4 = 0.775

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_3 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_5 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(320251099).content)

				arg_425_1.text_.text = var_428_5

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_7 = 31 <= 0 and var_428_4 or var_428_4 * (utf8.len(var_428_5) / 31)

				if (31 <= 0 and var_428_4 or var_428_4 * (utf8.len(var_428_5) / 31)) > 0 and var_428_4 < var_428_7 then
					arg_425_1.talkMaxDuration = var_428_7

					if var_428_7 + var_428_3 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_7 + var_428_3
					end
				end

				arg_425_1.text_.text = var_428_5
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_8 = math.max(var_428_4, arg_425_1.talkMaxDuration)

			if var_428_3 <= arg_425_1.time_ and arg_425_1.time_ < var_428_3 + var_428_8 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_3) / var_428_8

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_3 + var_428_8 and arg_425_1.time_ < var_428_3 + var_428_8 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play320251100 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 320251100
		arg_429_1.duration_ = 7.33

		local var_429_0 = {
			zh = 6.833,
			ja = 7.333
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play320251101(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos1156ui_story = arg_429_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_432_0 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 then
				arg_429_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1156ui_story, Vector3.New(0.9, -1.1, -6.18), (arg_429_1.time_ - 0) / var_432_0)
				arg_429_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1156ui_story"].transform.position).z)
				arg_429_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1156ui_story"].transform.localEulerAngles = arg_429_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 then
				arg_429_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0.9, -1.1, -6.18)
				arg_429_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1156ui_story"].transform.position).z)
				arg_429_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1156ui_story"].transform.localEulerAngles = arg_429_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_432_1 = arg_429_1.actors_["1156ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect1156ui_story == nil then
				arg_429_1.var_.characterEffect1156ui_story = var_432_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_2 and not isNil(var_432_1) then
				if arg_429_1.var_.characterEffect1156ui_story and not isNil(var_432_1) then
					arg_429_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_2 and arg_429_1.time_ < 0 + var_432_2 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect1156ui_story then
				arg_429_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action5_1")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_432_4 = 0
			local var_432_5 = 0.975

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_4 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_6 = arg_429_1:GetWordFromCfg(320251100)
				local var_432_7 = arg_429_1:FormatText(var_432_6.content)

				arg_429_1.text_.text = var_432_7

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_9 = 39 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 39)

				if (39 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 39)) > 0 and var_432_5 < var_432_9 then
					arg_429_1.talkMaxDuration = var_432_9

					if var_432_9 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_9 + var_432_4
					end
				end

				arg_429_1.text_.text = var_432_7
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251100", "story_v_out_320251.awb") ~= 0 then
					local var_432_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251100", "story_v_out_320251.awb") / 1000

					if var_432_10 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_10 + var_432_4
					end

					if var_432_6.prefab_name ~= "" and arg_429_1.actors_[var_432_6.prefab_name] ~= nil then
						local var_432_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_6.prefab_name].transform, "story_v_out_320251", "320251100", "story_v_out_320251.awb")

						arg_429_1:RecordAudio("320251100", var_432_11)
						arg_429_1:RecordAudio("320251100", var_432_11)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_320251", "320251100", "story_v_out_320251.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_320251", "320251100", "story_v_out_320251.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_12 = math.max(var_432_5, arg_429_1.talkMaxDuration)

			if var_432_4 <= arg_429_1.time_ and arg_429_1.time_ < var_432_4 + var_432_12 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_4) / var_432_12

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_4 + var_432_12 and arg_429_1.time_ < var_432_4 + var_432_12 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play320251101 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 320251101
		arg_433_1.duration_ = 3.63

		local var_433_0 = {
			zh = 3,
			ja = 3.633
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play320251102(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1089ui_story = arg_433_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_436_0 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 then
				arg_433_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_433_1.time_ - 0) / var_436_0)
				arg_433_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1089ui_story"].transform.position).z)
				arg_433_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1089ui_story"].transform.localEulerAngles = arg_433_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 then
				arg_433_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_433_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1089ui_story"].transform.position).z)
				arg_433_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1089ui_story"].transform.localEulerAngles = arg_433_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_436_1 = arg_433_1.actors_["1089ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1089ui_story == nil then
				arg_433_1.var_.characterEffect1089ui_story = var_436_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_2 and not isNil(var_436_1) then
				if arg_433_1.var_.characterEffect1089ui_story and not isNil(var_436_1) then
					arg_433_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_2 and arg_433_1.time_ < 0 + var_436_2 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1089ui_story then
				arg_433_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_436_4 = arg_433_1.actors_["1156ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_4) and arg_433_1.var_.characterEffect1156ui_story == nil then
				arg_433_1.var_.characterEffect1156ui_story = var_436_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_5 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_5 and not isNil(var_436_4) then
				if arg_433_1.var_.characterEffect1156ui_story and not isNil(var_436_4) then
					arg_433_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_5)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_5 and arg_433_1.time_ < 0 + var_436_5 + arg_436_0 and not isNil(var_436_4) and arg_433_1.var_.characterEffect1156ui_story then
				arg_433_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_436_6 = 0
			local var_436_7 = 0.325

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_6 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_8 = arg_433_1:GetWordFromCfg(320251101)
				local var_436_9 = arg_433_1:FormatText(var_436_8.content)

				arg_433_1.text_.text = var_436_9

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_11 = 13 <= 0 and var_436_7 or var_436_7 * (utf8.len(var_436_9) / 13)

				if (13 <= 0 and var_436_7 or var_436_7 * (utf8.len(var_436_9) / 13)) > 0 and var_436_7 < var_436_11 then
					arg_433_1.talkMaxDuration = var_436_11

					if var_436_11 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_11 + var_436_6
					end
				end

				arg_433_1.text_.text = var_436_9
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251101", "story_v_out_320251.awb") ~= 0 then
					local var_436_12 = manager.audio:GetVoiceLength("story_v_out_320251", "320251101", "story_v_out_320251.awb") / 1000

					if var_436_12 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_12 + var_436_6
					end

					if var_436_8.prefab_name ~= "" and arg_433_1.actors_[var_436_8.prefab_name] ~= nil then
						local var_436_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_8.prefab_name].transform, "story_v_out_320251", "320251101", "story_v_out_320251.awb")

						arg_433_1:RecordAudio("320251101", var_436_13)
						arg_433_1:RecordAudio("320251101", var_436_13)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_320251", "320251101", "story_v_out_320251.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_320251", "320251101", "story_v_out_320251.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_14 = math.max(var_436_7, arg_433_1.talkMaxDuration)

			if var_436_6 <= arg_433_1.time_ and arg_433_1.time_ < var_436_6 + var_436_14 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_6) / var_436_14

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_6 + var_436_14 and arg_433_1.time_ < var_436_6 + var_436_14 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play320251102 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 320251102
		arg_437_1.duration_ = 4.47

		local var_437_0 = {
			zh = 4.466,
			ja = 4.066
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play320251103(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1089ui_story"]) and arg_437_1.var_.characterEffect1089ui_story == nil then
				arg_437_1.var_.characterEffect1089ui_story = arg_437_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1089ui_story"]) then
				if arg_437_1.var_.characterEffect1089ui_story and not isNil(arg_437_1.actors_["1089ui_story"]) then
					arg_437_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_0)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1089ui_story"]) and arg_437_1.var_.characterEffect1089ui_story then
				arg_437_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_440_1 = arg_437_1.actors_["1156ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1156ui_story == nil then
				arg_437_1.var_.characterEffect1156ui_story = var_440_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 and not isNil(var_440_1) then
				if arg_437_1.var_.characterEffect1156ui_story and not isNil(var_440_1) then
					arg_437_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1156ui_story then
				arg_437_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action5_2")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_440_4 = 0
			local var_440_5 = 0.55

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_4 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_6 = arg_437_1:GetWordFromCfg(320251102)
				local var_440_7 = arg_437_1:FormatText(var_440_6.content)

				arg_437_1.text_.text = var_440_7

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_9 = 22 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 22)

				if (22 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 22)) > 0 and var_440_5 < var_440_9 then
					arg_437_1.talkMaxDuration = var_440_9

					if var_440_9 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_9 + var_440_4
					end
				end

				arg_437_1.text_.text = var_440_7
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251102", "story_v_out_320251.awb") ~= 0 then
					local var_440_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251102", "story_v_out_320251.awb") / 1000

					if var_440_10 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_10 + var_440_4
					end

					if var_440_6.prefab_name ~= "" and arg_437_1.actors_[var_440_6.prefab_name] ~= nil then
						local var_440_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_6.prefab_name].transform, "story_v_out_320251", "320251102", "story_v_out_320251.awb")

						arg_437_1:RecordAudio("320251102", var_440_11)
						arg_437_1:RecordAudio("320251102", var_440_11)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_320251", "320251102", "story_v_out_320251.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_320251", "320251102", "story_v_out_320251.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_12 = math.max(var_440_5, arg_437_1.talkMaxDuration)

			if var_440_4 <= arg_437_1.time_ and arg_437_1.time_ < var_440_4 + var_440_12 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_4) / var_440_12

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_4 + var_440_12 and arg_437_1.time_ < var_440_4 + var_440_12 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play320251103 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 320251103
		arg_441_1.duration_ = 14

		local var_441_0 = {
			zh = 9.066,
			ja = 14
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play320251104(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["1089ui_story"]) and arg_441_1.var_.characterEffect1089ui_story == nil then
				arg_441_1.var_.characterEffect1089ui_story = arg_441_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_0 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["1089ui_story"]) then
				if arg_441_1.var_.characterEffect1089ui_story and not isNil(arg_441_1.actors_["1089ui_story"]) then
					arg_441_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["1089ui_story"]) and arg_441_1.var_.characterEffect1089ui_story then
				arg_441_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action4_1")
			end

			local var_444_2 = arg_441_1.actors_["1156ui_story"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_2) and arg_441_1.var_.characterEffect1156ui_story == nil then
				arg_441_1.var_.characterEffect1156ui_story = var_444_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_3 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_3 and not isNil(var_444_2) then
				if arg_441_1.var_.characterEffect1156ui_story and not isNil(var_444_2) then
					arg_441_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_441_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_441_1.time_ - 0) / var_444_3)
				end
			end

			if arg_441_1.time_ >= 0 + var_444_3 and arg_441_1.time_ < 0 + var_444_3 + arg_444_0 and not isNil(var_444_2) and arg_441_1.var_.characterEffect1156ui_story then
				arg_441_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_441_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_444_4 = 0
			local var_444_5 = 1.125

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_4 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_6 = arg_441_1:GetWordFromCfg(320251103)
				local var_444_7 = arg_441_1:FormatText(var_444_6.content)

				arg_441_1.text_.text = var_444_7

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_9 = 45 <= 0 and var_444_5 or var_444_5 * (utf8.len(var_444_7) / 45)

				if (45 <= 0 and var_444_5 or var_444_5 * (utf8.len(var_444_7) / 45)) > 0 and var_444_5 < var_444_9 then
					arg_441_1.talkMaxDuration = var_444_9

					if var_444_9 + var_444_4 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_9 + var_444_4
					end
				end

				arg_441_1.text_.text = var_444_7
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251103", "story_v_out_320251.awb") ~= 0 then
					local var_444_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251103", "story_v_out_320251.awb") / 1000

					if var_444_10 + var_444_4 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_10 + var_444_4
					end

					if var_444_6.prefab_name ~= "" and arg_441_1.actors_[var_444_6.prefab_name] ~= nil then
						local var_444_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_6.prefab_name].transform, "story_v_out_320251", "320251103", "story_v_out_320251.awb")

						arg_441_1:RecordAudio("320251103", var_444_11)
						arg_441_1:RecordAudio("320251103", var_444_11)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_320251", "320251103", "story_v_out_320251.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_320251", "320251103", "story_v_out_320251.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_12 = math.max(var_444_5, arg_441_1.talkMaxDuration)

			if var_444_4 <= arg_441_1.time_ and arg_441_1.time_ < var_444_4 + var_444_12 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_4) / var_444_12

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_4 + var_444_12 and arg_441_1.time_ < var_444_4 + var_444_12 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play320251104 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 320251104
		arg_445_1.duration_ = 14.1

		local var_445_0 = {
			zh = 11.133,
			ja = 14.1
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play320251105(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 1.5

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_1 = arg_445_1:GetWordFromCfg(320251104)
				local var_448_2 = arg_445_1:FormatText(var_448_1.content)

				arg_445_1.text_.text = var_448_2

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_4 = 60 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 60)

				if (60 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 60)) > 0 and var_448_0 < var_448_4 then
					arg_445_1.talkMaxDuration = var_448_4

					if var_448_4 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_4 + 0
					end
				end

				arg_445_1.text_.text = var_448_2
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251104", "story_v_out_320251.awb") ~= 0 then
					local var_448_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251104", "story_v_out_320251.awb") / 1000

					if var_448_5 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + 0
					end

					if var_448_1.prefab_name ~= "" and arg_445_1.actors_[var_448_1.prefab_name] ~= nil then
						local var_448_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_1.prefab_name].transform, "story_v_out_320251", "320251104", "story_v_out_320251.awb")

						arg_445_1:RecordAudio("320251104", var_448_6)
						arg_445_1:RecordAudio("320251104", var_448_6)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_320251", "320251104", "story_v_out_320251.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_320251", "320251104", "story_v_out_320251.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_7 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_7 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_7

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_7 and arg_445_1.time_ < 0 + var_448_7 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play320251105 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 320251105
		arg_449_1.duration_ = 14.43

		local var_449_0 = {
			zh = 7.966,
			ja = 14.433
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play320251106(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 1.1

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_1 = arg_449_1:GetWordFromCfg(320251105)
				local var_452_2 = arg_449_1:FormatText(var_452_1.content)

				arg_449_1.text_.text = var_452_2

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_4 = 44 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 44)

				if (44 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 44)) > 0 and var_452_0 < var_452_4 then
					arg_449_1.talkMaxDuration = var_452_4

					if var_452_4 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_4 + 0
					end
				end

				arg_449_1.text_.text = var_452_2
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251105", "story_v_out_320251.awb") ~= 0 then
					local var_452_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251105", "story_v_out_320251.awb") / 1000

					if var_452_5 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + 0
					end

					if var_452_1.prefab_name ~= "" and arg_449_1.actors_[var_452_1.prefab_name] ~= nil then
						local var_452_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_1.prefab_name].transform, "story_v_out_320251", "320251105", "story_v_out_320251.awb")

						arg_449_1:RecordAudio("320251105", var_452_6)
						arg_449_1:RecordAudio("320251105", var_452_6)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_320251", "320251105", "story_v_out_320251.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_320251", "320251105", "story_v_out_320251.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_7 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_7 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_7

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_7 and arg_449_1.time_ < 0 + var_452_7 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play320251106 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 320251106
		arg_453_1.duration_ = 12.67

		local var_453_0 = {
			zh = 12.666,
			ja = 8.733
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play320251107(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action4_2")
			end

			local var_456_0 = 0
			local var_456_1 = 1.375

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_2 = arg_453_1:GetWordFromCfg(320251106)
				local var_456_3 = arg_453_1:FormatText(var_456_2.content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 55 <= 0 and var_456_1 or var_456_1 * (utf8.len(var_456_3) / 55)

				if (55 <= 0 and var_456_1 or var_456_1 * (utf8.len(var_456_3) / 55)) > 0 and var_456_1 < var_456_5 then
					arg_453_1.talkMaxDuration = var_456_5

					if var_456_5 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251106", "story_v_out_320251.awb") ~= 0 then
					local var_456_6 = manager.audio:GetVoiceLength("story_v_out_320251", "320251106", "story_v_out_320251.awb") / 1000

					if var_456_6 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_6 + var_456_0
					end

					if var_456_2.prefab_name ~= "" and arg_453_1.actors_[var_456_2.prefab_name] ~= nil then
						local var_456_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_2.prefab_name].transform, "story_v_out_320251", "320251106", "story_v_out_320251.awb")

						arg_453_1:RecordAudio("320251106", var_456_7)
						arg_453_1:RecordAudio("320251106", var_456_7)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_320251", "320251106", "story_v_out_320251.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_320251", "320251106", "story_v_out_320251.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_8 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_8 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_8

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_8 and arg_453_1.time_ < var_456_0 + var_456_8 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play320251107 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 320251107
		arg_457_1.duration_ = 13.23

		local var_457_0 = {
			zh = 13.233,
			ja = 11.466
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play320251108(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 1.45

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:GetWordFromCfg(320251107)
				local var_460_2 = arg_457_1:FormatText(var_460_1.content)

				arg_457_1.text_.text = var_460_2

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 58 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 58)

				if (58 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 58)) > 0 and var_460_0 < var_460_4 then
					arg_457_1.talkMaxDuration = var_460_4

					if var_460_4 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_4 + 0
					end
				end

				arg_457_1.text_.text = var_460_2
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251107", "story_v_out_320251.awb") ~= 0 then
					local var_460_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251107", "story_v_out_320251.awb") / 1000

					if var_460_5 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + 0
					end

					if var_460_1.prefab_name ~= "" and arg_457_1.actors_[var_460_1.prefab_name] ~= nil then
						local var_460_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_1.prefab_name].transform, "story_v_out_320251", "320251107", "story_v_out_320251.awb")

						arg_457_1:RecordAudio("320251107", var_460_6)
						arg_457_1:RecordAudio("320251107", var_460_6)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_320251", "320251107", "story_v_out_320251.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_320251", "320251107", "story_v_out_320251.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_7 and arg_457_1.time_ < 0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play320251108 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 320251108
		arg_461_1.duration_ = 10.83

		local var_461_0 = {
			zh = 4.166,
			ja = 10.833
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play320251109(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_464_0 = 0
			local var_464_1 = 0.55

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_2 = arg_461_1:GetWordFromCfg(320251108)
				local var_464_3 = arg_461_1:FormatText(var_464_2.content)

				arg_461_1.text_.text = var_464_3

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 22 <= 0 and var_464_1 or var_464_1 * (utf8.len(var_464_3) / 22)

				if (22 <= 0 and var_464_1 or var_464_1 * (utf8.len(var_464_3) / 22)) > 0 and var_464_1 < var_464_5 then
					arg_461_1.talkMaxDuration = var_464_5

					if var_464_5 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_3
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251108", "story_v_out_320251.awb") ~= 0 then
					local var_464_6 = manager.audio:GetVoiceLength("story_v_out_320251", "320251108", "story_v_out_320251.awb") / 1000

					if var_464_6 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_6 + var_464_0
					end

					if var_464_2.prefab_name ~= "" and arg_461_1.actors_[var_464_2.prefab_name] ~= nil then
						local var_464_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_2.prefab_name].transform, "story_v_out_320251", "320251108", "story_v_out_320251.awb")

						arg_461_1:RecordAudio("320251108", var_464_7)
						arg_461_1:RecordAudio("320251108", var_464_7)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_320251", "320251108", "story_v_out_320251.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_320251", "320251108", "story_v_out_320251.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_8 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_8 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_8

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_8 and arg_461_1.time_ < var_464_0 + var_464_8 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play320251109 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 320251109
		arg_465_1.duration_ = 13.17

		local var_465_0 = {
			zh = 10.5,
			ja = 13.166
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play320251110(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 1.2

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_1 = arg_465_1:GetWordFromCfg(320251109)
				local var_468_2 = arg_465_1:FormatText(var_468_1.content)

				arg_465_1.text_.text = var_468_2

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_4 = 48 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 48)

				if (48 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 48)) > 0 and var_468_0 < var_468_4 then
					arg_465_1.talkMaxDuration = var_468_4

					if var_468_4 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_4 + 0
					end
				end

				arg_465_1.text_.text = var_468_2
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251109", "story_v_out_320251.awb") ~= 0 then
					local var_468_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251109", "story_v_out_320251.awb") / 1000

					if var_468_5 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + 0
					end

					if var_468_1.prefab_name ~= "" and arg_465_1.actors_[var_468_1.prefab_name] ~= nil then
						local var_468_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_1.prefab_name].transform, "story_v_out_320251", "320251109", "story_v_out_320251.awb")

						arg_465_1:RecordAudio("320251109", var_468_6)
						arg_465_1:RecordAudio("320251109", var_468_6)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_320251", "320251109", "story_v_out_320251.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_320251", "320251109", "story_v_out_320251.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_7 and arg_465_1.time_ < 0 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play320251110 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 320251110
		arg_469_1.duration_ = 4.59

		local var_469_0 = {
			zh = 3.125,
			ja = 4.591
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play320251111(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["1156ui_story"]) and arg_469_1.var_.characterEffect1156ui_story == nil then
				arg_469_1.var_.characterEffect1156ui_story = arg_469_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["1156ui_story"]) then
				if arg_469_1.var_.characterEffect1156ui_story and not isNil(arg_469_1.actors_["1156ui_story"]) then
					arg_469_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["1156ui_story"]) and arg_469_1.var_.characterEffect1156ui_story then
				arg_469_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_1")
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_472_2 = arg_469_1.actors_["1089ui_story"]

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(var_472_2) and arg_469_1.var_.characterEffect1089ui_story == nil then
				arg_469_1.var_.characterEffect1089ui_story = var_472_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_3 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_3 and not isNil(var_472_2) then
				if arg_469_1.var_.characterEffect1089ui_story and not isNil(var_472_2) then
					arg_469_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_3)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_3 and arg_469_1.time_ < 0 + var_472_3 + arg_472_0 and not isNil(var_472_2) and arg_469_1.var_.characterEffect1089ui_story then
				arg_469_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if arg_469_1.frameCnt_ <= 1 then
				arg_469_1.dialog_:SetActive(false)
			end

			local var_472_4 = 0.725
			local var_472_5 = 0.275

			if 0.725 < arg_469_1.time_ and arg_469_1.time_ <= var_472_4 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0

				arg_469_1.dialog_:SetActive(true)

				arg_469_1.dialogCg_.alpha = 0

				local var_472_6 = LeanTween.value(arg_469_1.dialog_, 0, 1, 0.3)

				var_472_6:setOnUpdate(LuaHelper.FloatAction(function(arg_473_0)
					arg_469_1.dialogCg_.alpha = arg_473_0
				end))
				var_472_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_469_1.dialog_)
					var_472_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_469_1.duration_ = arg_469_1.duration_ + 0.3

				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_7 = arg_469_1:GetWordFromCfg(320251110)
				local var_472_8 = arg_469_1:FormatText(var_472_7.content)

				arg_469_1.text_.text = var_472_8

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_10 = 11 <= 0 and var_472_5 or var_472_5 * (utf8.len(var_472_8) / 11)

				if (11 <= 0 and var_472_5 or var_472_5 * (utf8.len(var_472_8) / 11)) > 0 and var_472_5 < var_472_10 then
					arg_469_1.talkMaxDuration = var_472_10
					var_472_4 = var_472_4 + 0.3

					if var_472_10 + var_472_4 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_10 + var_472_4
					end
				end

				arg_469_1.text_.text = var_472_8
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251110", "story_v_out_320251.awb") ~= 0 then
					local var_472_11 = manager.audio:GetVoiceLength("story_v_out_320251", "320251110", "story_v_out_320251.awb") / 1000

					if var_472_11 + var_472_4 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_11 + var_472_4
					end

					if var_472_7.prefab_name ~= "" and arg_469_1.actors_[var_472_7.prefab_name] ~= nil then
						local var_472_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_7.prefab_name].transform, "story_v_out_320251", "320251110", "story_v_out_320251.awb")

						arg_469_1:RecordAudio("320251110", var_472_12)
						arg_469_1:RecordAudio("320251110", var_472_12)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_320251", "320251110", "story_v_out_320251.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_320251", "320251110", "story_v_out_320251.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_13 = var_472_4 + 0.3
			local var_472_14 = math.max(var_472_5, arg_469_1.talkMaxDuration)

			if var_472_4 + 0.3 <= arg_469_1.time_ and arg_469_1.time_ < var_472_13 + var_472_14 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_13) / var_472_14

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_13 + var_472_14 and arg_469_1.time_ < var_472_13 + var_472_14 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play320251111 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 320251111
		arg_475_1.duration_ = 7.73

		local var_475_0 = {
			zh = 7.266,
			ja = 7.733
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play320251112(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0.9

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_1 = arg_475_1:GetWordFromCfg(320251111)
				local var_478_2 = arg_475_1:FormatText(var_478_1.content)

				arg_475_1.text_.text = var_478_2

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_4 = 36 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_2) / 36)

				if (36 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_2) / 36)) > 0 and var_478_0 < var_478_4 then
					arg_475_1.talkMaxDuration = var_478_4

					if var_478_4 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_4 + 0
					end
				end

				arg_475_1.text_.text = var_478_2
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251111", "story_v_out_320251.awb") ~= 0 then
					local var_478_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251111", "story_v_out_320251.awb") / 1000

					if var_478_5 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_5 + 0
					end

					if var_478_1.prefab_name ~= "" and arg_475_1.actors_[var_478_1.prefab_name] ~= nil then
						local var_478_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_1.prefab_name].transform, "story_v_out_320251", "320251111", "story_v_out_320251.awb")

						arg_475_1:RecordAudio("320251111", var_478_6)
						arg_475_1:RecordAudio("320251111", var_478_6)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_320251", "320251111", "story_v_out_320251.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_320251", "320251111", "story_v_out_320251.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_7 = math.max(var_478_0, arg_475_1.talkMaxDuration)

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_7 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - 0) / var_478_7

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= 0 + var_478_7 and arg_475_1.time_ < 0 + var_478_7 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play320251112 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 320251112
		arg_479_1.duration_ = 9.6

		local var_479_0 = {
			zh = 7.333,
			ja = 9.6
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play320251113(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(arg_479_1.actors_["1089ui_story"]) and arg_479_1.var_.characterEffect1089ui_story == nil then
				arg_479_1.var_.characterEffect1089ui_story = arg_479_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_0 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 and not isNil(arg_479_1.actors_["1089ui_story"]) then
				if arg_479_1.var_.characterEffect1089ui_story and not isNil(arg_479_1.actors_["1089ui_story"]) then
					arg_479_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 and not isNil(arg_479_1.actors_["1089ui_story"]) and arg_479_1.var_.characterEffect1089ui_story then
				arg_479_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_482_2 = arg_479_1.actors_["1156ui_story"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_2) and arg_479_1.var_.characterEffect1156ui_story == nil then
				arg_479_1.var_.characterEffect1156ui_story = var_482_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_3 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_3 and not isNil(var_482_2) then
				if arg_479_1.var_.characterEffect1156ui_story and not isNil(var_482_2) then
					arg_479_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_479_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_479_1.time_ - 0) / var_482_3)
				end
			end

			if arg_479_1.time_ >= 0 + var_482_3 and arg_479_1.time_ < 0 + var_482_3 + arg_482_0 and not isNil(var_482_2) and arg_479_1.var_.characterEffect1156ui_story then
				arg_479_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_479_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_482_4 = 0
			local var_482_5 = 0.85

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_4 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_6 = arg_479_1:GetWordFromCfg(320251112)
				local var_482_7 = arg_479_1:FormatText(var_482_6.content)

				arg_479_1.text_.text = var_482_7

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_9 = 34 <= 0 and var_482_5 or var_482_5 * (utf8.len(var_482_7) / 34)

				if (34 <= 0 and var_482_5 or var_482_5 * (utf8.len(var_482_7) / 34)) > 0 and var_482_5 < var_482_9 then
					arg_479_1.talkMaxDuration = var_482_9

					if var_482_9 + var_482_4 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_9 + var_482_4
					end
				end

				arg_479_1.text_.text = var_482_7
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251112", "story_v_out_320251.awb") ~= 0 then
					local var_482_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251112", "story_v_out_320251.awb") / 1000

					if var_482_10 + var_482_4 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_10 + var_482_4
					end

					if var_482_6.prefab_name ~= "" and arg_479_1.actors_[var_482_6.prefab_name] ~= nil then
						local var_482_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_6.prefab_name].transform, "story_v_out_320251", "320251112", "story_v_out_320251.awb")

						arg_479_1:RecordAudio("320251112", var_482_11)
						arg_479_1:RecordAudio("320251112", var_482_11)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_320251", "320251112", "story_v_out_320251.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_320251", "320251112", "story_v_out_320251.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_12 = math.max(var_482_5, arg_479_1.talkMaxDuration)

			if var_482_4 <= arg_479_1.time_ and arg_479_1.time_ < var_482_4 + var_482_12 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_4) / var_482_12

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_4 + var_482_12 and arg_479_1.time_ < var_482_4 + var_482_12 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play320251113 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 320251113
		arg_483_1.duration_ = 6.23

		local var_483_0 = {
			zh = 2.033,
			ja = 6.233
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play320251114(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(arg_483_1.actors_["1156ui_story"]) and arg_483_1.var_.characterEffect1156ui_story == nil then
				arg_483_1.var_.characterEffect1156ui_story = arg_483_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_0 = 0.200000002980232

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 and not isNil(arg_483_1.actors_["1156ui_story"]) then
				if arg_483_1.var_.characterEffect1156ui_story and not isNil(arg_483_1.actors_["1156ui_story"]) then
					arg_483_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 and not isNil(arg_483_1.actors_["1156ui_story"]) and arg_483_1.var_.characterEffect1156ui_story then
				arg_483_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_2")
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_486_2 = arg_483_1.actors_["1089ui_story"]

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(var_486_2) and arg_483_1.var_.characterEffect1089ui_story == nil then
				arg_483_1.var_.characterEffect1089ui_story = var_486_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_3 = 0.200000002980232

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_3 and not isNil(var_486_2) then
				if arg_483_1.var_.characterEffect1089ui_story and not isNil(var_486_2) then
					arg_483_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_483_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_483_1.time_ - 0) / var_486_3)
				end
			end

			if arg_483_1.time_ >= 0 + var_486_3 and arg_483_1.time_ < 0 + var_486_3 + arg_486_0 and not isNil(var_486_2) and arg_483_1.var_.characterEffect1089ui_story then
				arg_483_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_483_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_486_4 = 0
			local var_486_5 = 0.325

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_4 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_6 = arg_483_1:GetWordFromCfg(320251113)
				local var_486_7 = arg_483_1:FormatText(var_486_6.content)

				arg_483_1.text_.text = var_486_7

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_9 = 13 <= 0 and var_486_5 or var_486_5 * (utf8.len(var_486_7) / 13)

				if (13 <= 0 and var_486_5 or var_486_5 * (utf8.len(var_486_7) / 13)) > 0 and var_486_5 < var_486_9 then
					arg_483_1.talkMaxDuration = var_486_9

					if var_486_9 + var_486_4 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_9 + var_486_4
					end
				end

				arg_483_1.text_.text = var_486_7
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251113", "story_v_out_320251.awb") ~= 0 then
					local var_486_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251113", "story_v_out_320251.awb") / 1000

					if var_486_10 + var_486_4 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_10 + var_486_4
					end

					if var_486_6.prefab_name ~= "" and arg_483_1.actors_[var_486_6.prefab_name] ~= nil then
						local var_486_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_6.prefab_name].transform, "story_v_out_320251", "320251113", "story_v_out_320251.awb")

						arg_483_1:RecordAudio("320251113", var_486_11)
						arg_483_1:RecordAudio("320251113", var_486_11)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_320251", "320251113", "story_v_out_320251.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_320251", "320251113", "story_v_out_320251.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_12 = math.max(var_486_5, arg_483_1.talkMaxDuration)

			if var_486_4 <= arg_483_1.time_ and arg_483_1.time_ < var_486_4 + var_486_12 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_4) / var_486_12

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_4 + var_486_12 and arg_483_1.time_ < var_486_4 + var_486_12 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play320251114 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 320251114
		arg_487_1.duration_ = 7.1

		local var_487_0 = {
			zh = 7.1,
			ja = 6.733
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play320251115(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(arg_487_1.actors_["1156ui_story"]) and arg_487_1.var_.characterEffect1156ui_story == nil then
				arg_487_1.var_.characterEffect1156ui_story = arg_487_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_0 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 and not isNil(arg_487_1.actors_["1156ui_story"]) then
				if arg_487_1.var_.characterEffect1156ui_story and not isNil(arg_487_1.actors_["1156ui_story"]) then
					arg_487_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_487_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_487_1.time_ - 0) / var_490_0)
				end
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 and not isNil(arg_487_1.actors_["1156ui_story"]) and arg_487_1.var_.characterEffect1156ui_story then
				arg_487_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_487_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_490_1 = arg_487_1.actors_["1089ui_story"]

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(var_490_1) and arg_487_1.var_.characterEffect1089ui_story == nil then
				arg_487_1.var_.characterEffect1089ui_story = var_490_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_2 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_2 and not isNil(var_490_1) then
				if arg_487_1.var_.characterEffect1089ui_story and not isNil(var_490_1) then
					arg_487_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= 0 + var_490_2 and arg_487_1.time_ < 0 + var_490_2 + arg_490_0 and not isNil(var_490_1) and arg_487_1.var_.characterEffect1089ui_story then
				arg_487_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_490_4 = 0
			local var_490_5 = 0.525

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_4 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_6 = arg_487_1:GetWordFromCfg(320251114)
				local var_490_7 = arg_487_1:FormatText(var_490_6.content)

				arg_487_1.text_.text = var_490_7

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_9 = 21 <= 0 and var_490_5 or var_490_5 * (utf8.len(var_490_7) / 21)

				if (21 <= 0 and var_490_5 or var_490_5 * (utf8.len(var_490_7) / 21)) > 0 and var_490_5 < var_490_9 then
					arg_487_1.talkMaxDuration = var_490_9

					if var_490_9 + var_490_4 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_9 + var_490_4
					end
				end

				arg_487_1.text_.text = var_490_7
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251114", "story_v_out_320251.awb") ~= 0 then
					local var_490_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251114", "story_v_out_320251.awb") / 1000

					if var_490_10 + var_490_4 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_10 + var_490_4
					end

					if var_490_6.prefab_name ~= "" and arg_487_1.actors_[var_490_6.prefab_name] ~= nil then
						local var_490_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_6.prefab_name].transform, "story_v_out_320251", "320251114", "story_v_out_320251.awb")

						arg_487_1:RecordAudio("320251114", var_490_11)
						arg_487_1:RecordAudio("320251114", var_490_11)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_320251", "320251114", "story_v_out_320251.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_320251", "320251114", "story_v_out_320251.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_12 = math.max(var_490_5, arg_487_1.talkMaxDuration)

			if var_490_4 <= arg_487_1.time_ and arg_487_1.time_ < var_490_4 + var_490_12 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_4) / var_490_12

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_4 + var_490_12 and arg_487_1.time_ < var_490_4 + var_490_12 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play320251115 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 320251115
		arg_491_1.duration_ = 15

		local var_491_0 = {
			zh = 14.4,
			ja = 15
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play320251116(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_2")
			end

			local var_494_0 = 0
			local var_494_1 = 1.65

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_2 = arg_491_1:GetWordFromCfg(320251115)
				local var_494_3 = arg_491_1:FormatText(var_494_2.content)

				arg_491_1.text_.text = var_494_3

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_5 = 66 <= 0 and var_494_1 or var_494_1 * (utf8.len(var_494_3) / 66)

				if (66 <= 0 and var_494_1 or var_494_1 * (utf8.len(var_494_3) / 66)) > 0 and var_494_1 < var_494_5 then
					arg_491_1.talkMaxDuration = var_494_5

					if var_494_5 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_5 + var_494_0
					end
				end

				arg_491_1.text_.text = var_494_3
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251115", "story_v_out_320251.awb") ~= 0 then
					local var_494_6 = manager.audio:GetVoiceLength("story_v_out_320251", "320251115", "story_v_out_320251.awb") / 1000

					if var_494_6 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_6 + var_494_0
					end

					if var_494_2.prefab_name ~= "" and arg_491_1.actors_[var_494_2.prefab_name] ~= nil then
						local var_494_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_2.prefab_name].transform, "story_v_out_320251", "320251115", "story_v_out_320251.awb")

						arg_491_1:RecordAudio("320251115", var_494_7)
						arg_491_1:RecordAudio("320251115", var_494_7)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_320251", "320251115", "story_v_out_320251.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_320251", "320251115", "story_v_out_320251.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_8 = math.max(var_494_1, arg_491_1.talkMaxDuration)

			if var_494_0 <= arg_491_1.time_ and arg_491_1.time_ < var_494_0 + var_494_8 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_0) / var_494_8

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_0 + var_494_8 and arg_491_1.time_ < var_494_0 + var_494_8 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play320251116 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 320251116
		arg_495_1.duration_ = 13.73

		local var_495_0 = {
			zh = 13.6,
			ja = 13.733
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play320251117(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 1.5

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_1 = arg_495_1:GetWordFromCfg(320251116)
				local var_498_2 = arg_495_1:FormatText(var_498_1.content)

				arg_495_1.text_.text = var_498_2

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 60 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 60)

				if (60 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 60)) > 0 and var_498_0 < var_498_4 then
					arg_495_1.talkMaxDuration = var_498_4

					if var_498_4 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_4 + 0
					end
				end

				arg_495_1.text_.text = var_498_2
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251116", "story_v_out_320251.awb") ~= 0 then
					local var_498_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251116", "story_v_out_320251.awb") / 1000

					if var_498_5 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + 0
					end

					if var_498_1.prefab_name ~= "" and arg_495_1.actors_[var_498_1.prefab_name] ~= nil then
						local var_498_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_1.prefab_name].transform, "story_v_out_320251", "320251116", "story_v_out_320251.awb")

						arg_495_1:RecordAudio("320251116", var_498_6)
						arg_495_1:RecordAudio("320251116", var_498_6)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_320251", "320251116", "story_v_out_320251.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_320251", "320251116", "story_v_out_320251.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play320251117 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 320251117
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play320251118(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos1156ui_story = arg_499_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_502_0 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 then
				arg_499_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_499_1.time_ - 0) / var_502_0)
				arg_499_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1156ui_story"].transform.position).z)
				arg_499_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1156ui_story"].transform.localEulerAngles = arg_499_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 then
				arg_499_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_499_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1156ui_story"].transform.position).z)
				arg_499_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1156ui_story"].transform.localEulerAngles = arg_499_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_502_1 = arg_499_1.actors_["1156ui_story"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1156ui_story == nil then
				arg_499_1.var_.characterEffect1156ui_story = var_502_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_2 and not isNil(var_502_1) then
				if arg_499_1.var_.characterEffect1156ui_story and not isNil(var_502_1) then
					arg_499_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_499_1.time_ - 0) / var_502_2)
				end
			end

			if arg_499_1.time_ >= 0 + var_502_2 and arg_499_1.time_ < 0 + var_502_2 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1156ui_story then
				arg_499_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_502_3 = arg_499_1.actors_["1089ui_story"].transform

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos1089ui_story = var_502_3.localPosition
			end

			local var_502_4 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_4 then
				var_502_3.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_499_1.time_ - 0) / var_502_4)
				var_502_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_3.position).x, (manager.ui.mainCamera.transform.position - var_502_3.position).y, (manager.ui.mainCamera.transform.position - var_502_3.position).z)
				var_502_3.localEulerAngles.z = 0
				var_502_3.localEulerAngles.x = 0
				var_502_3.localEulerAngles = var_502_3.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_4 and arg_499_1.time_ < 0 + var_502_4 + arg_502_0 then
				var_502_3.localPosition = Vector3.New(0, 100, 0)
				var_502_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_3.position).x, (manager.ui.mainCamera.transform.position - var_502_3.position).y, (manager.ui.mainCamera.transform.position - var_502_3.position).z)
				var_502_3.localEulerAngles.z = 0
				var_502_3.localEulerAngles.x = 0
				var_502_3.localEulerAngles = var_502_3.localEulerAngles
			end

			local var_502_5 = arg_499_1.actors_["1089ui_story"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_5) and arg_499_1.var_.characterEffect1089ui_story == nil then
				arg_499_1.var_.characterEffect1089ui_story = var_502_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_6 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_6 and not isNil(var_502_5) then
				if arg_499_1.var_.characterEffect1089ui_story and not isNil(var_502_5) then
					arg_499_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_499_1.time_ - 0) / var_502_6)
				end
			end

			if arg_499_1.time_ >= 0 + var_502_6 and arg_499_1.time_ < 0 + var_502_6 + arg_502_0 and not isNil(var_502_5) and arg_499_1.var_.characterEffect1089ui_story then
				arg_499_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_502_7 = 0
			local var_502_8 = 1.025

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_7 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_9 = arg_499_1:FormatText(arg_499_1:GetWordFromCfg(320251117).content)

				arg_499_1.text_.text = var_502_9

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_11 = 41 <= 0 and var_502_8 or var_502_8 * (utf8.len(var_502_9) / 41)

				if (41 <= 0 and var_502_8 or var_502_8 * (utf8.len(var_502_9) / 41)) > 0 and var_502_8 < var_502_11 then
					arg_499_1.talkMaxDuration = var_502_11

					if var_502_11 + var_502_7 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_11 + var_502_7
					end
				end

				arg_499_1.text_.text = var_502_9
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_12 = math.max(var_502_8, arg_499_1.talkMaxDuration)

			if var_502_7 <= arg_499_1.time_ and arg_499_1.time_ < var_502_7 + var_502_12 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_7) / var_502_12

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_7 + var_502_12 and arg_499_1.time_ < var_502_7 + var_502_12 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play320251118 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 320251118
		arg_503_1.duration_ = 4.93

		local var_503_0 = {
			zh = 1.999999999999,
			ja = 4.933
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play320251119(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos1156ui_story = arg_503_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_506_0 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 then
				arg_503_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos1156ui_story, Vector3.New(0.9, -1.1, -6.18), (arg_503_1.time_ - 0) / var_506_0)
				arg_503_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["1156ui_story"].transform.position).z)
				arg_503_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["1156ui_story"].transform.localEulerAngles = arg_503_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 then
				arg_503_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0.9, -1.1, -6.18)
				arg_503_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["1156ui_story"].transform.position).z)
				arg_503_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["1156ui_story"].transform.localEulerAngles = arg_503_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_506_1 = arg_503_1.actors_["1156ui_story"]

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect1156ui_story == nil then
				arg_503_1.var_.characterEffect1156ui_story = var_506_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_2 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_2 and not isNil(var_506_1) then
				if arg_503_1.var_.characterEffect1156ui_story and not isNil(var_506_1) then
					arg_503_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= 0 + var_506_2 and arg_503_1.time_ < 0 + var_506_2 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect1156ui_story then
				arg_503_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action13_1")
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_506_4 = 0
			local var_506_5 = 0.25

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_4 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_6 = arg_503_1:GetWordFromCfg(320251118)
				local var_506_7 = arg_503_1:FormatText(var_506_6.content)

				arg_503_1.text_.text = var_506_7

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_9 = 10 <= 0 and var_506_5 or var_506_5 * (utf8.len(var_506_7) / 10)

				if (10 <= 0 and var_506_5 or var_506_5 * (utf8.len(var_506_7) / 10)) > 0 and var_506_5 < var_506_9 then
					arg_503_1.talkMaxDuration = var_506_9

					if var_506_9 + var_506_4 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_9 + var_506_4
					end
				end

				arg_503_1.text_.text = var_506_7
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251118", "story_v_out_320251.awb") ~= 0 then
					local var_506_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251118", "story_v_out_320251.awb") / 1000

					if var_506_10 + var_506_4 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_10 + var_506_4
					end

					if var_506_6.prefab_name ~= "" and arg_503_1.actors_[var_506_6.prefab_name] ~= nil then
						local var_506_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_6.prefab_name].transform, "story_v_out_320251", "320251118", "story_v_out_320251.awb")

						arg_503_1:RecordAudio("320251118", var_506_11)
						arg_503_1:RecordAudio("320251118", var_506_11)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_320251", "320251118", "story_v_out_320251.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_320251", "320251118", "story_v_out_320251.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_12 = math.max(var_506_5, arg_503_1.talkMaxDuration)

			if var_506_4 <= arg_503_1.time_ and arg_503_1.time_ < var_506_4 + var_506_12 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_4) / var_506_12

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_4 + var_506_12 and arg_503_1.time_ < var_506_4 + var_506_12 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play320251119 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 320251119
		arg_507_1.duration_ = 13.6

		local var_507_0 = {
			zh = 13.6,
			ja = 13.4
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play320251120(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos1089ui_story = arg_507_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_510_0 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 then
				arg_507_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_507_1.time_ - 0) / var_510_0)
				arg_507_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1089ui_story"].transform.position).z)
				arg_507_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1089ui_story"].transform.localEulerAngles = arg_507_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 then
				arg_507_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_507_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1089ui_story"].transform.position).z)
				arg_507_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1089ui_story"].transform.localEulerAngles = arg_507_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_510_1 = arg_507_1.actors_["1089ui_story"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect1089ui_story == nil then
				arg_507_1.var_.characterEffect1089ui_story = var_510_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_2 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_2 and not isNil(var_510_1) then
				if arg_507_1.var_.characterEffect1089ui_story and not isNil(var_510_1) then
					arg_507_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_507_1.time_ >= 0 + var_510_2 and arg_507_1.time_ < 0 + var_510_2 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect1089ui_story then
				arg_507_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_510_4 = arg_507_1.actors_["1156ui_story"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_4) and arg_507_1.var_.characterEffect1156ui_story == nil then
				arg_507_1.var_.characterEffect1156ui_story = var_510_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_5 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_5 and not isNil(var_510_4) then
				if arg_507_1.var_.characterEffect1156ui_story and not isNil(var_510_4) then
					arg_507_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_507_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_507_1.time_ - 0) / var_510_5)
				end
			end

			if arg_507_1.time_ >= 0 + var_510_5 and arg_507_1.time_ < 0 + var_510_5 + arg_510_0 and not isNil(var_510_4) and arg_507_1.var_.characterEffect1156ui_story then
				arg_507_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_507_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_510_6 = 0
			local var_510_7 = 1.625

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_6 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_8 = arg_507_1:GetWordFromCfg(320251119)
				local var_510_9 = arg_507_1:FormatText(var_510_8.content)

				arg_507_1.text_.text = var_510_9

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_11 = 65 <= 0 and var_510_7 or var_510_7 * (utf8.len(var_510_9) / 65)

				if (65 <= 0 and var_510_7 or var_510_7 * (utf8.len(var_510_9) / 65)) > 0 and var_510_7 < var_510_11 then
					arg_507_1.talkMaxDuration = var_510_11

					if var_510_11 + var_510_6 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_11 + var_510_6
					end
				end

				arg_507_1.text_.text = var_510_9
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251119", "story_v_out_320251.awb") ~= 0 then
					local var_510_12 = manager.audio:GetVoiceLength("story_v_out_320251", "320251119", "story_v_out_320251.awb") / 1000

					if var_510_12 + var_510_6 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_12 + var_510_6
					end

					if var_510_8.prefab_name ~= "" and arg_507_1.actors_[var_510_8.prefab_name] ~= nil then
						local var_510_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_8.prefab_name].transform, "story_v_out_320251", "320251119", "story_v_out_320251.awb")

						arg_507_1:RecordAudio("320251119", var_510_13)
						arg_507_1:RecordAudio("320251119", var_510_13)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_320251", "320251119", "story_v_out_320251.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_320251", "320251119", "story_v_out_320251.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_14 = math.max(var_510_7, arg_507_1.talkMaxDuration)

			if var_510_6 <= arg_507_1.time_ and arg_507_1.time_ < var_510_6 + var_510_14 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_6) / var_510_14

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_6 + var_510_14 and arg_507_1.time_ < var_510_6 + var_510_14 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play320251120 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 320251120
		arg_511_1.duration_ = 10.07

		local var_511_0 = {
			zh = 8.1,
			ja = 10.066
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play320251121(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0.925

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_1 = arg_511_1:GetWordFromCfg(320251120)
				local var_514_2 = arg_511_1:FormatText(var_514_1.content)

				arg_511_1.text_.text = var_514_2

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_4 = 37 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_2) / 37)

				if (37 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_2) / 37)) > 0 and var_514_0 < var_514_4 then
					arg_511_1.talkMaxDuration = var_514_4

					if var_514_4 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_4 + 0
					end
				end

				arg_511_1.text_.text = var_514_2
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251120", "story_v_out_320251.awb") ~= 0 then
					local var_514_5 = manager.audio:GetVoiceLength("story_v_out_320251", "320251120", "story_v_out_320251.awb") / 1000

					if var_514_5 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_5 + 0
					end

					if var_514_1.prefab_name ~= "" and arg_511_1.actors_[var_514_1.prefab_name] ~= nil then
						local var_514_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_1.prefab_name].transform, "story_v_out_320251", "320251120", "story_v_out_320251.awb")

						arg_511_1:RecordAudio("320251120", var_514_6)
						arg_511_1:RecordAudio("320251120", var_514_6)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_320251", "320251120", "story_v_out_320251.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_320251", "320251120", "story_v_out_320251.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_7 = math.max(var_514_0, arg_511_1.talkMaxDuration)

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_7 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - 0) / var_514_7

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= 0 + var_514_7 and arg_511_1.time_ < 0 + var_514_7 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play320251121 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 320251121
		arg_515_1.duration_ = 6.23

		local var_515_0 = {
			zh = 3.6,
			ja = 6.233
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play320251122(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos1156ui_story = arg_515_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_518_0 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 then
				arg_515_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1156ui_story, Vector3.New(0.9, -1.1, -6.18), (arg_515_1.time_ - 0) / var_518_0)
				arg_515_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1156ui_story"].transform.position).z)
				arg_515_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1156ui_story"].transform.localEulerAngles = arg_515_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 then
				arg_515_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0.9, -1.1, -6.18)
				arg_515_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1156ui_story"].transform.position).z)
				arg_515_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1156ui_story"].transform.localEulerAngles = arg_515_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_518_1 = arg_515_1.actors_["1156ui_story"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_1) and arg_515_1.var_.characterEffect1156ui_story == nil then
				arg_515_1.var_.characterEffect1156ui_story = var_518_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_2 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_2 and not isNil(var_518_1) then
				if arg_515_1.var_.characterEffect1156ui_story and not isNil(var_518_1) then
					arg_515_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= 0 + var_518_2 and arg_515_1.time_ < 0 + var_518_2 + arg_518_0 and not isNil(var_518_1) and arg_515_1.var_.characterEffect1156ui_story then
				arg_515_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action13_2")
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_518_4 = arg_515_1.actors_["1089ui_story"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_4) and arg_515_1.var_.characterEffect1089ui_story == nil then
				arg_515_1.var_.characterEffect1089ui_story = var_518_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_5 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_5 and not isNil(var_518_4) then
				if arg_515_1.var_.characterEffect1089ui_story and not isNil(var_518_4) then
					arg_515_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_515_1.time_ - 0) / var_518_5)
				end
			end

			if arg_515_1.time_ >= 0 + var_518_5 and arg_515_1.time_ < 0 + var_518_5 + arg_518_0 and not isNil(var_518_4) and arg_515_1.var_.characterEffect1089ui_story then
				arg_515_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_518_6 = 0
			local var_518_7 = 0.525

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_6 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_8 = arg_515_1:GetWordFromCfg(320251121)
				local var_518_9 = arg_515_1:FormatText(var_518_8.content)

				arg_515_1.text_.text = var_518_9

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_11 = 21 <= 0 and var_518_7 or var_518_7 * (utf8.len(var_518_9) / 21)

				if (21 <= 0 and var_518_7 or var_518_7 * (utf8.len(var_518_9) / 21)) > 0 and var_518_7 < var_518_11 then
					arg_515_1.talkMaxDuration = var_518_11

					if var_518_11 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_11 + var_518_6
					end
				end

				arg_515_1.text_.text = var_518_9
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251121", "story_v_out_320251.awb") ~= 0 then
					local var_518_12 = manager.audio:GetVoiceLength("story_v_out_320251", "320251121", "story_v_out_320251.awb") / 1000

					if var_518_12 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_12 + var_518_6
					end

					if var_518_8.prefab_name ~= "" and arg_515_1.actors_[var_518_8.prefab_name] ~= nil then
						local var_518_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_8.prefab_name].transform, "story_v_out_320251", "320251121", "story_v_out_320251.awb")

						arg_515_1:RecordAudio("320251121", var_518_13)
						arg_515_1:RecordAudio("320251121", var_518_13)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_320251", "320251121", "story_v_out_320251.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_320251", "320251121", "story_v_out_320251.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_14 = math.max(var_518_7, arg_515_1.talkMaxDuration)

			if var_518_6 <= arg_515_1.time_ and arg_515_1.time_ < var_518_6 + var_518_14 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_6) / var_518_14

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_6 + var_518_14 and arg_515_1.time_ < var_518_6 + var_518_14 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play320251122 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 320251122
		arg_519_1.duration_ = 5.4

		local var_519_0 = {
			zh = 5.4,
			ja = 4.6
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play320251123(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(arg_519_1.actors_["1089ui_story"]) and arg_519_1.var_.characterEffect1089ui_story == nil then
				arg_519_1.var_.characterEffect1089ui_story = arg_519_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_0 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 and not isNil(arg_519_1.actors_["1089ui_story"]) then
				if arg_519_1.var_.characterEffect1089ui_story and not isNil(arg_519_1.actors_["1089ui_story"]) then
					arg_519_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 and not isNil(arg_519_1.actors_["1089ui_story"]) and arg_519_1.var_.characterEffect1089ui_story then
				arg_519_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_522_2 = arg_519_1.actors_["1156ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_2) and arg_519_1.var_.characterEffect1156ui_story == nil then
				arg_519_1.var_.characterEffect1156ui_story = var_522_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_3 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_3 and not isNil(var_522_2) then
				if arg_519_1.var_.characterEffect1156ui_story and not isNil(var_522_2) then
					arg_519_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_519_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_519_1.time_ - 0) / var_522_3)
				end
			end

			if arg_519_1.time_ >= 0 + var_522_3 and arg_519_1.time_ < 0 + var_522_3 + arg_522_0 and not isNil(var_522_2) and arg_519_1.var_.characterEffect1156ui_story then
				arg_519_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_519_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_522_4 = 0
			local var_522_5 = 0.5

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_4 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_6 = arg_519_1:GetWordFromCfg(320251122)
				local var_522_7 = arg_519_1:FormatText(var_522_6.content)

				arg_519_1.text_.text = var_522_7

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_9 = 20 <= 0 and var_522_5 or var_522_5 * (utf8.len(var_522_7) / 20)

				if (20 <= 0 and var_522_5 or var_522_5 * (utf8.len(var_522_7) / 20)) > 0 and var_522_5 < var_522_9 then
					arg_519_1.talkMaxDuration = var_522_9

					if var_522_9 + var_522_4 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_9 + var_522_4
					end
				end

				arg_519_1.text_.text = var_522_7
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251122", "story_v_out_320251.awb") ~= 0 then
					local var_522_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251122", "story_v_out_320251.awb") / 1000

					if var_522_10 + var_522_4 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_10 + var_522_4
					end

					if var_522_6.prefab_name ~= "" and arg_519_1.actors_[var_522_6.prefab_name] ~= nil then
						local var_522_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_6.prefab_name].transform, "story_v_out_320251", "320251122", "story_v_out_320251.awb")

						arg_519_1:RecordAudio("320251122", var_522_11)
						arg_519_1:RecordAudio("320251122", var_522_11)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_320251", "320251122", "story_v_out_320251.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_320251", "320251122", "story_v_out_320251.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_12 = math.max(var_522_5, arg_519_1.talkMaxDuration)

			if var_522_4 <= arg_519_1.time_ and arg_519_1.time_ < var_522_4 + var_522_12 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_4) / var_522_12

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_4 + var_522_12 and arg_519_1.time_ < var_522_4 + var_522_12 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play320251123 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 320251123
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play320251124(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["1089ui_story"]) and arg_523_1.var_.characterEffect1089ui_story == nil then
				arg_523_1.var_.characterEffect1089ui_story = arg_523_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_0 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["1089ui_story"]) then
				if arg_523_1.var_.characterEffect1089ui_story and not isNil(arg_523_1.actors_["1089ui_story"]) then
					arg_523_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_0)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["1089ui_story"]) and arg_523_1.var_.characterEffect1089ui_story then
				arg_523_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_526_1 = 0
			local var_526_2 = 0.9

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_3 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(320251123).content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 36 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 36)

				if (36 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 36)) > 0 and var_526_2 < var_526_5 then
					arg_523_1.talkMaxDuration = var_526_5

					if var_526_5 + var_526_1 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_5 + var_526_1
					end
				end

				arg_523_1.text_.text = var_526_3
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_6 = math.max(var_526_2, arg_523_1.talkMaxDuration)

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_6 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_1) / var_526_6

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_1 + var_526_6 and arg_523_1.time_ < var_526_1 + var_526_6 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play320251124 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 320251124
		arg_527_1.duration_ = 12.87

		local var_527_0 = {
			zh = 6.1,
			ja = 12.866
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
			arg_527_1.auto_ = false
		end

		function arg_527_1.playNext_(arg_529_0)
			arg_527_1.onStoryFinished_()
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(arg_527_1.actors_["1089ui_story"]) and arg_527_1.var_.characterEffect1089ui_story == nil then
				arg_527_1.var_.characterEffect1089ui_story = arg_527_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_0 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 and not isNil(arg_527_1.actors_["1089ui_story"]) then
				if arg_527_1.var_.characterEffect1089ui_story and not isNil(arg_527_1.actors_["1089ui_story"]) then
					arg_527_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 and not isNil(arg_527_1.actors_["1089ui_story"]) and arg_527_1.var_.characterEffect1089ui_story then
				arg_527_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			local var_530_2 = 0
			local var_530_3 = 0.675

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_2 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_4 = arg_527_1:GetWordFromCfg(320251124)
				local var_530_5 = arg_527_1:FormatText(var_530_4.content)

				arg_527_1.text_.text = var_530_5

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_7 = 27 <= 0 and var_530_3 or var_530_3 * (utf8.len(var_530_5) / 27)

				if (27 <= 0 and var_530_3 or var_530_3 * (utf8.len(var_530_5) / 27)) > 0 and var_530_3 < var_530_7 then
					arg_527_1.talkMaxDuration = var_530_7

					if var_530_7 + var_530_2 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_7 + var_530_2
					end
				end

				arg_527_1.text_.text = var_530_5
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251124", "story_v_out_320251.awb") ~= 0 then
					local var_530_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251124", "story_v_out_320251.awb") / 1000

					if var_530_8 + var_530_2 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_8 + var_530_2
					end

					if var_530_4.prefab_name ~= "" and arg_527_1.actors_[var_530_4.prefab_name] ~= nil then
						local var_530_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_4.prefab_name].transform, "story_v_out_320251", "320251124", "story_v_out_320251.awb")

						arg_527_1:RecordAudio("320251124", var_530_9)
						arg_527_1:RecordAudio("320251124", var_530_9)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_320251", "320251124", "story_v_out_320251.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_320251", "320251124", "story_v_out_320251.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_10 = math.max(var_530_3, arg_527_1.talkMaxDuration)

			if var_530_2 <= arg_527_1.time_ and arg_527_1.time_ < var_530_2 + var_530_10 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_2) / var_530_10

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_2 + var_530_10 and arg_527_1.time_ < var_530_2 + var_530_10 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/L02f"
	},
	voices = {
		"story_v_out_320251.awb"
	}
}
