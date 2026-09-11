return {
	Play104101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104101001
		arg_1_1.duration_ = 4.67

		local var_1_0 = {
			ja = 3.933,
			ko = 4.666,
			zh = 4,
			en = 4.166
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
				arg_1_0:Play104101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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

			local var_4_3 = "B13"

			if arg_1_1.bgs_.B13 == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.B13:GetComponent("SpriteRenderer")

				if var_4_5 then
					arg_1_1.var_.alphaOldValueB13 = var_4_5.color.a
					arg_1_1.var_.alphaMatValueB13 = var_4_5
				end

				arg_1_1.var_.alphaOldValueB13 = 0
			end

			local var_4_6 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_6 then
				if arg_1_1.var_.alphaMatValueB13 then
					arg_1_1.var_.alphaMatValueB13.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB13, 1, (arg_1_1.time_ - 0) / var_4_6)
					arg_1_1.var_.alphaMatValueB13.color = arg_1_1.var_.alphaMatValueB13.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_6 and arg_1_1.time_ < 0 + var_4_6 + arg_4_0 and arg_1_1.var_.alphaMatValueB13 then
				arg_1_1.var_.alphaMatValueB13.color.a = 1
				arg_1_1.var_.alphaMatValueB13.color = arg_1_1.var_.alphaMatValueB13.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_7 = arg_1_1.bgs_.B13

				arg_1_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = 2 * (var_4_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_7.transform.localScale = Vector3.New(var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_10 = "2070_tpose"

			if arg_1_1.actors_["2070_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2070_tpose"))) then
				local var_4_11 = Object.Instantiate(Asset.Load("Char/" .. "2070_tpose"), arg_1_1.stage_.transform)

				var_4_11.name = var_4_10
				var_4_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_10] = var_4_11

				local var_4_12 = var_4_11:GetComponentInChildren(typeof(CharacterEffect))

				var_4_12.enabled = true

				local var_4_13 = GameObjectTools.GetOrAddComponent(var_4_11, typeof(DynamicBoneHelper))

				if var_4_13 then
					var_4_13:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_12.transform, false)

				arg_1_1.var_[var_4_10 .. "Animator"] = var_4_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_10 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_10 .. "LipSync"] = var_4_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_14 = arg_1_1.actors_["2070_tpose"].transform

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1.var_.moveOldPos2070_tpose = var_4_14.localPosition

				local var_4_15 = GameObjectTools.GetOrAddComponent(var_4_14.gameObject, typeof(DynamicBoneHelper))

				if var_4_15 then
					var_4_15:EnableDynamicBone(false)
				end
			end

			local var_4_16 = 0.001

			if 1.79999995231628 <= arg_1_1.time_ and arg_1_1.time_ < 1.79999995231628 + var_4_16 then
				var_4_14.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2070_tpose, Vector3.New(0, -0.49, -3.1), (arg_1_1.time_ - 1.79999995231628) / var_4_16)
				var_4_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_14.position).x, (manager.ui.mainCamera.transform.position - var_4_14.position).y, (manager.ui.mainCamera.transform.position - var_4_14.position).z)
				var_4_14.localEulerAngles.z = 0
				var_4_14.localEulerAngles.x = 0
				var_4_14.localEulerAngles = var_4_14.localEulerAngles
			end

			if arg_1_1.time_ >= 1.79999995231628 + var_4_16 and arg_1_1.time_ < 1.79999995231628 + var_4_16 + arg_4_0 then
				var_4_14.localPosition = Vector3.New(0, -0.49, -3.1)
				var_4_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_14.position).x, (manager.ui.mainCamera.transform.position - var_4_14.position).y, (manager.ui.mainCamera.transform.position - var_4_14.position).z)
				var_4_14.localEulerAngles.z = 0
				var_4_14.localEulerAngles.x = 0
				var_4_14.localEulerAngles = var_4_14.localEulerAngles

				local var_4_17 = GameObjectTools.GetOrAddComponent(var_4_14.gameObject, typeof(DynamicBoneHelper))

				if var_4_17 then
					var_4_17:EnableDynamicBone(true)
				end
			end

			local var_4_18 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_18 + 2 and arg_1_1.time_ < var_4_18 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 2
			local var_4_20 = 0.225

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_22 = arg_1_1:GetWordFromCfg(104101001)
				local var_4_23 = arg_1_1:FormatText(var_4_22.content)

				arg_1_1.text_.text = var_4_23

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 9 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_23) / 9)

				if (9 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_23) / 9)) > 0 and var_4_20 < var_4_25 then
					arg_1_1.talkMaxDuration = var_4_25
					var_4_19 = var_4_19 + 0.3

					if var_4_25 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_23
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101001", "story_v_out_104101.awb") ~= 0 then
					local var_4_26 = manager.audio:GetVoiceLength("story_v_out_104101", "104101001", "story_v_out_104101.awb") / 1000

					if var_4_26 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_19
					end

					if var_4_22.prefab_name ~= "" and arg_1_1.actors_[var_4_22.prefab_name] ~= nil then
						local var_4_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_22.prefab_name].transform, "story_v_out_104101", "104101001", "story_v_out_104101.awb")

						arg_1_1:RecordAudio("104101001", var_4_27)
						arg_1_1:RecordAudio("104101001", var_4_27)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104101", "104101001", "story_v_out_104101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104101", "104101001", "story_v_out_104101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_28 = var_4_19 + 0.3
			local var_4_29 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_28) / var_4_29

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2070_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play104101002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104101002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play104101003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story", "se_story_fight_normalgun", "")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story", "se_story_fight_normalgun", "")
			end

			local var_11_2 = 0

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_2 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_3 = 0.5

			if var_11_2 <= arg_8_1.time_ and arg_8_1.time_ < var_11_2 + var_11_3 then
				local var_11_4 = Color.New(1, 1, 1)

				var_11_4.a = Mathf.Lerp(1, 0, (arg_8_1.time_ - var_11_2) / var_11_3)
				arg_8_1.mask_.color = var_11_4
			end

			if arg_8_1.time_ >= var_11_2 + var_11_3 and arg_8_1.time_ < var_11_2 + var_11_3 + arg_11_0 then
				local var_11_5 = Color.New(1, 1, 1)

				arg_8_1.mask_.enabled = false
				var_11_5.a = 0
				arg_8_1.mask_.color = var_11_5
			end

			local var_11_6 = manager.ui.mainCamera.transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.shakeOldPosMainCamera = var_11_6.localPosition
			end

			local var_11_7 = 0.600000023841858

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				local var_11_8, var_11_9 = math.modf((arg_8_1.time_ - 0) / 0.066)

				var_11_6.localPosition = Vector3.New(var_11_9 * 0.13, var_11_9 * 0.13, var_11_9 * 0.13) + arg_8_1.var_.shakeOldPosMainCamera
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_6.localPosition = arg_8_1.var_.shakeOldPosMainCamera
			end

			local var_11_10 = 0
			local var_11_11 = 0.2

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(104101002).content)

				arg_8_1.text_.text = var_11_12

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_14 = 8 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_12) / 8)

				if (8 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_12) / 8)) > 0 and var_11_11 < var_11_14 then
					arg_8_1.talkMaxDuration = var_11_14

					if var_11_14 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_12
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_15 = math.max(var_11_11, arg_8_1.talkMaxDuration)

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_15 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_10) / var_11_15

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_10 + var_11_15 and arg_8_1.time_ < var_11_10 + var_11_15 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play104101003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104101003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play104101004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos2070_tpose = arg_12_1.actors_["2070_tpose"].transform.localPosition

				local var_15_0 = GameObjectTools.GetOrAddComponent(arg_12_1.actors_["2070_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_15_0 then
					var_15_0:EnableDynamicBone(false)
				end
			end

			local var_15_1 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_1 then
				arg_12_1.actors_["2070_tpose"].transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2070_tpose, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_1)
				arg_12_1.actors_["2070_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["2070_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["2070_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["2070_tpose"].transform.position).z)
				arg_12_1.actors_["2070_tpose"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["2070_tpose"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["2070_tpose"].transform.localEulerAngles = arg_12_1.actors_["2070_tpose"].transform.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_1 and arg_12_1.time_ < 0 + var_15_1 + arg_15_0 then
				arg_12_1.actors_["2070_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["2070_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["2070_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["2070_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["2070_tpose"].transform.position).z)
				arg_12_1.actors_["2070_tpose"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["2070_tpose"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["2070_tpose"].transform.localEulerAngles = arg_12_1.actors_["2070_tpose"].transform.localEulerAngles

				local var_15_2 = GameObjectTools.GetOrAddComponent(arg_12_1.actors_["2070_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(true)
				end
			end

			local var_15_3 = 0
			local var_15_4 = 0.375

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_3 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_5 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(104101003).content)

				arg_12_1.text_.text = var_15_5

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_7 = 15 <= 0 and var_15_4 or var_15_4 * (utf8.len(var_15_5) / 15)

				if (15 <= 0 and var_15_4 or var_15_4 * (utf8.len(var_15_5) / 15)) > 0 and var_15_4 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_3 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_3
					end
				end

				arg_12_1.text_.text = var_15_5
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_8 = math.max(var_15_4, arg_12_1.talkMaxDuration)

			if var_15_3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_3 + var_15_8 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_3) / var_15_8

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_3 + var_15_8 and arg_12_1.time_ < var_15_3 + var_15_8 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2070_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play104101004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104101004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play104101005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.775

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(104101004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 31 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 31)

				if (31 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 31)) > 0 and var_19_0 < var_19_3 then
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
	Play104101005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104101005
		arg_20_1.duration_ = 12.4

		local var_20_0 = {
			ja = 12,
			ko = 10.766,
			zh = 12.4,
			en = 8.766
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
				arg_20_0:Play104101006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 3 < arg_20_1.time_ and arg_20_1.time_ <= 3 + arg_23_0 then
				arg_20_1:AudioAction("play", "effect", "se_story", "se_story_robot_long", "")
			end

			local var_23_1 = "S0408"

			if arg_20_1.bgs_.S0408 == nil then
				local var_23_2 = Object.Instantiate(arg_20_1.paintGo_)

				var_23_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_23_1)
				var_23_2.name = var_23_1
				var_23_2.transform.parent = arg_20_1.stage_.transform
				var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.bgs_[var_23_1] = var_23_2
			end

			if 1.5 < arg_20_1.time_ and arg_20_1.time_ <= 1.5 + arg_23_0 then
				local var_23_3 = arg_20_1.bgs_.S0408

				arg_20_1.bgs_.S0408.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_23_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_4 = var_23_3:GetComponent("SpriteRenderer")

				if var_23_4 and var_23_4.sprite then
					local var_23_5 = 2 * (var_23_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_23_3.transform.localScale = Vector3.New(var_23_5 / var_23_4.sprite.bounds.size.y < var_23_5 * manager.ui.mainCameraCom_.aspect / var_23_4.sprite.bounds.size.x and var_23_5 * manager.ui.mainCameraCom_.aspect / var_23_4.sprite.bounds.size.x or var_23_5 / var_23_4.sprite.bounds.size.y, var_23_5 / var_23_4.sprite.bounds.size.y < var_23_5 * manager.ui.mainCameraCom_.aspect / var_23_4.sprite.bounds.size.x and var_23_5 * manager.ui.mainCameraCom_.aspect / var_23_4.sprite.bounds.size.x or var_23_5 / var_23_4.sprite.bounds.size.y, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "S0408" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.5 < arg_20_1.time_ and arg_20_1.time_ <= 1.5 + arg_23_0 then
				local var_23_6 = arg_20_1.bgs_.S0408:GetComponent("SpriteRenderer")

				if var_23_6 then
					arg_20_1.var_.alphaOldValueS0408 = var_23_6.color.a
					arg_20_1.var_.alphaMatValueS0408 = var_23_6
				end

				arg_20_1.var_.alphaOldValueS0408 = 0
			end

			local var_23_7 = 1.5

			if 1.5 <= arg_20_1.time_ and arg_20_1.time_ < 1.5 + var_23_7 then
				if arg_20_1.var_.alphaMatValueS0408 then
					arg_20_1.var_.alphaMatValueS0408.color.a = Mathf.Lerp(arg_20_1.var_.alphaOldValueS0408, 1, (arg_20_1.time_ - 1.5) / var_23_7)
					arg_20_1.var_.alphaMatValueS0408.color = arg_20_1.var_.alphaMatValueS0408.color
				end
			end

			if arg_20_1.time_ >= 1.5 + var_23_7 and arg_20_1.time_ < 1.5 + var_23_7 + arg_23_0 and arg_20_1.var_.alphaMatValueS0408 then
				arg_20_1.var_.alphaMatValueS0408.color.a = 1
				arg_20_1.var_.alphaMatValueS0408.color = arg_20_1.var_.alphaMatValueS0408.color
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				local var_23_8 = arg_20_1.bgs_.B13:GetComponent("SpriteRenderer")

				if var_23_8 then
					arg_20_1.var_.alphaOldValueB13 = var_23_8.color.a
					arg_20_1.var_.alphaMatValueB13 = var_23_8
				end

				arg_20_1.var_.alphaOldValueB13 = 1
			end

			local var_23_9 = 1.5

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_9 then
				if arg_20_1.var_.alphaMatValueB13 then
					arg_20_1.var_.alphaMatValueB13.color.a = Mathf.Lerp(arg_20_1.var_.alphaOldValueB13, 0, (arg_20_1.time_ - 0) / var_23_9)
					arg_20_1.var_.alphaMatValueB13.color = arg_20_1.var_.alphaMatValueB13.color
				end
			end

			if arg_20_1.time_ >= 0 + var_23_9 and arg_20_1.time_ < 0 + var_23_9 + arg_23_0 and arg_20_1.var_.alphaMatValueB13 then
				arg_20_1.var_.alphaMatValueB13.color.a = 0
				arg_20_1.var_.alphaMatValueB13.color = arg_20_1.var_.alphaMatValueB13.color
			end

			local var_23_10 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			if arg_20_1.time_ >= var_23_10 + 3 and arg_20_1.time_ < var_23_10 + 3 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_11 = 3
			local var_23_12 = 0.625

			if 3 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_13 = arg_20_1:GetWordFromCfg(104101005)
				local var_23_14 = arg_20_1:FormatText(var_23_13.content)

				arg_20_1.text_.text = var_23_14

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_16 = 25 <= 0 and var_23_12 or var_23_12 * (utf8.len(var_23_14) / 25)

				if (25 <= 0 and var_23_12 or var_23_12 * (utf8.len(var_23_14) / 25)) > 0 and var_23_12 < var_23_16 then
					arg_20_1.talkMaxDuration = var_23_16

					if var_23_16 + var_23_11 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_11
					end
				end

				arg_20_1.text_.text = var_23_14
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101005", "story_v_out_104101.awb") ~= 0 then
					local var_23_17 = manager.audio:GetVoiceLength("story_v_out_104101", "104101005", "story_v_out_104101.awb") / 1000

					if var_23_17 + var_23_11 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_11
					end

					if var_23_13.prefab_name ~= "" and arg_20_1.actors_[var_23_13.prefab_name] ~= nil then
						local var_23_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_13.prefab_name].transform, "story_v_out_104101", "104101005", "story_v_out_104101.awb")

						arg_20_1:RecordAudio("104101005", var_23_18)
						arg_20_1:RecordAudio("104101005", var_23_18)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104101", "104101005", "story_v_out_104101.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104101", "104101005", "story_v_out_104101.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_19 = math.max(var_23_12, arg_20_1.talkMaxDuration)

			if var_23_11 <= arg_20_1.time_ and arg_20_1.time_ < var_23_11 + var_23_19 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_11) / var_23_19

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_11 + var_23_19 and arg_20_1.time_ < var_23_11 + var_23_19 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play104101006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104101006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play104101007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["2019_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2019_tpose"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "2019_tpose"), arg_24_1.stage_.transform)

				var_27_0.name = "2019_tpose"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["2019_tpose"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["2019_tpose" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["2019_tpose" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["2019_tpose" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_3 = arg_24_1.actors_["2019_tpose"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect2019_tpose == nil then
				arg_24_1.var_.characterEffect2019_tpose = var_27_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_4 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 and not isNil(var_27_3) then
				if arg_24_1.var_.characterEffect2019_tpose and not isNil(var_27_3) then
					arg_24_1.var_.characterEffect2019_tpose.fillFlat = true
					arg_24_1.var_.characterEffect2019_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_4)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect2019_tpose then
				arg_24_1.var_.characterEffect2019_tpose.fillFlat = true
				arg_24_1.var_.characterEffect2019_tpose.fillRatio = 0.5
			end

			local var_27_5 = arg_24_1.actors_["2019_tpose"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos2019_tpose = var_27_5.localPosition

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_5.gameObject, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(false)
				end
			end

			local var_27_7 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos2019_tpose, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_7)
				var_27_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_5.position).x, (manager.ui.mainCamera.transform.position - var_27_5.position).y, (manager.ui.mainCamera.transform.position - var_27_5.position).z)
				var_27_5.localEulerAngles.z = 0
				var_27_5.localEulerAngles.x = 0
				var_27_5.localEulerAngles = var_27_5.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(0, 100, 0)
				var_27_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_5.position).x, (manager.ui.mainCamera.transform.position - var_27_5.position).y, (manager.ui.mainCamera.transform.position - var_27_5.position).z)
				var_27_5.localEulerAngles.z = 0
				var_27_5.localEulerAngles.x = 0
				var_27_5.localEulerAngles = var_27_5.localEulerAngles

				local var_27_8 = GameObjectTools.GetOrAddComponent(var_27_5.gameObject, typeof(DynamicBoneHelper))

				if var_27_8 then
					var_27_8:EnableDynamicBone(true)
				end
			end

			local var_27_9 = 0
			local var_27_10 = 0.1

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_11 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(104101006).content)

				arg_24_1.text_.text = var_27_11

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 4 <= 0 and var_27_10 or var_27_10 * (utf8.len(var_27_11) / 4)

				if (4 <= 0 and var_27_10 or var_27_10 * (utf8.len(var_27_11) / 4)) > 0 and var_27_10 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_9 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_9
					end
				end

				arg_24_1.text_.text = var_27_11
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_10, arg_24_1.talkMaxDuration)

			if var_27_9 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_9) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_9 + var_27_14 and arg_24_1.time_ < var_27_9 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2019_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play104101007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104101007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play104101008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 1.025

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(104101007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 41 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 41)

				if (41 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 41)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play104101008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104101008
		arg_32_1.duration_ = 8.8

		local var_32_0 = {
			ja = 8.8,
			ko = 5.5,
			zh = 5.733,
			en = 7.3
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
				arg_32_0:Play104101009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.675

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:GetWordFromCfg(104101008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 27 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 27)

				if (27 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 27)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101008", "story_v_out_104101.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_104101", "104101008", "story_v_out_104101.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_104101", "104101008", "story_v_out_104101.awb")

						arg_32_1:RecordAudio("104101008", var_35_6)
						arg_32_1:RecordAudio("104101008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104101", "104101008", "story_v_out_104101.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104101", "104101008", "story_v_out_104101.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play104101009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104101009
		arg_36_1.duration_ = 8.83

		local var_36_0 = {
			ja = 3.8,
			ko = 8.3,
			zh = 8.833,
			en = 7.733
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
				arg_36_0:Play104101010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:AudioAction("play", "effect", "se_story", "se_story_robot_long", "")
			end

			local var_39_1 = 0
			local var_39_2 = 0.575

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(104101009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 23 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_4) / 23)

				if (23 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_4) / 23)) > 0 and var_39_2 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101009", "story_v_out_104101.awb") ~= 0 then
					local var_39_7 = manager.audio:GetVoiceLength("story_v_out_104101", "104101009", "story_v_out_104101.awb") / 1000

					if var_39_7 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_1
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_104101", "104101009", "story_v_out_104101.awb")

						arg_36_1:RecordAudio("104101009", var_39_8)
						arg_36_1:RecordAudio("104101009", var_39_8)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104101", "104101009", "story_v_out_104101.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104101", "104101009", "story_v_out_104101.awb")
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
	Play104101010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104101010
		arg_40_1.duration_ = 0.1

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"

			SetActive(arg_40_1.choicesGo_, true)

			for iter_41_0, iter_41_1 in ipairs(arg_40_1.choices_) do
				SetActive(iter_41_1.go, iter_41_0 <= 1)
			end

			arg_40_1.choices_[1].txt.text = arg_40_1:FormatText(StoryChoiceCfg[27].name)
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play104101011(arg_40_1)
			end

			arg_40_1:RecordChoiceLog(104101010, 27)
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			return
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play104101011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104101011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play104101012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:AudioAction("play", "effect", "se_story", "se_story_fight_normalgun", "")
			end

			local var_47_1 = 0

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_2 = 0.5

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = Color.New(1, 1, 1)

				var_47_3.a = Mathf.Lerp(1, 0, (arg_44_1.time_ - var_47_1) / var_47_2)
				arg_44_1.mask_.color = var_47_3
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				local var_47_4 = Color.New(1, 1, 1)

				arg_44_1.mask_.enabled = false
				var_47_4.a = 0
				arg_44_1.mask_.color = var_47_4
			end

			local var_47_5 = manager.ui.mainCamera.transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.shakeOldPosMainCamera = var_47_5.localPosition
			end

			local var_47_6 = 0.600000023841858

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_6 then
				local var_47_7, var_47_8 = math.modf((arg_44_1.time_ - 0) / 0.066)

				var_47_5.localPosition = Vector3.New(var_47_8 * 0.13, var_47_8 * 0.13, var_47_8 * 0.13) + arg_44_1.var_.shakeOldPosMainCamera
			end

			if arg_44_1.time_ >= 0 + var_47_6 and arg_44_1.time_ < 0 + var_47_6 + arg_47_0 then
				var_47_5.localPosition = arg_44_1.var_.shakeOldPosMainCamera
			end

			local var_47_9 = "S0408a"

			if arg_44_1.bgs_.S0408a == nil then
				local var_47_10 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_9)
				var_47_10.name = var_47_9
				var_47_10.transform.parent = arg_44_1.stage_.transform
				var_47_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_9] = var_47_10
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				local var_47_11 = arg_44_1.bgs_.S0408a

				arg_44_1.bgs_.S0408a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_47_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_12 = var_47_11:GetComponent("SpriteRenderer")

				if var_47_12 and var_47_12.sprite then
					local var_47_13 = 2 * (var_47_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_47_11.transform.localScale = Vector3.New(var_47_13 / var_47_12.sprite.bounds.size.y < var_47_13 * manager.ui.mainCameraCom_.aspect / var_47_12.sprite.bounds.size.x and var_47_13 * manager.ui.mainCameraCom_.aspect / var_47_12.sprite.bounds.size.x or var_47_13 / var_47_12.sprite.bounds.size.y, var_47_13 / var_47_12.sprite.bounds.size.y < var_47_13 * manager.ui.mainCameraCom_.aspect / var_47_12.sprite.bounds.size.x and var_47_13 * manager.ui.mainCameraCom_.aspect / var_47_12.sprite.bounds.size.x or var_47_13 / var_47_12.sprite.bounds.size.y, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "S0408a" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_14 = 0
			local var_47_15 = 0.1

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[64].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_16 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(104101011).content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_18 = 4 <= 0 and var_47_15 or var_47_15 * (utf8.len(var_47_16) / 4)

				if (4 <= 0 and var_47_15 or var_47_15 * (utf8.len(var_47_16) / 4)) > 0 and var_47_15 < var_47_18 then
					arg_44_1.talkMaxDuration = var_47_18

					if var_47_18 + var_47_14 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_14
					end
				end

				arg_44_1.text_.text = var_47_16
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_19 = math.max(var_47_15, arg_44_1.talkMaxDuration)

			if var_47_14 <= arg_44_1.time_ and arg_44_1.time_ < var_47_14 + var_47_19 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_14) / var_47_19

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_14 + var_47_19 and arg_44_1.time_ < var_47_14 + var_47_19 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play104101012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104101012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play104101013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			local var_51_1 = 0
			local var_51_2 = 0.3

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(104101012).content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 12 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 12)

				if (12 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 12)) > 0 and var_51_2 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_6 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_6 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_6

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_6 and arg_48_1.time_ < var_51_1 + var_51_6 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play104101013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104101013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play104101014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.325

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(104101013).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 13 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 13)

				if (13 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 13)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play104101014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104101014
		arg_56_1.duration_ = 6.8

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play104101015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				local var_59_0 = arg_56_1.bgs_.B13

				arg_56_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_59_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_59_1 = var_59_0:GetComponent("SpriteRenderer")

				if var_59_1 and var_59_1.sprite then
					local var_59_2 = 2 * (var_59_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_59_0.transform.localScale = Vector3.New(var_59_2 / var_59_1.sprite.bounds.size.y < var_59_2 * manager.ui.mainCameraCom_.aspect / var_59_1.sprite.bounds.size.x and var_59_2 * manager.ui.mainCameraCom_.aspect / var_59_1.sprite.bounds.size.x or var_59_2 / var_59_1.sprite.bounds.size.y, var_59_2 / var_59_1.sprite.bounds.size.y < var_59_2 * manager.ui.mainCameraCom_.aspect / var_59_1.sprite.bounds.size.x and var_59_2 * manager.ui.mainCameraCom_.aspect / var_59_1.sprite.bounds.size.x or var_59_2 / var_59_1.sprite.bounds.size.y, 0)
				end

				for iter_59_0, iter_59_1 in pairs(arg_56_1.bgs_) do
					if iter_59_0 ~= "B13" then
						iter_59_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				local var_59_3 = arg_56_1.bgs_.S0408a:GetComponent("SpriteRenderer")

				if var_59_3 then
					arg_56_1.var_.alphaOldValueS0408a = var_59_3.color.a
					arg_56_1.var_.alphaMatValueS0408a = var_59_3
				end

				arg_56_1.var_.alphaOldValueS0408a = 1
			end

			local var_59_4 = 1.5

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				if arg_56_1.var_.alphaMatValueS0408a then
					arg_56_1.var_.alphaMatValueS0408a.color.a = Mathf.Lerp(arg_56_1.var_.alphaOldValueS0408a, 0, (arg_56_1.time_ - 0) / var_59_4)
					arg_56_1.var_.alphaMatValueS0408a.color = arg_56_1.var_.alphaMatValueS0408a.color
				end
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 and arg_56_1.var_.alphaMatValueS0408a then
				arg_56_1.var_.alphaMatValueS0408a.color.a = 0
				arg_56_1.var_.alphaMatValueS0408a.color = arg_56_1.var_.alphaMatValueS0408a.color
			end

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				local var_59_5 = arg_56_1.bgs_.B13:GetComponent("SpriteRenderer")

				if var_59_5 then
					arg_56_1.var_.alphaOldValueB13 = var_59_5.color.a
					arg_56_1.var_.alphaMatValueB13 = var_59_5
				end

				arg_56_1.var_.alphaOldValueB13 = 0
			end

			local var_59_6 = 1.5

			if 1.5 <= arg_56_1.time_ and arg_56_1.time_ < 1.5 + var_59_6 then
				if arg_56_1.var_.alphaMatValueB13 then
					arg_56_1.var_.alphaMatValueB13.color.a = Mathf.Lerp(arg_56_1.var_.alphaOldValueB13, 1, (arg_56_1.time_ - 1.5) / var_59_6)
					arg_56_1.var_.alphaMatValueB13.color = arg_56_1.var_.alphaMatValueB13.color
				end
			end

			if arg_56_1.time_ >= 1.5 + var_59_6 and arg_56_1.time_ < 1.5 + var_59_6 + arg_59_0 and arg_56_1.var_.alphaMatValueB13 then
				arg_56_1.var_.alphaMatValueB13.color.a = 1
				arg_56_1.var_.alphaMatValueB13.color = arg_56_1.var_.alphaMatValueB13.color
			end

			local var_59_7 = arg_56_1.bgs_.S0408a.transform

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				arg_56_1.var_.moveOldPosS0408a = var_59_7.localPosition
			end

			local var_59_8 = 0.1

			if 1.5 <= arg_56_1.time_ and arg_56_1.time_ < 1.5 + var_59_8 then
				var_59_7.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPosS0408a, Vector3.New(0, -100, 0), (arg_56_1.time_ - 1.5) / var_59_8)
			end

			if arg_56_1.time_ >= 1.5 + var_59_8 and arg_56_1.time_ < 1.5 + var_59_8 + arg_59_0 then
				var_59_7.localPosition = Vector3.New(0, -100, 0)
			end

			local var_59_9 = 0

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			if arg_56_1.time_ >= var_59_9 + 1.8 and arg_56_1.time_ < var_59_9 + 1.8 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_10 = 1.8
			local var_59_11 = 0.2

			if 1.8 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_12 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_12:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_13 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(104101014).content)

				arg_56_1.text_.text = var_59_13

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 8 <= 0 and var_59_11 or var_59_11 * (utf8.len(var_59_13) / 8)

				if (8 <= 0 and var_59_11 or var_59_11 * (utf8.len(var_59_13) / 8)) > 0 and var_59_11 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15
					var_59_10 = var_59_10 + 0.3

					if var_59_15 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_10
					end
				end

				arg_56_1.text_.text = var_59_13
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = var_59_10 + 0.3
			local var_59_17 = math.max(var_59_11, arg_56_1.talkMaxDuration)

			if var_59_10 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_17 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_16) / var_59_17

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_16 + var_59_17 and arg_56_1.time_ < var_59_16 + var_59_17 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0408a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play104101015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 104101015
		arg_62_1.duration_ = 8.1

		local var_62_0 = {
			ja = 8.1,
			ko = 4.3,
			zh = 3.766,
			en = 5.133
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play104101016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if arg_62_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_65_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_62_1.stage_.transform)

				var_65_0.name = "1037ui_story"
				var_65_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.actors_["1037ui_story"] = var_65_0

				local var_65_1 = var_65_0:GetComponentInChildren(typeof(CharacterEffect))

				var_65_1.enabled = true

				local var_65_2 = GameObjectTools.GetOrAddComponent(var_65_0, typeof(DynamicBoneHelper))

				if var_65_2 then
					var_65_2:EnableDynamicBone(false)
				end

				arg_62_1:ShowWeapon(var_65_1.transform, false)

				arg_62_1.var_["1037ui_story" .. "Animator"] = var_65_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_62_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_62_1.var_["1037ui_story" .. "LipSync"] = var_65_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_65_3 = arg_62_1.actors_["1037ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_3) and arg_62_1.var_.characterEffect1037ui_story == nil then
				arg_62_1.var_.characterEffect1037ui_story = var_65_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_4 = 0.1

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 and not isNil(var_65_3) then
				if arg_62_1.var_.characterEffect1037ui_story and not isNil(var_65_3) then
					arg_62_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 and not isNil(var_65_3) and arg_62_1.var_.characterEffect1037ui_story then
				arg_62_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_65_6 = arg_62_1.actors_["1037ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1037ui_story = var_65_6.localPosition
			end

			local var_65_7 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				var_65_6.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_62_1.time_ - 0) / var_65_7)
				var_65_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_6.position).x, (manager.ui.mainCamera.transform.position - var_65_6.position).y, (manager.ui.mainCamera.transform.position - var_65_6.position).z)
				var_65_6.localEulerAngles.z = 0
				var_65_6.localEulerAngles.x = 0
				var_65_6.localEulerAngles = var_65_6.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				var_65_6.localPosition = Vector3.New(0, -1.09, -5.81)
				var_65_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_6.position).x, (manager.ui.mainCamera.transform.position - var_65_6.position).y, (manager.ui.mainCamera.transform.position - var_65_6.position).z)
				var_65_6.localEulerAngles.z = 0
				var_65_6.localEulerAngles.x = 0
				var_65_6.localEulerAngles = var_65_6.localEulerAngles
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_65_8 = 0
			local var_65_9 = 0.35

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_8 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_10 = arg_62_1:GetWordFromCfg(104101015)
				local var_65_11 = arg_62_1:FormatText(var_65_10.content)

				arg_62_1.text_.text = var_65_11

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_13 = 14 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 14)

				if (14 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 14)) > 0 and var_65_9 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_8
					end
				end

				arg_62_1.text_.text = var_65_11
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101015", "story_v_out_104101.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_out_104101", "104101015", "story_v_out_104101.awb") / 1000

					if var_65_14 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_8
					end

					if var_65_10.prefab_name ~= "" and arg_62_1.actors_[var_65_10.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_10.prefab_name].transform, "story_v_out_104101", "104101015", "story_v_out_104101.awb")

						arg_62_1:RecordAudio("104101015", var_65_15)
						arg_62_1:RecordAudio("104101015", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_104101", "104101015", "story_v_out_104101.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_104101", "104101015", "story_v_out_104101.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_9, arg_62_1.talkMaxDuration)

			if var_65_8 <= arg_62_1.time_ and arg_62_1.time_ < var_65_8 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_8) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_8 + var_65_16 and arg_62_1.time_ < var_65_8 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play104101016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 104101016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play104101017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1037ui_story"]) and arg_66_1.var_.characterEffect1037ui_story == nil then
				arg_66_1.var_.characterEffect1037ui_story = arg_66_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1037ui_story"]) then
				if arg_66_1.var_.characterEffect1037ui_story and not isNil(arg_66_1.actors_["1037ui_story"]) then
					arg_66_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_0)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1037ui_story"]) and arg_66_1.var_.characterEffect1037ui_story then
				arg_66_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_69_1 = 0
			local var_69_2 = 0.9

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_3 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(104101016).content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 36 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 36)

				if (36 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 36)) > 0 and var_69_2 < var_69_5 then
					arg_66_1.talkMaxDuration = var_69_5

					if var_69_5 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + var_69_1
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_6 = math.max(var_69_2, arg_66_1.talkMaxDuration)

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_6 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_1) / var_69_6

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_1 + var_69_6 and arg_66_1.time_ < var_69_1 + var_69_6 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play104101017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 104101017
		arg_70_1.duration_ = 3.13

		local var_70_0 = {
			ja = 3.133,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.2
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play104101018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1037ui_story"]) and arg_70_1.var_.characterEffect1037ui_story == nil then
				arg_70_1.var_.characterEffect1037ui_story = arg_70_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1037ui_story"]) then
				if arg_70_1.var_.characterEffect1037ui_story and not isNil(arg_70_1.actors_["1037ui_story"]) then
					arg_70_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1037ui_story"]) and arg_70_1.var_.characterEffect1037ui_story then
				arg_70_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_73_2 = 0
			local var_73_3 = 0.125

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_2 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_4 = arg_70_1:GetWordFromCfg(104101017)
				local var_73_5 = arg_70_1:FormatText(var_73_4.content)

				arg_70_1.text_.text = var_73_5

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_7 = 5 <= 0 and var_73_3 or var_73_3 * (utf8.len(var_73_5) / 5)

				if (5 <= 0 and var_73_3 or var_73_3 * (utf8.len(var_73_5) / 5)) > 0 and var_73_3 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_2 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_2
					end
				end

				arg_70_1.text_.text = var_73_5
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101017", "story_v_out_104101.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_104101", "104101017", "story_v_out_104101.awb") / 1000

					if var_73_8 + var_73_2 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_2
					end

					if var_73_4.prefab_name ~= "" and arg_70_1.actors_[var_73_4.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_4.prefab_name].transform, "story_v_out_104101", "104101017", "story_v_out_104101.awb")

						arg_70_1:RecordAudio("104101017", var_73_9)
						arg_70_1:RecordAudio("104101017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_104101", "104101017", "story_v_out_104101.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_104101", "104101017", "story_v_out_104101.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_3, arg_70_1.talkMaxDuration)

			if var_73_2 <= arg_70_1.time_ and arg_70_1.time_ < var_73_2 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_2) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_2 + var_73_10 and arg_70_1.time_ < var_73_2 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play104101018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 104101018
		arg_74_1.duration_ = 11.03

		local var_74_0 = {
			ja = 9.8,
			ko = 6.9,
			zh = 8.3,
			en = 11.033
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play104101019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_77_0 = 0
			local var_77_1 = 0.975

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_2 = arg_74_1:GetWordFromCfg(104101018)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 39 <= 0 and var_77_1 or var_77_1 * (utf8.len(var_77_3) / 39)

				if (39 <= 0 and var_77_1 or var_77_1 * (utf8.len(var_77_3) / 39)) > 0 and var_77_1 < var_77_5 then
					arg_74_1.talkMaxDuration = var_77_5

					if var_77_5 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101018", "story_v_out_104101.awb") ~= 0 then
					local var_77_6 = manager.audio:GetVoiceLength("story_v_out_104101", "104101018", "story_v_out_104101.awb") / 1000

					if var_77_6 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_0
					end

					if var_77_2.prefab_name ~= "" and arg_74_1.actors_[var_77_2.prefab_name] ~= nil then
						local var_77_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_2.prefab_name].transform, "story_v_out_104101", "104101018", "story_v_out_104101.awb")

						arg_74_1:RecordAudio("104101018", var_77_7)
						arg_74_1:RecordAudio("104101018", var_77_7)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_104101", "104101018", "story_v_out_104101.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_104101", "104101018", "story_v_out_104101.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_8 and arg_74_1.time_ < var_77_0 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play104101019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 104101019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play104101020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1037ui_story"]) and arg_78_1.var_.characterEffect1037ui_story == nil then
				arg_78_1.var_.characterEffect1037ui_story = arg_78_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1037ui_story"]) then
				if arg_78_1.var_.characterEffect1037ui_story and not isNil(arg_78_1.actors_["1037ui_story"]) then
					arg_78_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_0)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1037ui_story"]) and arg_78_1.var_.characterEffect1037ui_story then
				arg_78_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_81_1 = 0
			local var_81_2 = 0.725

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

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_3 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(104101019).content)

				arg_78_1.text_.text = var_81_3

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 29 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_3) / 29)

				if (29 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_3) / 29)) > 0 and var_81_2 < var_81_5 then
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
	Play104101020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 104101020
		arg_82_1.duration_ = 3.67

		local var_82_0 = {
			ja = 3.666,
			ko = 3.333,
			zh = 2.766,
			en = 3
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
			arg_82_1.auto_ = false
		end

		function arg_82_1.playNext_(arg_84_0)
			arg_82_1.onStoryFinished_()
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.3

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_1 = arg_82_1:GetWordFromCfg(104101020)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 12 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 12)

				if (12 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 12)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101020", "story_v_out_104101.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_104101", "104101020", "story_v_out_104101.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_104101", "104101020", "story_v_out_104101.awb")

						arg_82_1:RecordAudio("104101020", var_85_6)
						arg_82_1:RecordAudio("104101020", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_104101", "104101020", "story_v_out_104101.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_104101", "104101020", "story_v_out_104101.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/S0408",
		"TextureConfig/Background/S0408a"
	},
	voices = {
		"story_v_out_104101.awb"
	}
}
